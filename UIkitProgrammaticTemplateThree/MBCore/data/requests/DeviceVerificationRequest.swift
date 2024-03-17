//
//  DeviceVerificationRequest.swift
//  MBCore
//
//  Created by Daniel Kimani on 12/03/2024.
//

import Foundation



// MARK: - DeviceVerificationRequest
public struct DeviceVerificationRequest: Codable, Hashable {
    //
    public init() {}
    //
    public var phoneNumber: String?
    public var otpValue: String?
    public var otpType: String?
    //
    enum CodingKeys: String, CodingKey {
        case phoneNumber = "phoneNumber"
        case otpValue = "otpValue"
        case otpType = "otpType"
    }
}


