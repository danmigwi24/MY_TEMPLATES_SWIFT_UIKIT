//
//  DefaultReq.swift
//  MB
//
//  Created by Daniel Kimani on 10/02/2024.
//

import Foundation
import UIKit

//UIDevice.current.model/name - Iphone
//UIDevice.current.systemName - IOS
//UIDevice.current.systemVersion - 16.6

public struct DeviceInfo : Codable{
    public init(){}
    public var deviceOSName: String = UIDevice.current.systemName
    public var deviceModel: String = UIDevice.current.model
    public var deviceOSVersion: String = UIDevice.current.systemVersion
    public var deviceBrand: String? = UIDevice.current.name
    public var deviceID: String = AppUtils().getDeviceID()
    public var deviceManufacturer: String = ""
    
    public var description: String {
            do {
                let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted
                let data = try encoder.encode(self)
                if let jsonString = String(data: data, encoding: .utf8) {
                    return jsonString
                }
            } catch {
                debugPrint("Faile \(error.localizedDescription)")
                // Handle error if encoding fails
            }
            return "DeviceInfo encoding failed"
        }

}

