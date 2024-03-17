//
//  CreateNewPinRequest.swift
//  MBCore
//
//  Created by Daniel Kimani on 14/03/2024.
//

import Foundation

// MARK: - CreateNewPinRequest
public struct CreateNewPinRequest: Codable, Hashable {
    //
    public init() {}
    //
    public var oldPin: String?
    public var newPin: String?
    //
    enum CodingKeys: String, CodingKey {
        case oldPin = "oldPin"
        case newPin = "newPin"
    }
}
