//
//  TrustKitSsl.swift
//  AppCore
//
//  Created by  Daniel Kimani on 19/10/2020.
//  Copyright © 2020 Eclectics Int. All rights reserved.
//

import Foundation
import TrustKit
import UIKit
import AdSupport


class SecurityServiceImpl: NSObject,SecurityService {
    private static var _inst:SecurityServiceImpl?
    ///
    public static var Shared:SecurityServiceImpl{
        get{
            if _inst == nil {
                _inst = SecurityServiceImpl()
            }
            return _inst!
        }
    }
    
    private override init(){
        super.init()
        guard
            let env = AppConfig.Current?.Environment
        else{
            print("I SWEAR THIS CRASH IS HECTICS")
            return
           }
        let rootURL = env.rootURL
        let url = URL(string: rootURL)?.host
        
        //let url = "https://test-api.ekenya.co.ke/mobile-banking"

        AppUtils.Log(from: self, with: "HOST VALUETRUST KIT VALUE =>\(url)")

        TrustKit.setLoggerBlock { (message) in
        AppUtils.Log(from: self, with: "TRUST KIT VALUE =>\(message)")
        }
        //Config/
        let trustKitConfig = [
            kTSKPinnedDomains: [
                url: [
                    // Block connections if pinning validation failed
                    kTSKEnforcePinning: true,
                    kTSKIncludeSubdomains: true,
                    //kTSKPublicKeyAlgorithms: [kTSKAlgorithmRsa2048],
                    kTSKPublicKeyHashes: [
//                        env.PK_1,
//                        env.PK_2
                    ]
                ] as [String : Any]
            ]
        ] as [String: Any]
        
        //INITIALIZE
        //TrustKit.initSharedInstance(withConfiguration: trustKitConfig)
    }
    //
    func handleSSLPinning(_ challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        // Let TrustKit handle it
        //TrustKit.sharedInstance().pinningValidator.handle(challenge, completionHandler: completionHandler)
        completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
    
    func isRuntimeSimulated() -> Bool {
        return UIDevice.current.isSimulator
    }
    
    func isRuntimeRooted() -> Bool {
        AppUtils.Log(from: self, with: "Simulator Check ? \(isRuntimeSimulated())")
        AppUtils.Log(from: self, with: "Jailbrea Check ? \(UIDevice.current.isJailBroken)")
        return UIDevice.current.isJailBroken
    }
    
}

