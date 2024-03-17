//
//  EntryptionService.swift
//  AppCore
//
//  Created by  Daniel Kimani on 19/10/2020.
//  Copyright © 2020 Eclectics Int. All rights reserved.
//

import Foundation

public protocol EncryptionService:AnyObject{
    func EncryptAES(_ payload:Data,cryptoConfig:CryptoConfig) -> Data?
    
    func decryptAES(_ payload:String, cryptoConfig:CryptoConfig) -> String?
    
    func EncryptRSA(_ payload:Data,cryptoConfig:CryptoConfig) -> Data?
  
    func DecryptRSA(_ payload:Data, cryptoConfig:CryptoConfig) -> Data?
}
