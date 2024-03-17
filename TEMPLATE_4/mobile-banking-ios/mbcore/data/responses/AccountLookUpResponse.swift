//
//  AccountLookUpResponse.swift
//  MBCore
//
//  Created by Daniel Kimani on 06/03/2024.
//

import Foundation

// MARK: - AccountLookUpResponse
public struct AccountLookUpResponse: Codable, Hashable {
    public var status: String?
    public var message: String?
    public var data: AccountLookUpDataClass?
    public var exist: Bool?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case data = "data"
        case exist = "exist"
    }

    public init(status: String?, message: String?, data: AccountLookUpDataClass?, exist: Bool?) {
        self.status = status
        self.message = message
        self.data = data
        self.exist = exist
    }
}

// MARK: - DataClass
public struct AccountLookUpDataClass: Codable, Hashable {
    public var isFirstTimeLogin: Bool?

    enum CodingKeys: String, CodingKey {
        case isFirstTimeLogin = "isFirstTimeLogin"
    }

    public init(isFirstTimeLogin: Bool?) {
        self.isFirstTimeLogin = isFirstTimeLogin
    }
}
