//
//  AccountWalletActivationRequest.swift
//  MBCore
//
//  Created by Daniel Kimani on 11/03/2024.
//

import Foundation
// MARK: - AccountWalletActivationRequest
public struct AccountWalletActivationRequest: Codable, Hashable {
    public init(){}
    //
    /*
    public var name: String?
    public var phoneNumber: String?
    public var email: String?
    public var identification: String?
    public var identificationType: String?
    public var language: String?
    public var geoLocation: String?
    public var userAgent: String?
    public var channel: String?
    public var userAgentVersion: String?
    public var nationalID: String?
    public var deviceId: String?
    public var dob: String?
    public var gender: String?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case phoneNumber = "phoneNumber"
        case email = "email"
        case identification = "identification"
        case identificationType = "identificationType"
        case language = "language"
        case geoLocation = "geoLocation"
        case userAgent = "userAgent"
        case channel = "channel"
        case userAgentVersion = "userAgentVersion"
        case nationalID = "nationalId"
        case deviceId = "deviceId"
        case dob = "dob"
        case gender = "gender"
    }
     */
    public var channel: String?
        public var email: String?
        public var geoLocation: String?
        public var identification: String?
        public var identificationType: String?
        public var language: String?
        public var name: String?
        public var nationalID: String?
        public var phoneNumber: String?
        public var userAgent: String?
        public var userAgentVersion: String?
        public var dob: String?
        public var gender: String?

        enum CodingKeys: String, CodingKey {
            case channel = "channel"
            case email = "email"
            case geoLocation = "geoLocation"
            case identification = "identification"
            case identificationType = "identificationType"
            case language = "language"
            case name = "name"
            case nationalID = "nationalId"
            case phoneNumber = "phoneNumber"
            case userAgent = "userAgent"
            case userAgentVersion = "userAgentVersion"
            case dob = "dob"
            case gender = "gender"
        }

}
