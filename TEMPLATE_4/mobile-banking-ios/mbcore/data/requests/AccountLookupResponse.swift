//
//  AccountLookupResponse.swift
//  MBCore
//
//  Created by Daniel Kimani on 05/03/2024.
//

import Foundation

// MARK: - AccountLookupResponse
public struct AccountLookupResponse: Codable, Hashable {
    public var phoneNumber: String?
    public var deviceID: String?
    public var nationalID: String?

    enum CodingKeys: String, CodingKey {
        case phoneNumber = "phoneNumber"
        case deviceID = "deviceId"
        case nationalID = "nationalId"
    }

    public init(phoneNumber: String?, deviceID: String?, nationalID: String?) {
        self.phoneNumber = phoneNumber
        self.deviceID = deviceID
        self.nationalID = nationalID
    }
}
