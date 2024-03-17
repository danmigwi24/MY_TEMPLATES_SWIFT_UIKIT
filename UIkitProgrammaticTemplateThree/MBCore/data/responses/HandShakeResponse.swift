//
//  HandShakeResponse.swift
//  MBCore
//
//  Created by Daniel Kimani on 05/03/2024.
//

import Foundation

import Foundation



public struct HandShakeResponse: Decodable {
    public let isExist: Bool
    public let data: DataDetails
}


public struct DataDetails: Decodable {
    public let x: String
    public let endpoints: [Endpoint]
}

public struct Endpoint: Decodable {
    public let id: Int
    public let name: String
    public let baseUrl: String
    public let url: String
    public let code: String
    public let active: Bool
}



// MARK: - GetAESKeyResponse
public struct GetAESKeyResponse: Codable, Hashable {
    public var status: String?
    public var message: String?
    public var data: GetAESKeyDataClass?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case data = "data"
    }

    public init(status: String?, message: String?, data: GetAESKeyDataClass?) {
        self.status = status
        self.message = message
        self.data = data
    }
}

// MARK: - DataClass
public struct GetAESKeyDataClass: Codable, Hashable {
    public var y: String?

    enum CodingKeys: String, CodingKey {
        case y = "y"
    }

    public init(y: String?) {
        self.y = y
    }
}
