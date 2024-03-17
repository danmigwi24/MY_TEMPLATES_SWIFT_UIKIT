//
//  LoginResponse.swift
//  MBCore
//
//  Created by Daniel Kimani on 15/03/2024.
//

import Foundation

// MARK: - LoginResponse
public struct LoginResponse: Codable, Hashable {
    public var status: String
    public var message: String?
    public var data: LoginDataClass
    public var timestamp: String?
    public var exist: Bool?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case data = "data"
        case timestamp = "timestamp"
        case exist = "exist"
    }

    public init(status: String, message: String?, data: LoginDataClass, timestamp: String?, exist: Bool?) {
        self.status = status
        self.message = message
        self.data = data
        self.timestamp = timestamp
        self.exist = exist
    }
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - DataClass
public struct LoginDataClass: Codable, Hashable {
    public var status: Int?
    public var message: String?
    public var accessToken: String?
    public var tokenType: String?
    public var expiresIn: Int?
    public var scope: String?
    public var jti: String?
    public var language: String?
    public var phoneNumber: String?
    public var email: String?
    public var fullName: String?
    public var changePin: Bool?
    public var safeMode: Bool?
    public var panic: Bool?
    public var cardNumber: String?
    public var setSECQns: Bool?
    public var trxValidation: String?
    public var secondaryWallet: Bool?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case scope = "scope"
        case jti = "jti"
        case language = "language"
        case phoneNumber = "phoneNumber"
        case email = "email"
        case fullName = "fullName"
        case changePin = "changePin"
        case safeMode = "safeMode"
        case panic = "panic"
        case cardNumber = "card_number"
        case setSECQns = "setSecQns"
        case trxValidation = "trx_validation"
        case secondaryWallet = "secondaryWallet"
    }

    public init(status: Int?, message: String?, accessToken: String?, tokenType: String?, expiresIn: Int?, scope: String?, jti: String?, language: String?, phoneNumber: String?, email: String?, fullName: String?, changePin: Bool?, safeMode: Bool?, panic: Bool?, cardNumber: String?, setSECQns: Bool?, trxValidation: String?, secondaryWallet: Bool?) {
        self.status = status
        self.message = message
        self.accessToken = accessToken
        self.tokenType = tokenType
        self.expiresIn = expiresIn
        self.scope = scope
        self.jti = jti
        self.language = language
        self.phoneNumber = phoneNumber
        self.email = email
        self.fullName = fullName
        self.changePin = changePin
        self.safeMode = safeMode
        self.panic = panic
        self.cardNumber = cardNumber
        self.setSECQns = setSECQns
        self.trxValidation = trxValidation
        self.secondaryWallet = secondaryWallet
    }
}
