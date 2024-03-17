//
//  EncryptionServiceImpl.swift
//  FauluCore
//
//  Created by  Daniel Kimani on 22/10/2020.
//  Copyright © 2020 Eclectics Int. All rights reserved.
//

import Foundation
import CryptoSwift

public class EncryptionServiceImpl: NSObject, EncryptionService {
    private static var _inst:EncryptionServiceImpl?
    public static var Shared:EncryptionService{
        get{
            if _inst == nil {
                _inst = EncryptionServiceImpl()
            }
            return _inst!
        }
    }
    
    private override init(){
        super.init()
    }
    
  
    
    //
    public func EncryptRSA(_ payload: Data, cryptoConfig: CryptoConfig) -> Data? {
        //Apply Encryption
        if cryptoConfig.active {
            //
            let cleanedPEMString = RSAHelper().cleanedPEMString(publicKey: cryptoConfig.rsaKey)
            
            //
            let returnData = (String(data:payload,encoding: .utf8) ?? "" ).encryptedRSA(enKey: cleanedPEMString).data(using: .utf8)
            return returnData
            //
        }else{
            //
            return payload
        }
    }
    //
    public func DecryptRSA(_ payload: Data, cryptoConfig: CryptoConfig) -> Data? {
        //Decrypt
        if cryptoConfig.active{
            let cleanedPEMString = RSAHelper().cleanedPEMString(publicKey: cryptoConfig.rsaKey)
            
            AppUtils.Log(from:self,with:"PUBLIC KEY = \(String(describing: cleanedPEMString))")
            
            let responseString = String(data:payload,encoding: .utf8)!.decryptedRSA(enKey: cleanedPEMString)
            //AppUtils.Log(from:self,with:"DECRYPTED PAYLOAD = \(String(describing: responseString))")
            return responseString.data(using: .utf8)
        }
        
        return payload
    }
    
    //
    public func EncryptAES(_ payload: Data, cryptoConfig: CryptoConfig) -> Data? {
        //Apply Encryption
        if cryptoConfig.active {
            return "\(String(data:payload,encoding: .utf8)!.encryptedCBCPKCS5(cryptoConfig))".data(using: .utf8)
        }else{
            return payload
        }
    }
    
    //
    public func decryptAES(_ payload: String, cryptoConfig: CryptoConfig) -> String? {
        //guard let ivv = cryptoConfig.aesKey else { return nil}
        let ivv = cryptoConfig.aesKey 
        return payload.decryptedCBCPKCS5(iv: ivv, key: cryptoConfig.aesKey)
    }
    
}


