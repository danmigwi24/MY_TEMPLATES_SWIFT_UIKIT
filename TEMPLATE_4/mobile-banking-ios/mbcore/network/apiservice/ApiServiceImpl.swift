//
//  AuthServiceImpl.swift
//  AppCore
//
//  Created by  Daniel Kimani on 6/15/21.
//

import Foundation
import UIKit
import SwiftKeychainWrapper
import Combine


extension RequestManager:ApiService {
    //MARK: Handshake
    public func makeHandshake(requestBody model: HandshakeRequest,completion: @escaping (Bool,String?) -> Void)  {
        guard let config = self.config else { completion(false,APP_CONFIG_ERROR)
            return
        }
        
        self.rsaReqResponseHandler(
            config: config,
            endpoint:"api/v1/mbs/handshake",
            model: model
        ){ resToDecode, err in
            
            guard let responseString = resToDecode else {
                completion(false,err)
                return
            }
            
            
            guard let model = parseStringToJson(string: responseString, type: GetAESKeyResponse.self) else {
                completion(false,config.messages.serviceError)
                return
            }
            
            guard let status =  model.status ?? nil  else {
                completion(false,config.messages.serviceError)
                return
            }
            
            if status == "00"{
                completion(true ,"\(model.message ?? "")")
                
                ///*
                if let str = model.data {
                    AppUtils.Log(from:self,with:"AES KEY FOUND \(str.y ?? "")")
                    //Update Key
                    self.config?.cryptoConfig.aesKey = str.y ?? ""
                    
                    saveUserData(key: USERDEFAULTS.AES_KEY, data: str.y ?? "")
                }else{
                    AppUtils.Log(from:self,with:"AES KEY NOT FOUND")
                }
                //*/
                
            }else{
                completion(false,config.messages.serviceError)
            }
            
            
            
        }
    }
    
    //MARK: - Account Look up
    public func accountLookUp(requestBody: AccountLookupRequest,  completion: @escaping (Bool, String? ,AccountLookUpResponse?) -> Void) {
        /**@self.config - return  everything stored in the Config.plist file....**/
        
        let globalRequest:GlobalRequestPayload<AccountLookupRequest> = GlobalRequestPayload(payload: requestBody)
        //
        print("GlobalRequest \(globalRequest)")
        //
        print("AES KEY IS : \(getUserData(key: USERDEFAULTS.AES_KEY))")
        print("SESSION_ID IS : \(getUserData(key: USERDEFAULTS.SESSION_ID))")
        print("GENERATED_IV IS : \(getUserData(key: USERDEFAULTS.GENERATED_IV))")
        //
        guard let config = self.config else{
            completion(false,APP_CONFIG_ERROR,nil)
            return
        }
        //
        aesReqResponseHandler(
            token: nil,
            config: config,
            endpoint: "api/v1/mbs/wallet/lookup",
            model: globalRequest
        ) { resToDecode, err in
            guard let responseString = resToDecode else {
                completion(false,err,nil)
                return
            }
            ///*
            guard let model = parseStringToJson(string: responseString, type: AccountLookUpResponse.self) else {
                completion(false,config.messages.serviceError,nil)
                return
            }
            //00 -> Mobile Activation
            //05-> Device verify
            //06-> Login
            //10-> AccountLookup Failed -> Wallet creation
            
            
            guard let status =  model.status ?? nil  else {
                completion(false,config.messages.serviceError,nil)
                return
            }
            
            completion(true,"\(model.message ?? "")",model)
        }
    }
    
