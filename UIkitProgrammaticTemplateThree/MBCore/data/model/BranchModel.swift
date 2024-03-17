//
//  BranchModel.swift
//  MBCore
//
//  Created by Daniel Kimani on 28/02/2024.
//

import Foundation



public struct  BranchModel : Identifiable,Equatable,Hashable {
    public var      id: Int //= UUID().uuidString
    public let     title:String
    public let     description:String
}


extension BranchModel {
    public func toDropDownItems() -> DropdownItem<BranchModel> {
        return DropdownItem(
            title: "\(self.title)" ,
            description: self.description,
            model: self
        )
    }
}


public let     listOfBranchModel = [
    BranchModel(id: 1 , title: "Nairobi (Kencom)", description: ""),
    BranchModel(id: 2 , title: "Nairobi (Kipande Road)", description: ""),
]

