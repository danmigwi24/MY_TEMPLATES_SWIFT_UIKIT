//
//  EncryptionStringExtenstion.swift
//   mobilebanking
//
//  Created by  Daniel Kimani on 23/03/2020.
//  Copyright © 2020 Eclectics Int. All rights reserved.
//

import Foundation
import CryptoSwift

public extension String{
    //MARK: RSA
    func encryptedRSA(enKey:String) -> String{
        if let encr = RSACrypto.encryptWithRSAPublicKey(dataToEncrypt:self.data(using: .utf8)!, publicKey: enKey){
            AppUtils.Log(from:AppUtils.self,with:"RSA Encrypt Success .. ")
            return encr.base64EncodedString()
        }else{
            AppUtils.Log(from:AppUtils.self,with:"RSA Encrypt Failed ..")
            return self
        }
    }
    
    
    public func decryptedRSA(enKey:String) -> String{
        if
            let data = self.base64DecodedToData(),
            let decrypted = RSACrypto.decryptWithRSAPublicKey(encryptedData: data,publicKey: enKey)
        {
            AppUtils.Log(from:AppUtils.self,with:"[decryptedRSA(enKey:String)] STRING TO DECRYPT SUCCESS")
            return String(data: Data(decrypted), encoding: .utf8) ?? ""
        }else{
            AppUtils.Log(from:AppUtils.self,with:"RSA Decrypt Failed ..")
            return self
        }
    }
    
    //MARK: - DecryptRSA->
    func decryptRSAData() -> String? {
        guard let crypto = AppConfig.Current?.cryptoConfig else {  return nil}
        let responseString = self.decryptedRSA(enKey: crypto.rsaKey)
        AppUtils.Timber(with:"RSA DECRYPTED PAYLOAD = \(String(describing: responseString))")
        return responseString
    }
    
    //MARK: AES -----------------------------------------------------------------------------------------------------------------
    
    //MARK: AES Config
    func encryptedCBCPKCS5(_ cryptoConfig:CryptoConfig) -> String{
        do{
            let data = self.data(using: .utf8)
            let ivv = cryptoConfig.aesKey 
            //
            let encr = try AES(key: cryptoConfig.aesKey.bytes, blockMode:CBC(iv: ivv.bytes),padding: .pkcs5).encrypt(data!.bytes)
            
            return encr.toBase64()
        }catch{
            AppUtils.Log(from:self as AnyObject,with:"AES Encrypt Error => \(error)")
            return self
        }
    }
    
    //FIRST TRY
    func encryptAESGCMNOPADDING(iv:String,aesKey:String) -> String{
        do{
            let data = self.data(using: .utf8)!
            //
            let encr = try AES(key: aesKey.bytes, blockMode:GCM(iv: iv.bytes,mode: .combined),padding: .noPadding).encrypt(data.bytes)
            
            return encr.toBase64()
        }catch{
            AppUtils.Log(from:self as AnyObject,with:"AES Encrypt Error => \(error)")
            return self
        }
        
    }
    
    
    //MARK: AES Decrypt
    func decryptedCBCPKCS5(iv:String,key:String) -> String{
        do{
            let data = self.base64DecodedToData()!
            let decrypted = try AES(key: key.bytes, blockMode:CBC(iv:iv.bytes),padding: .pkcs5).decrypt(data.bytes)
            let decry = String(data: Data(decrypted), encoding: .utf8)!// ?? ""
            AppUtils.Log(from:AppUtils.self,with:"DECRYPTED RESPONSE  \(decry)")
            return decry
        }catch{
            return self
        }
        
    }
    
    //FIRST TRY
    func decryptedAESGCMNOPADDING(iv:String,aesKey:String) -> String{
        do{
            let data = self.base64DecodedToData()!
            let decrypted = try AES(key: aesKey.bytes, blockMode:GCM(iv:iv.bytes,mode: .combined),padding: .noPadding).decrypt(data.bytes)
            let decry = String(data: Data(decrypted), encoding: .utf8)! //?? ""
            AppUtils.Log(from:AppUtils.self,with:"[decryptedAESGCMNOPADDING()] DECRYPTED RESPONSE  \(decry)")
            
            return decry
        }catch{
            AppUtils.Log(from:self as AnyObject,with:"AES DEcrypt Error => \(error)")
            return self
        }
        
    }
    //MARK: Base64 -----------------------------------------------------------------------------------------------------------------
    
    func base64Encoded() -> String? {
        return data(using: .utf8)?.base64EncodedString(options: [])
    }
    
    func base64DecodedToData() -> Data? {
        let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters)
        return data
    }
    
    func base64DecodedToString() -> String? {
        let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters)
        return String(data: data ?? Data(), encoding: .utf8) ?? ""
    }
    
    
    func decodeFromBase64String()  -> String {
        let  options : Data.Base64DecodingOptions = []
        if let data = Data(base64Encoded: self,options: options) {
            print("[decodeFromBase64String() ]Decoding data ...")
            return String(data: data, encoding: .utf8) ?? ""
        } else {
            print("Invalid input")
            return "Invalid input"
        }
    }
    
    
    
}

public func parseStringToJson<T: Decodable>(string: String, type: T.Type) -> T? {
    guard let jsonData = string.data(using: .utf8) else {
        print("Failed to convert JSON string to data")
        return nil
    }
    
    do {
        let decoder = JSONDecoder()
        let responseData = try decoder.decode(type, from: jsonData)
        return responseData
    } catch {
        print("Error decoding JSON: \(error)")
        return nil
    }
}