    //MARK: - verifyDevice
    public func verifyDevice(requestBody: DeviceVerificationRequest,  completion: @escaping (Bool, String?,CommonResponse?) -> Void) {
        /**@self.config - return  everything stored in the Config.plist file....**/
        
        let globalRequest:GlobalRequestPayload<DeviceVerificationRequest> = GlobalRequestPayload(payload: requestBody)
        //
        print("GlobalRequest \(globalRequest)")
        //
        print("AES KEY IS : \(getUserData(key: USERDEFAULTS.AES_KEY))")
        print("SESSION_ID IS : \(getUserData(key: USERDEFAULTS.SESSION_ID))")
        print("GENERATED_IV IS : \(getUserData(key: USERDEFAULTS.GENERATED_IV))")
        //
        guard let config = self.config else{
            completion(false,APP_CONFIG_ERROR,nil)
            return
        }
        //
        aesReqResponseHandler(
            token: nil,
            config: config,
            endpoint: "api/v1/mb/customer/verify-otp",
            model: globalRequest
        ) { resToDecode, err in
            
            guard let responseString = resToDecode else {
                completion(false,err,nil)
                return
            }
            ///*
            guard let model = parseStringToJson(string: responseString, type: CommonResponse.self) else {
                completion(false,config.messages.serviceError,nil)
                return
            }
            
            //00 -> Mobile Activation
            //05-> Device verify
            //06-> Login
            //10-> AccountLookup Failed -> Wallet creation
            
            
            guard let status =  model.status ?? nil  else {
                completion(false,config.messages.serviceError,nil)
                return
            }
            
            completion(true,"\(model.message ?? "")",model)
        }
    }
    
    //MARK: - Resend OTP
    public func resendOtp(requestBody: ResendVerificationRequest,  completion: @escaping (Bool, String?,CommonResponse?) -> Void) {
        /**@self.config - return  everything stored in the Config.plist file....**/
        
        let globalRequest:GlobalRequestPayload<ResendVerificationRequest> = GlobalRequestPayload(payload: requestBody)
        //
        print("GlobalRequest \(globalRequest)")
        //
        print("AES KEY IS : \(getUserData(key: USERDEFAULTS.AES_KEY))")
        print("SESSION_ID IS : \(getUserData(key: USERDEFAULTS.SESSION_ID))")
        print("GENERATED_IV IS : \(getUserData(key: USERDEFAULTS.GENERATED_IV))")
        //
        guard let config = self.config else{
            completion(false,APP_CONFIG_ERROR,nil)
            return
        }
        //
        aesReqResponseHandler(
            token: nil,
            config: config,
            endpoint: "api/v1/mb/customer/resend-otp",
            model: globalRequest
        ) { resToDecode, err in
            
            guard let responseString = resToDecode else {
                completion(false,err,nil)
                return
            }
            ///*
            guard let model = parseStringToJson(string: responseString, type: CommonResponse.self) else {
                completion(false,config.messages.serviceError,nil)
                return
            }
            
            //00 -> Mobile Activation
            //05-> Device verify
            //06-> Login
            //10-> AccountLookup Failed -> Wallet creation
            
            
            guard let status =  model.status ?? nil  else {
                completion(false,config.messages.serviceError,nil)
                return
            }
            
            completion(true,"\(model.message ?? "")",model)
        }
    }
    
    //MARK: - Login request
    public func loginRequest(requestBody: LoginRequest,  completion: @escaping (Bool, String?,LoginResponse?) -> Void) {
        //
        let globalRequest:GlobalRequestPayload<LoginRequest> = GlobalRequestPayload(payload: requestBody)
        //
        print("GlobalRequest \(globalRequest)")
        //
        print("AES KEY IS : \(getUserData(key: USERDEFAULTS.AES_KEY))")
        print("SESSION_ID IS : \(getUserData(key: USERDEFAULTS.SESSION_ID))")
        print("GENERATED_IV IS : \(getUserData(key: USERDEFAULTS.GENERATED_IV))")
        //
        guard let config = self.config else{ completion(false,APP_CONFIG_ERROR,nil)
            return
        }
        //
        aesReqResponseHandler(
            token: nil,
            config: config,
            endpoint: "api/v1/mbs/auth/login",
            model: globalRequest
        ) { resToDecode, err in
            
            guard let responseString = resToDecode else {
                completion(false,err,nil)
                return
            }
            
            guard let response = parseStringToJson(string: responseString, type: LoginResponse.self) else {
                completion(false,config.messages.serviceError,nil)
                return
            }
            
            guard let token =  response.data.accessToken ?? nil  else {
                completion(false,config.messages.serviceError,nil)
                return
            }
            
            self.setToken(token: token)
            
            completion(true ,"\(response.message ?? "")",response)
            
//            if status == "06"{
//                completion(true ,"\(model.message ?? "")")
//            }else{
//                completion(false,"\(model.message ?? "")")
//            }
            
            
        }
    }
    
