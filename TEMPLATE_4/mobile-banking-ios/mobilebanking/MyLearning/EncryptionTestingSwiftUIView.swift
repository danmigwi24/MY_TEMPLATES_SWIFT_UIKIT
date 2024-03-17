//
//  EncryptionTestingSwiftUIView.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 01/03/2024.
//

import SwiftUI
import MBCore
//
import Foundation
import Security



struct EncryptionTestingSwiftUIView: View {
    //
    @StateObject var sharedViewModel = SharedViewModel()
    let config = AppConfig.Current
    //
    @State var encryptedMessage:String = ""
    @State var decryptedMessage:String = ""
    @State var publicKey:String = ""
    @State var responseString:String = ""
    //
    var body: some View {
        GeometryReader { geometry in
            //
            CustomLoadingView(
                isShowing: self.$sharedViewModel.isLoading,
                loadingTitle: $sharedViewModel.loadingMessage,
                foregroundColor: Color(hexString: CustomColors.darkBlue)
            ) {
                TestCryptoView()
            }
        }.frame(maxWidth: .infinity,maxHeight: .infinity)
            .task{
                //
                print(RSAHelper().readPEMFile())
                //
                onAppearConfig()
            }
    }
    
    @ViewBuilder
    func TestCryptoView()-> some View{
        ScrollView{
            VStack{
                //
               CustomButtonFilled(action: {
                   onAppearConfig()
               }, title: "Refresh", bgColor: .blue, textColor: .white)
                //
                Text("RESPONSE:").foregroundColor(.red)
                Text("\(responseString)")
                    .lineLimit(4)
                Divider()
                
                
            }.padding(10).frame(maxWidth: .infinity,maxHeight: .infinity)
        }
    }
}

//MARK: APPEAR
extension EncryptionTestingSwiftUIView{
    //
    private func onAppearConfig(){
        //
        makeHandshakeRSA()
        //testAES()
    }
}

//MARK: RSA ENCRYPTION
extension EncryptionTestingSwiftUIView{

