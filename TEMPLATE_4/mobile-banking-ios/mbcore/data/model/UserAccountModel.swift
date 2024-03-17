//
//  UserAccountModel.swift
//  MBCore
//
//  Created by Daniel Kimani on 28/02/2024.
//

import Foundation

public struct  UserAccountModel : Identifiable,Equatable,Hashable {
    public var      id: Int //= UUID().uuidString
    public let     title:String
    public let     description:String
}


extension UserAccountModel {
    public func toDropDownItems() -> DropdownItem<UserAccountModel> {
        return DropdownItem(
            title: "\(self.title)" ,
            description: self.description,
            model: self
        )
    }
}


public let  listOfUserAccountModel = [
    UserAccountModel(id: 1 , title: "Current Account- A/C #1234******6789", description: ""),
    UserAccountModel(id: 2 , title: "Current Account- A/C #1234******6789", description: ""),
    UserAccountModel(id: 3 , title: "Current Account- A/C #1234******6789", description: ""),
    UserAccountModel(id: 4 , title: "Current Account- A/C #1234******6789", description: "")
]