    //MARK: - WalletActivation
    public func accountWalletActivation(requestBody: AccountWalletActivationRequest,  completion: @escaping (Bool, String?,CommonResponse?) -> Void) {
        /**@self.config - return  everything stored in the Config.plist file....**/
        
        let globalRequest:GlobalRequestPayload<AccountWalletActivationRequest> = GlobalRequestPayload(payload: requestBody)
        //
        print("GlobalRequest \(globalRequest)")
        //
        print("AES KEY IS : \(getUserData(key: USERDEFAULTS.AES_KEY))")
        print("SESSION_ID IS : \(getUserData(key: USERDEFAULTS.SESSION_ID))")
        print("GENERATED_IV IS : \(getUserData(key: USERDEFAULTS.GENERATED_IV))")
        //
        guard let config = self.config else{
            completion(false,APP_CONFIG_ERROR,nil)
            return
        }
        //
        aesReqResponseHandler(
            token: nil,
            config: config,
            endpoint: "api/v1/mb/customer/activate-mb",
            model: globalRequest
        ) { resToDecode, err in
            
            guard let responseString = resToDecode else {
                completion(false,err,nil)
                return
            }
            ///*
            guard let model = parseStringToJson(string: responseString, type: CommonResponse.self) else {
                completion(false,config.messages.serviceError,nil)
                return
            }
            
            //00 -> Mobile Activation
            //05-> Device verify
            //06-> Login
            //10-> AccountLookup Failed -> Wallet creation
            
            
            guard let status =  model.status ?? nil  else {
                completion(false,config.messages.serviceError,nil)
                return
            }
            
            completion(true,"\(model.message ?? "")",model)
        }
    }
    
    //MARK: - CREATE NEW PIN
    public func createNewPin(requestBody: CreateNewPinRequest,  completion: @escaping (Bool, String?,CommonResponse?) -> Void) {
        /**@self.config - return  everything stored in the Config.plist file....**/
        
        let globalRequest:GlobalRequestPayload<CreateNewPinRequest> = GlobalRequestPayload(payload: requestBody)
        //
        print("GlobalRequest \(globalRequest)")
        //
        print("AES KEY IS : \(getUserData(key: USERDEFAULTS.AES_KEY))")
        print("SESSION_ID IS : \(getUserData(key: USERDEFAULTS.SESSION_ID))")
        print("GENERATED_IV IS : \(getUserData(key: USERDEFAULTS.GENERATED_IV))")
        //
        guard let config = self.config else{
            completion(false,APP_CONFIG_ERROR,nil)
            return
        }
        
        guard let token = RequestManager.ApiInstance.authTokenItem?.Token else{
            AppUtils.Log(from:self,with:"Unable to get token >>>>>>>>>>>>>>>>> :: ")
            completion(false,"expired token",nil)
            return
        }
        
        //
        aesReqResponseHandler(
            token: token,
            config: config,
            endpoint: "api/v1/mb/customer/reset-password",
            model: globalRequest
        ) { resToDecode, err in
            
            guard let responseString = resToDecode else {
                completion(false,err,nil)
                return
            }
            ///*
            guard let model = parseStringToJson(string: responseString, type: CommonResponse.self) else {
                completion(false,config.messages.serviceError,nil)
                return
            }
            
            //00 -> Mobile Activation
            //05-> Device verify
            //06-> Login
            //10-> AccountLookup Failed -> Wallet creation
            
            
            guard let status =  model.status ?? nil  else {
                completion(false,config.messages.serviceError,nil)
                return
            }
            
            completion(true,"\(model.message ?? "")",model)
        }
    }

