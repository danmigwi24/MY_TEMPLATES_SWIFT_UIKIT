//
//  CommonRequest.swift
//  maishafiti-uikit
//
//  Created by Daniel Kimani on 28/09/2023.
//

import Foundation


// MARK: - AccountLookupRequest
public struct CommonRequest: Codable, Hashable {
    public init() {}
    //
    public var phoneNumber: String?
    //
    enum CodingKeys: String, CodingKey {
        case phoneNumber = "phoneNumber"
    }

  
}