    private func makeHandshakeRSA(){
        /*
         {"sessionId":"a51e425c-3b2a-487c-940c-79f4845cad31","content":{"deviceId":"e0c3e10e-4e0f-4983-926b-c653450e914b","version":"1","timestamp":"2024-02-27"}}
         */
        
        //
        var payload = HandshakeRequest()
        //
        var content = HandshakeContent()
        content.version =  AppUtils().getAppVersion()
        content.deviceID = AppUtils().getDeviceID()
        content.timestamp = getCurrentTimestamp()
        //
        payload.sessionID = AppUtils().geneneratedSessionID()
        payload.content = content
        
        sharedViewModel.isLoading = true
        RequestManager.ApiInstance.makeHandshake(requestBody: payload){(status, message) in
            DispatchQueue.main.async {
                sharedViewModel.isLoading = false
                if status {
                    self.responseString = message ?? ""
                    /*
                    CustomAlertDailogWithCancelAndConfirm(
                        title: "Success",
                        message:  "Perform AES Now",
                        secondaryTitle: "Cancel",
                        primaryText: "AES",
                        secondaryAction: {
                            
                        },
                        primaryAction: {
                            self.simulatePerformAccountLookUp()
                        })
                    */
                    self.simulatePerformAccountLookUp()
                }else{
                    notifyAlert(message)
                }
            }
        }
        
    }
    //
    private func testHandShakeRSA(){
        
        var payload = HandshakeRequest()
        var content = HandshakeContent()
        content.version =  AppUtils().getAppVersion()
        content.deviceID = AppUtils().getDeviceID()
        content.timestamp = getCurrentTimestamp()
        //
        payload.sessionID = AppUtils().geneneratedSessionID()
        payload.content = content
        
        sharedViewModel.isLoading = true
        ///*
        do {
            self.publicKey = RSAHelper().cleanedPEMString(publicKey: config!.cryptoConfig.rsaKey)
            //
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(payload)
            
            guard let jsonString = String(data: jsonData, encoding: .utf8) else {
                print("Failed to convert JSON data to string")
                return
            }
            
            
            ///*
          
            //MARK: MINE
            let encryptedData = jsonString.encryptedRSA(enKey: config!.cryptoConfig.rsaKey)
            
            encryptedMessage = encryptedData//String(data:encryptedData,encoding: .utf8) ?? ""
            //
            print("\nOriginal message as jsonString: \(jsonString)\n")
            print("\nEncrypted message: \(encryptedData)\n")
            print("\nEncrypted message from data to string: \(encryptedData)\n")
            let postData = encryptedData.data(using: .utf8) ?? Data()
            print("\nEncrypted DATA: \(postData)\n")
            
            //
            var request = URLRequest(url: URL(string: "https://test-api.ekenya.co.ke/mobile-banking/api/v1/mbs/handshake")!,timeoutInterval: Double.infinity)
            request.addValue("text/plain", forHTTPHeaderField: "Content-Type")
            
            request.httpMethod = "POST"
            request.httpBody = postData
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                //
                DispatchQueue.main.async {
                    sharedViewModel.isLoading = false
                    guard let data = data else {
                        print(String(describing: error))
                        return
                    }
                    //MARK: TRYING DECRYPTING
                    let apiResponse = String(data: data, encoding: .utf8) ?? ""
                    print("RESPONSE \n\(apiResponse)\n")
                    
                
                        let dS =  apiResponse.decodeFromBase64String()
                        let pJ = parseStringToJson(string: dS ,type: HandShakeResponse.self)
                        guard let responseData = pJ  else {
                            print("Failed to parse JSON.")
                            return
                        }
                        //let iv = decodeDataToGetIv(from: dS) ?? ""
                        let iv = responseData.data.x
                        print("IV  : \(iv)\n")
                        print("RESP : \(responseData)\n")
                        print("isExist: \(responseData.isExist)\n")
                        print("Data: \(responseData.data.x)\n")
                        //
                        let decryptedData = iv.decryptedRSA(enKey: self.publicKey)
                        print("Decrypted message: \(decryptedData)")
                        let getAESKeyResponse =  parseStringToJson(string: decryptedData, type: GetAESKeyResponse.self)
                        
                        self.decryptedMessage = "\(getAESKeyResponse?.status ?? "") "
                    
                }
                
            }
            
            task.resume()
            
        } catch {
            print(error.localizedDescription)
        }
        //*/
    }
    //
    private func notifyAlert(_ message:String?){
        CustomAlertDailogWithCancelAndConfirm(
            title: "",
            message: message ?? "We cannot reach the MobileBanking service. \nPlease try again later..",
            secondaryTitle: "Cancel",
            primaryText: "Try Again",
            secondaryAction: {
                
            },
            primaryAction: {
                self.makeHandshakeRSA()
            })
    }
}


//MARK: AES ENCRYPTION
extension EncryptionTestingSwiftUIView{
    
    private func simulatePerformAccountLookUp(){
        //
        var payload = AccountLookupRequest()
        payload.deviceID = AppUtils().getDeviceID()
        payload.nationalID = "33956141"
        payload.phoneNumber = "254798997948"
        
        self.performAccountLookUp(model: payload)
    }
  
    //MARK: - AccountLookUp
    private  func performAccountLookUp(model: AccountLookupRequest){
        AppUtils.Timber(with: "signin \(model)")
        sharedViewModel.isLoading = true
        RequestManager.ApiInstance.accountLookUp(requestBody: model) {status, message, accountLookUpResponse in
        
            DispatchQueue.main.async{
                sharedViewModel.isLoading = false
                if status {
                    self.responseString = message ?? ""
                    alertDialog(message: "\(message ?? "")")
                }else{
                    alertDialog(message: "\(message ?? "")")
                }
            }
            //
        }
    }
    //
    private func alertDialog(message:String?){
        CustomAlertDailog(title: "Info", message: message ?? "Response could not be processed", primaryText: "Ok", primaryAction: {
            
        })
    }
}



