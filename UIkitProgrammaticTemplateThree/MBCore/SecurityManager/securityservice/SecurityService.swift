//
//  SecurityService.swift
//  AppCore
//
//  Created by  Daniel Kimani on 19/10/2020.
//  Copyright © 2020 Eclectics Int. All rights reserved.
//

import Foundation


public protocol SecurityService {
    ///
    /// Check the current is sumulation environment
    func isRuntimeSimulated() -> Bool
    /// Check if current runtime is Rooted
    func isRuntimeRooted() -> Bool
    /// Apply SSL Certficate pinning to http requests
    func handleSSLPinning(_ challenge:URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Swift.Void)
}
