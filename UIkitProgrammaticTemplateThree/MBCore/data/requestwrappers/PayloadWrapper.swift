//
//  PayloadWrapper.swift
//  MBCore
//
//  Created by Daniel Kimani on 14/03/2024.
//

import Foundation

public struct PayloadWrapper : Codable {
    public init() {}
    //
    public var sessionId:String = ""
    public var content:String = ""
    
    enum CodingKeys: String, CodingKey {
        case sessionId = "sessionId"
        case content = "content"
    }
}
