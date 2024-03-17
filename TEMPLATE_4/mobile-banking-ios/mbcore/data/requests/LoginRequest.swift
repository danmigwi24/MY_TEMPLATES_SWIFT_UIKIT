//
//  SignIn.swift
//  AppCore
//
//  Created by LenoxBrown on 18/08/2022.
//

import Foundation

public struct LoginRequest: Codable{
    public init(){}
    public var username: String?
    public var deviceID: String?
    public var pin: String?
    
    enum CodingKeys: String, CodingKey {
        case username = "username"
        case deviceID = "deviceId"
        case pin = "pin"
    }
    
    //    public init(username: String?, deviceID: String?, pin: String?) {
    //        self.username = username
    //        self.deviceID = deviceID
    //        self.pin = pin
    //    }
}
