//
//  NatureOfEmplymentModel.swift
//  MBCore
//
//  Created by Daniel Kimani on 28/02/2024.
//

import Foundation

public struct  NatureOfEmplymentModel : Identifiable,Equatable,Hashable {
    public var      id: Int //= UUID().uuidString
    public let     title:String
    public let     description:String
}


extension NatureOfEmplymentModel {
    public func toDropDownItems() -> DropdownItem<NatureOfEmplymentModel> {
        return DropdownItem(
            title: "\(self.title)" ,
            description: self.description,
            model: self
        )
    }
}


public let  listOfNatureOfEmploymentModel = [
    NatureOfEmplymentModel(id: 1 , title: "Full-time Employment", description: ""),
    NatureOfEmplymentModel(id: 2 , title: "Part-time Employment", description: ""),
    NatureOfEmplymentModel(id: 3 , title: "Contract Employment", description: ""),
    NatureOfEmplymentModel(id: 4 , title: "Freelancing", description: ""),
    NatureOfEmplymentModel(id: 5 , title: "Remote", description: ""),
]
