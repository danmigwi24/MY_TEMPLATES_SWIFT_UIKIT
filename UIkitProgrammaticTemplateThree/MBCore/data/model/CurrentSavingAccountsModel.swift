//
//  CurrentSavingAccountsModel.swift
//  MBCore
//
//  Created by Daniel Kimani on 29/02/2024.
//

import Foundation

public struct  CurrentSavingAccountsModel : Identifiable,Equatable,Hashable {
    public var      id: Int //= UUID().uuidString
    public let     title:String
    public let     description:String
    public let     image:String
}


extension CurrentSavingAccountsModel {
    public func toDropDownItems() -> DropdownItem<CurrentSavingAccountsModel> {
        return DropdownItem(
            title: "\(self.title)" ,
            description: self.description,
            model: self
        )
    }
}


public let  listOfCurrentSavingAccountsModel = [
    CurrentSavingAccountsModel(id: 1 , title: "Joint Account", description: "A joint bank account generally works like any other checking or savings account. Two or more own the account and both have full control over it.", image: "CurrentSavingAccounts"),
    CurrentSavingAccountsModel(id: 2 , title: "Premium Banking", description: "A joint bank account generally works like any other checking or savings account. Two or more own the account and both have full control over it.", image: "CurrentSavingAccounts"),
    CurrentSavingAccountsModel(id: 3 , title: "Premium Banking", description: "A joint bank account generally works like any other checking or savings account. Two or more own the account and both have full control over it.", image: "CurrentSavingAccounts"),
]