    //MARK: - PANIC PIN
    public func setPanicPin(requestBody: CreateNewPinRequest,  completion: @escaping (Bool, String?,CommonResponse?) -> Void) {
        /**@self.config - return  everything stored in the Config.plist file....**/
        
        let globalRequest:GlobalRequestPayload<CreateNewPinRequest> = GlobalRequestPayload(payload: requestBody)
        //
        print("GlobalRequest \(globalRequest)")
        //
        print("AES KEY IS : \(getUserData(key: USERDEFAULTS.AES_KEY))")
        print("SESSION_ID IS : \(getUserData(key: USERDEFAULTS.SESSION_ID))")
        print("GENERATED_IV IS : \(getUserData(key: USERDEFAULTS.GENERATED_IV))")
        //
        guard let config = self.config else{
            completion(false,APP_CONFIG_ERROR,nil)
            return
        }
        //
        aesReqResponseHandler(
            token: nil,
            config: config,
            endpoint: "api/v1/mb/customer/activate-mb",
            model: globalRequest
        ) { resToDecode, err in
            
            guard let responseString = resToDecode else {
                completion(false,err,nil)
                return
            }
            ///*
            guard let model = parseStringToJson(string: responseString, type: CommonResponse.self) else {
                completion(false,config.messages.serviceError,nil)
                return
            }
            
            //00 -> Mobile Activation
            //05-> Device verify
            //06-> Login
            //10-> AccountLookup Failed -> Wallet creation
            
            
            guard let status =  model.status ?? nil  else {
                completion(false,config.messages.serviceError,nil)
                return
            }
            
            completion(true,"\(model.message ?? "")",model)
        }
    }
  
    //MARK: - MINIMUM DEPOSIT
    public func minimumDeposit(requestBody: CreateNewPinRequest,  completion: @escaping (Bool, String?,CommonResponse?) -> Void) {
        /**@self.config - return  everything stored in the Config.plist file....**/
        
        let globalRequest:GlobalRequestPayload<CreateNewPinRequest> = GlobalRequestPayload(payload: requestBody)
        //
        print("GlobalRequest \(globalRequest)")
        //
        print("AES KEY IS : \(getUserData(key: USERDEFAULTS.AES_KEY))")
        print("SESSION_ID IS : \(getUserData(key: USERDEFAULTS.SESSION_ID))")
        print("GENERATED_IV IS : \(getUserData(key: USERDEFAULTS.GENERATED_IV))")
        //
        guard let config = self.config else{
            completion(false,APP_CONFIG_ERROR,nil)
            return
        }
        //
        aesReqResponseHandler(
            token: nil,
            config: config,
            endpoint: "api/v1/mb/customer/activate-mb",
            model: globalRequest
        ) { resToDecode, err in
            
            guard let responseString = resToDecode else {
                completion(false,err,nil)
                return
            }
            ///*
            guard let model = parseStringToJson(string: responseString, type: CommonResponse.self) else {
                completion(false,config.messages.serviceError,nil)
                return
            }
            
            //00 -> Mobile Activation
            //05-> Device verify
            //06-> Login
            //10-> AccountLookup Failed -> Wallet creation
            
            
            guard let status =  model.status ?? nil  else {
                completion(false,config.messages.serviceError,nil)
                return
            }
            
            completion(true,"\(model.message ?? "")",model)
        }
    }
  
