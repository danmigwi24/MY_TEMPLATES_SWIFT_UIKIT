//
//  HandshakeRequest.swift
//  AppCore
//
//  Created by  Daniel Kimani on 6/15/21.
//

import Foundation

public struct HandshakeRequest: Codable {
    public init() {}
    
    public var sessionID: String? = ""
    public var content: HandshakeContent?  = nil
    
    enum CodingKeys: String, CodingKey {
        case sessionID = "sessionId"
        case content = "content"
    }
    
    
    
}

public struct HandshakeContent: Codable, Hashable {
    public init() {}
    
    public var deviceID: String? = ""
    public var version: String? = ""
    public var timestamp: String? = ""
    
    enum CodingKeys: String, CodingKey {
        case deviceID = "deviceId"
        case version = "version"
        case timestamp = "timestamp"
    }
}
