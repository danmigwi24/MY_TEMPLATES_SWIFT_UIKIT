//
//  ContentWrapper.swift
//  MBCore
//
//  Created by Daniel Kimani on 14/03/2024.
//


import Foundation

public struct ContentWrapper : Codable {
    public init() {}
    //
    public var payload:String = ""
    public var iv:String = ""
    
    enum CodingKeys: String, CodingKey {
        case payload = "payload"
        case iv = "iv"
    }
}