    //MARK: - GET SECURITY QUESTIONS
    public func getSecurityQuestions(requestBody: GetSecurityQuestionRequest,  completion: @escaping (Bool, String?,GetSecurityQuestionsResponse?) -> Void) {
        /**@self.config - return  everything stored in the Config.plist file....**/
        
        let globalRequest:GlobalRequestPayload<GetSecurityQuestionRequest> = GlobalRequestPayload(payload: requestBody)
        //
        print("GlobalRequest \(globalRequest)")
        //
        print("AES KEY IS : \(getUserData(key: USERDEFAULTS.AES_KEY))")
        print("SESSION_ID IS : \(getUserData(key: USERDEFAULTS.SESSION_ID))")
        print("GENERATED_IV IS : \(getUserData(key: USERDEFAULTS.GENERATED_IV))")
        //
        guard let config = self.config else{
            completion(false,APP_CONFIG_ERROR,nil)
            return
        }
        
        guard let token = RequestManager.ApiInstance.authTokenItem?.Token else{
            AppUtils.Log(from:self,with:"Unable to get token >>>>>>>>>>>>>>>>> :: ")
            completion(false,"expired token",nil)
            return
        }
        
        //
        aesReqResponseHandler(
            token: token,
            config: config,
            endpoint: "api/v1/mb/customer/all-security-questions",
            model: globalRequest
        ) { resToDecode, err in
            
            guard let responseString = resToDecode else {
                completion(false,err,nil)
                return
            }
            ///*
            guard let model = parseStringToJson(string: responseString, type: GetSecurityQuestionsResponse.self) else {
                completion(false,config.messages.serviceError,nil)
                return
            }
            
            //00 -> Mobile Activation
            //05-> Device verify
            //06-> Login
            //10-> AccountLookup Failed -> Wallet creation
            
            
            guard let status =  model.status ?? nil  else {
                completion(false,config.messages.serviceError,nil)
                return
            }
            
            completion(true,"\(model.message ?? "")",model)
        }
    }
    
