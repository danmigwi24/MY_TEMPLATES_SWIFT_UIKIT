//
//  AccountLookupRequest.swift
//  MBCore
//
//  Created by Daniel Kimani on 05/03/2024.
//

import Foundation
// MARK: - AccountLookupRequest
public struct AccountLookupRequest: Codable, Hashable {
    public init() {}
    //
    public var phoneNumber: String?
    public var deviceID: String?
    public var nationalID: String?

    enum CodingKeys: String, CodingKey {
        case phoneNumber = "phoneNumber"
        case deviceID = "deviceId"
        case nationalID = "nationalId"
    }

  
}
