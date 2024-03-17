//
//  CommonResponse.swift
//  Deliverance IOS App
//
//  Created by Eclectics on 20/05/2023.
//

import Foundation


// MARK: - CommonResponse
public struct CommonResponse: Codable, Hashable {
    public init(){}
    public var status: String?
    public var message: String?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
    }
}
