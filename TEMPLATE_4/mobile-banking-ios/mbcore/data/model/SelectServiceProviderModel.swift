//
//  SelectServiceProviderModel.swift
//  MBCore
//
//  Created by Daniel Kimani on 28/02/2024.
//

import Foundation

public struct  SelectServiceProviderModel : Identifiable,Equatable,Hashable {
    public var      id: Int //= UUID().uuidString
    public let     title:String
    public let     description:String
}


extension SelectServiceProviderModel {
    public func toDropDownItems() -> DropdownItem<SelectServiceProviderModel> {
        return DropdownItem(
            title: "\(self.title)" ,
            description: self.description,
            model: self
        )
    }
}


public let  listOfSelectServiceProviderModel = [
    SelectServiceProviderModel(id: 1 , title: "Mpesa", description: "mpesa-logo"),
    SelectServiceProviderModel(id: 2 , title: "Airtel", description: "airtel-logo"),
    SelectServiceProviderModel(id: 3 , title: "T-Kash", description: "telkom-logo"),
]



