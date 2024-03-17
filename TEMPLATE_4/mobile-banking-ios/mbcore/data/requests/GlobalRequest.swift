//
//  GlobalRequest.swift
//  maishafiti-uikit
//
//  Created by Daniel Kimani on 28/09/2023.
//

import Foundation

// MARK: - GlobalRequestPayload
public struct GlobalRequestPayload<T: Codable>: Codable {
    //public init() {}
    
    public var txntimestamp: String? = getCurrentTimestamp()
    public var payload: T
    public var channelDetails: ChannelDetails? = DEFAULT_CHANNEL_DETAILS
    public var xref: String? = "\(Int.random(in: 10000000000...100000000000))"

    enum CodingKeys: String, CodingKey {
        case txntimestamp = "txntimestamp"
        case payload = "payload"
        case channelDetails = "channel_details"
        case xref = "xref"
    }

}

// MARK: - GlobalRequestData
public struct GlobalRequestData<T: Codable>: Codable {
    //public init() {}
    public var txntimestamp: String? = getCurrentTimestamp()
    public var data: T
    public var channelDetails: ChannelDetails? = DEFAULT_CHANNEL_DETAILS
    public var xref: String? = "\(Int.random(in: 10000000000...100000000000))"

    enum CodingKeys: String, CodingKey {
        case txntimestamp = "txntimestamp"
        case data = "data"
        case channelDetails = "channel_details"
        case xref = "xref"
    }
}


// MARK: -------------------------------------------------------------------------------------------------
// MARK: - ChannelDetails
public struct ChannelDetails: Codable {
    //public init() {}
    public var channelKey: String?
    public var host: String?
    public var geolocation: String?
    public var userAgent: String?
    public var userAgentVersion: String?
    public var clientID: String?
    public var channel: String?
    public var deviceID: String?

    enum CodingKeys: String, CodingKey {
        case channelKey = "channel_key"
        case host = "host"
        case geolocation = "geolocation"
        case userAgent = "user_agent"
        case userAgentVersion = "user_agent_version"
        case clientID = "client_id"
        case channel = "channel"
        case deviceID = "deviceId"
    }
    
    public init(
        channelKey: String?,// = "894dbfea79174d4cbe2653842a29e745",
        host: String? ,//= "127.0.0.1",
        geolocation: String?,// = "",
        userAgent: String? ,//= "Samsung SM-M215G",
        userAgentVersion: String? ,// = "Unknown",
        clientID: String?  ,//= "LOMANMOBILE",
        channel: String?  ,//= "MOBILE",
        deviceID: String? // = "21d870cb2b8cd5c4"
    ) {
            self.channelKey = channelKey
            self.host = host
            self.geolocation = geolocation
            self.userAgent = userAgent
            self.userAgentVersion = userAgentVersion
            self.clientID = clientID
            self.channel = channel
            self.deviceID = deviceID
        }
}


public let DEFAULT_CHANNEL_DETAILS = ChannelDetails(
    channelKey: "894dbfea79174d4cbe2653842a29e745",
    host: "127.0.0.1",
    geolocation: "",
    userAgent: "\(DeviceInfo().deviceModel)",
    userAgentVersion: "\(DeviceInfo().deviceOSName)-\(DeviceInfo().deviceOSVersion)",
    clientID: "LOMANMOBILE",
    channel: "MOBILE",
    deviceID: DeviceInfo().deviceID
)



