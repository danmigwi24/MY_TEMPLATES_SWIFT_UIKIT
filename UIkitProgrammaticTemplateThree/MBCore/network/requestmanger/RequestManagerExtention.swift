//
//  RequestManagerExtention.swift
//  MBCore
//
//  Created by Daniel Kimani on 28/02/2024.
//

import Foundation


extension RequestManager {
    //MARK: RSA
    func rsaReqResponseHandler<T:Codable>(config:Config,endpoint:String,model:T?,completion:@escaping(String?,String?)->Void){
        guard let request = self.requestRsaHandler(config: config, endpoint: endpoint, payload: model) else {
            completion(nil,errorMessage(err: Error.self as? Error))
            return
        }
        let task = self.requestsSession.dataTask(with: request) { data, response, error in
            //Decrypt
            let (responseString,err) = self.digestRSAResponse(data, response, error, config)
            guard let responseString = responseString, err == nil else {
                AppUtils.Log(from: self, with: "ERROR \(err ?? "")")
                completion(nil,err)
                return
            }
            
            completion(responseString,nil)
            
        }
        task.resume()
    }
    
    //MARK: RSA  HELPER METHODS
    private func requestRsaHandler<T:Codable>(config:Config,endpoint:String,payload: T?) -> URLRequest? {
        do{
            guard var request = defaultRequest(token: nil, endUrl: endpoint, payload: payload) else {
                return nil
            }
            
            //Apply Encryption
            guard let encrypted = Encryptor.EncryptRSA(try JSONEncoder().encode(payload), cryptoConfig: config.cryptoConfig),
                  let content = String(data:encrypted,encoding: .utf8) else{
                return nil
            }
            
            request.httpBody = encrypted
            
            return request
        }catch {
            print(error.localizedDescription)
            return nil
        }
    }
    

    
    private func digestRSAResponse(_ data:Data?, _ response:URLResponse?, _ error:Error?, _ config:Config) ->(String?,String?) {
        let (dataString, err) = defaultResponse(data, response, error, config)
        
        guard let decodedString = dataString?.decodeFromBase64String() else {
            return (nil, "Failed")
        }
        
        AppUtils.Log(from:self,with:"[digestRSAResponse()] RESPONSE IS : \n \(decodedString)")
   
        
        guard  let handShakeResponse = parseStringToJson(string: decodedString ,type: HandShakeResponse.self) else {
            return (nil, "Failed")
        }
        
        //let iv = decodeDataToGetIv(from: dS) ?? ""
        let aesKeyRes = handShakeResponse.data.x

        //
        let decryptedData = aesKeyRes.decryptedRSA(enKey: config.cryptoConfig.rsaKey)
        print("Decrypted message: \(decryptedData)")
    
        return (decryptedData, nil)
    }
    

    //MARK: AES
    
    /*********************************************************************************************************************************************************************************************************************/
    func aesReqResponseHandler<T:Codable>(token:String?,config:Config,endpoint:String,model:T?,completion:@escaping(String?,String?)->Void){
        guard let request = self.requestAesHandler(token: token, config: config, endUrl: endpoint, payload: model) else {
            completion(nil,config.messages.serviceError)
            return
        }
        let task = self.requestsSession.dataTask(with: request) { data, response, error in
            //Decrypt
            let (responseString,err) = self.digestAESResponse(data, response, error, config)
            
            guard let responseString = responseString, err == nil else {
                completion(nil,err)
                return
            }
            
            completion(responseString,nil)
        }
        task.resume()
    }


    //MARK: AES  HELPER METHODS
    private  func requestAesHandler<T:Codable>(token:String?,config:Config,endUrl:String,payload: T?) -> URLRequest? {
        guard var request = defaultRequest(token: token, endUrl: endUrl, payload: payload) else {
            return nil
        }

        //Apply Encryption
        let iv = AppUtils().getGenerateAESIV()
        let aesKey = getUserData(key: USERDEFAULTS.AES_KEY)
        //
        let dataToEncrypt =  String(data:try! JSONEncoder().encode(payload),encoding: .utf8) ?? ""
        //
        let encryptedBase64String = dataToEncrypt.encryptAESGCMNOPADDING(iv:iv , aesKey: aesKey)
        
        /*
        guard let encrypted = Encryptor.EncryptAES(dataToEncrypt, cryptoConfig: config.cryptoConfig),
                let content = String(data:encrypted,encoding: .utf8) else{
            return nil
        }
        */
        
        //
        var contentWrapper = ContentWrapper()
        contentWrapper.payload = encryptedBase64String
        contentWrapper.iv = iv
        let contentWrapperBase64 = try! JSONEncoder().encode(contentWrapper).base64EncodedString(options: [])
        //
        print("contentWrapperBase64 \n\(contentWrapperBase64)\n")
        var payloadWrapper = PayloadWrapper()
        payloadWrapper.content = contentWrapperBase64
        payloadWrapper.sessionId = AppUtils().getGeenerateSessionID()
        let payloadWrapperBase64 = try! JSONEncoder().encode(payloadWrapper).base64EncodedString(options: [])
        //
        print("payloadWrapperBase64 \n\(payloadWrapperBase64)\n")
        //
        request.httpBody = payloadWrapperBase64.data(using: .utf8)
        return request
    }
    
