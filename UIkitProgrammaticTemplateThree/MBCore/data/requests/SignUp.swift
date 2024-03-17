//
//  SignUp.swift
//  MobileBanking
//
//  Created by LenoxBrown on 21/06/2022.
//

import Foundation

public struct SignUp: Codable {
    
    public init() {}
    
    public var phone: String? = nil
    public var nin: String? = nil
    public var account: String? = nil
    public var dob: String? = nil
    public var type: String? = nil

    
    //
    public var firstName: String? = nil
    public var lastName: String? = nil
    public var email: String? = nil
    public var gender: String? = nil
    public var deviceId: String? = nil
    
}