    //MARK: - SET SECURITY QUESTIONS
    public func setSecurityQuestions(requestBody: AnsweredQuestionsDto,  completion: @escaping (Bool, String?,CommonResponse?) -> Void) {
        /**@self.config - return  everything stored in the Config.plist file....**/
        
        let globalRequest:GlobalRequestPayload<AnsweredQuestionsDto> = GlobalRequestPayload(payload: requestBody)
        //
        print("GlobalRequest \(globalRequest)")
        //
        print("AES KEY IS : \(getUserData(key: USERDEFAULTS.AES_KEY))")
        print("SESSION_ID IS : \(getUserData(key: USERDEFAULTS.SESSION_ID))")
        print("GENERATED_IV IS : \(getUserData(key: USERDEFAULTS.GENERATED_IV))")
        //
        guard let config = self.config else{
            completion(false,APP_CONFIG_ERROR,nil)
            return
        }
        //
        aesReqResponseHandler(
            token: nil,
            config: config,
            endpoint: "api/v1/mb/customer/activate-mb",
            model: globalRequest
        ) { resToDecode, err in
            
            guard let responseString = resToDecode else {
                completion(false,err,nil)
                return
            }
            ///*
            guard let model = parseStringToJson(string: responseString, type: CommonResponse.self) else {
                completion(false,config.messages.serviceError,nil)
                return
            }
            
            //00 -> Mobile Activation
            //05-> Device verify
            //06-> Login
            //10-> AccountLookup Failed -> Wallet creation
            
            
            guard let status =  model.status ?? nil  else {
                completion(false,config.messages.serviceError,nil)
                return
            }
            
            completion(true,"\(model.message ?? "")",model)
        }
    }
  
    
    
    
    
    
    
    
    
    
    //MARK: ACCOUNT OPENNING
    public func postAccountOpeningRequestWithImages(
        requestBody: AccountOpeningRequest,
        selectedImages: [UIImage]?,
        mapImage: UIImage?,
        handleCompletion: @escaping (Bool, String?) -> Void
    ) {
        let globalRequest:GlobalRequestData<AccountOpeningRequest> = GlobalRequestData(data: requestBody)
        
        // Encode the struct to a JSON string
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        
        guard let jsonData = try? jsonEncoder.encode(globalRequest),
              let jsonString = String(data: jsonData, encoding: .utf8) else {
            handleCompletion(false,"Failed to encode the struct to JSON string.")
            return
        }
        
        Logger("REQUEST IS : \(jsonString)")
        Logger("SELECTED_IMAGES  COUNT IS : \(selectedImages?.count)")
        Logger("SELECTED_IMAGES IS : \(selectedImages)")
        Logger("MAP_IMAGES IS : \(mapImage)")
        
        guard let config = self.config else{
            handleCompletion(false,APP_CONFIG_ERROR)
            return
        }
        
        //guard let url = URL(string: "")
        guard let url = self.constructFullUrl(value: "api/v1/mbs/on-board/new")
        else {
            handleCompletion(false, "Invalid URL")
            return
        }
        
        
        
        let request = MultipartFormDataRequest(url: url)
        request.addTextField(named: "data", value: jsonString)
        //
        
        //
        if mapImage != nil {
            guard let imageData = mapImage?.jpegData(compressionQuality: 0.5) else{return}
            request.addDataField(named: "map", data: imageData, mimeType: "image/jpeg")
        }
        ///*
        if selectedImages?.count != 0 {
            for (index, image) in (selectedImages ?? []).enumerated() {
                guard let imageData = image.jpegData(compressionQuality: 0.5) else {
                    Logger("Failed to send image")
                    //throw ImageUploadError.invalidImageData
                    return
                }
                Logger("SEND IMAGES ARE \(image) \(index)")
                
                request.addDataField(named: "images", data: imageData, mimeType: "image/jpeg")
                
            }
        }
        //*/
        //MARK: Create a custom URLSessionConfiguration with an increased timeout interval
        let uRLSessionConfiguration = URLSessionConfiguration.default
        uRLSessionConfiguration.timeoutIntervalForRequest = 60 // Increase the timeout to 60 seconds (adjust as needed)
        
        // Create a custom URLSession using the configuration
        let customSession = URLSession(configuration: uRLSessionConfiguration)
        
        customSession.dataTaskPublisher(for: request.asURLRequest())
        //.map(\.data)
            .tryMap(handleURLSessionOutput)
            .compactMap { String(data: $0, encoding: .utf8) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    Logger("SUCCESS ")
                    handleCompletion(true, nil)
                    //break
                case .failure(let error):
                    Logger("API request failed: \(error)")
                    handleCompletion(false,config.messages.serviceError)
                }
            }, receiveValue: { [weak self] response in
                Logger(response)
                
                Logger("SUCCESS ")
                handleCompletion(true, response)
            })
    }
    
    
    
    //MARK: ---------------------------------------------------------------------------------------------------------
    //MARK: CUSTOM FUNCTIONS
    public func setToken(token:String){
        let tokenItem = AuthTokenItem()
        tokenItem.Token = token
        tokenItem.RefreshToken = token
        RequestManager.ApiInstance.authTokenItem = tokenItem
    }
    
    public func isEnabledServices(_ serviceCode:String) ->Bool{
        //
        for e in enabledServices {
            //
            if e.code.lowercased() == serviceCode.lowercased() {
                return e.active
            }
        }
        //Default
        return true
    }
    
    public func checkRuntime(_ completion: @escaping (Bool, String?) -> Void) {
        guard let config = self.config else{
            completion(false,APP_CONFIG_ERROR)
            return
        }
        //if isruntimerooted is false, we continue to check for simulator(thats why we negiate its value since guard execute false value on else block
        if(self.SecService.isRuntimeRooted()) {
            completion(false,config.messages.deviceRootError)
            return
        }
#if !DEBUG
        guard  !self.SecService.isRuntimeSimulated() else{
            completion(false,config.messages.deviceSimulationError)
            return
        }
#endif
        
        completion(true,nil)
    }
    
    
    
    
}