    //
    private  func digestAESResponse(_ data:Data?, _ response:URLResponse?, _ error:Error?, _ config:Config) ->(String?,String?) {
        let (dataString, err) = defaultResponse(data, response, error, config)
        
        guard let stringToDecrypt = dataString,
              err == nil else{
            return (nil,err)
        }
        //
        let decodedPayloadWrapper = stringToDecrypt.decodeFromBase64String()
        let payloadWrapper = parseStringToJson(string: decodedPayloadWrapper, type: PayloadWrapper.self)
        //
        print("decodedPayloadWrapper \n\(decodedPayloadWrapper)\n")
        print("payloadWrapper \n\(payloadWrapper)\n")
        //
        let decodedContentWrapper = (payloadWrapper?.content ?? "").decodeFromBase64String()
        let contentWrapper = parseStringToJson(string: decodedContentWrapper, type: ContentWrapper.self)
        //
        print("decodedContentWrapper \n\(decodedContentWrapper)\n")
        print("contentWrapper \n\(contentWrapper)\n")
        //
        let iv = contentWrapper?.iv ?? ""//getGenerateAESIV()
        let aesKey = getUserData(key: USERDEFAULTS.AES_KEY)
        //
        let  decryptedString = (contentWrapper?.payload ?? "" ).decryptedAESGCMNOPADDING(iv:iv , aesKey: aesKey)
        
        print("decryptedString \n\(decryptedString)\n")
        /*
        guard let decryptedString = Encryptor.decryptAES(stringToDecrypt, cryptoConfig: config.cryptoConfig) else {
            return (nil,config.messages.serviceError)
        }
         */
        
        return (decryptedString,nil)
        
    }
    
    
    /*********************************************************************************************************************************************************************************************************************/
    
    //MARK: Defaults HELPER METHODS
    //DEFAULT REQUEST
    private func defaultRequest<T:Codable>(token:String?,endUrl:String,payload: T?, requestMethod:String? = "POST") -> URLRequest? {
        guard let url = self.constructFullUrl(value: endUrl) else {
            return nil
        }
        var request = composeRequest(url, requestMethod ?? "POST" , token);
        if let token = token{
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        //
        if let headers = request.allHTTPHeaderFields {
            for (key, value) in headers {
                AppUtils.Log(from:self,with:"HEADERS>>>>>>>>>>>> \(key): \(value)")
            }
        }
        AppUtils.Log(from:self,with:"RAW BODY===> \(String(data:try! JSONEncoder().encode(payload),encoding: .utf8)!)")
        
        return request
    }
    
    func constructFullUrl(value:String) -> URL? {
        return URL(string: "\(router.BASE_PATH)/\(value)") //https://test-api.ekenya.co.ke/mobile-banking
        //return URL(string: "https://test-api.ekenya.co.ke/mobile-banking/\(value)")
    }
    
  
    
    
    //MARK: DEFAULT response
    private func defaultResponse(_ data:Data?, _ response:URLResponse?, _ error:Error?, _ config:Config) ->(String?,String?) {
        guard let data = data, error == nil else {
            
            return (nil,RequestManager().errorMessage(err: error))
        }
        if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
            // check for http errors
            AppUtils.Log(from:self,with:"statusCode should be 200, but is \(httpStatus.statusCode)")
            AppUtils.Log(from:self,with:"Error is ====>   \(String(describing: String(data: data, encoding: String.Encoding.utf8)))")
            return (nil,getMessageFromRespCode(code: httpStatus.statusCode))
        }else{
            let responseString = String(data: data, encoding: .utf8)
            guard let res = responseString else {
                AppUtils.Log(from:self,with:"ERRROR VALUE is \(error?.localizedDescription ?? "")")
                return (nil,config.messages.serviceError)
            }
            AppUtils.Log(from:self,with:"[defaultResponse()] RESPONSE IS AVAILABLE")
            
            return (res,nil)
        }
        
    }
    
    
    private func getMessageFromRespCode(code:Int)->String{
        if (code == 401) {
            return "expired token"
        } else if (code == 400) {
            return "\(code) Bad Request :The request cannot be fulfilled due to bad syntax."
        } else if (400...499 ~= code) {
            return "Error creating connection please try again"
        } else if (500...599 ~= code) {
            return "We are having an issue accessing our servers please try again later"
        }else if (code == -1009) {
            return "Please check your internet connection and try again"
        } else {
            return "Unexpected error occurred"
        }
    }
    
    
    //MARK:- Default behaviour for digest Response
    func errorMessage(err:Error?) -> String? {
        if let err = err?.localizedDescription {
            AppUtils.Log(from:self,with:"ERRROR VALUE is \(err)")
            return err
        }else{
            return "Dear customer,An error occured, Please try again later. Thank you!"
        }
    }
    
}


//
extension RequestManager: URLSessionDelegate{
    //MARK: Hook SSL Pinning Module
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Swift.Void) {
        SecurityServiceImpl.Shared.handleSSLPinning(challenge, completionHandler: completionHandler)
        
        // completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
}
