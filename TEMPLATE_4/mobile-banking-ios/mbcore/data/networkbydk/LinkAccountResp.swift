//
//  LinkAccountResp.swift
//  FauluCore
//
//  Created by  Daniel Kimani on 11/03/2021.
//  Copyright © 2021 Eclectics Int. All rights reserved.
//

import Foundation

class LinkAccountResp:NSObject,Codable {
   public var        message:String?
   public var     ref:String?
    
    private enum CodingKeys: String, CodingKey {
        case message = "message"
        case ref = "transRef"
    }
    
    required public init(from decoder: Decoder) throws {
         let   container = try decoder.container(keyedBy: CodingKeys.self)
        if  let   m = try? container.decodeIfPresent(String.self, forKey: .message){
            message = m
        }
        if  let   r = try? container.decodeIfPresent(String.self, forKey: .ref){
            ref = r
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var     container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(ref , forKey: .ref)
    }
}

