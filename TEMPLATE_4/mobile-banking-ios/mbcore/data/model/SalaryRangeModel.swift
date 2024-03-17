//
//  SalaryRangeModel.swift
//  MBCore
//
//  Created by Daniel Kimani on 28/02/2024.
//

import Foundation
public struct  SalaryRangeModel : Identifiable,Equatable,Hashable {
    public var      id: Int //= UUID().uuidString
    public let     title:String
    public let     description:String
}


extension SalaryRangeModel {
    public func toDropDownItems() -> DropdownItem<SalaryRangeModel> {
        return DropdownItem(
            title: "\(self.title)" ,
            description: self.description,
            model: self
        )
    }
}


public let     listOfSalaryRangeModel = [
    SalaryRangeModel(id: 1 , title: "0 to 50,000", description: ""),
    SalaryRangeModel(id: 2 , title: "50,000 to 100,000", description: ""),
    SalaryRangeModel(id: 3 , title: "100,000 to 150,000", description: ""),
    SalaryRangeModel(id: 4 , title: "150,000 and above", description: "")
]
