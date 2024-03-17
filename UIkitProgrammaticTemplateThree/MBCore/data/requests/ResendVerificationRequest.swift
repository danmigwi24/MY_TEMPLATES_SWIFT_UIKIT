//
//  ResendVerificationRequest.swift
//  MBCore
//
//  Created by Daniel Kimani on 14/03/2024.
//

import Foundation


// MARK: - ResendVerificationRequest
public struct ResendVerificationRequest: Codable, Hashable {
    //
    public init() {}
    //
    public var phoneNumber: String?
    public var otpType: String?
    //
    enum CodingKeys: String, CodingKey {
        case phoneNumber = "phoneNumber"
        case otpType = "otpType"
    }
}
