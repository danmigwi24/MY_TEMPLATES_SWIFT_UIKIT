//
//  AboutUsItemModel.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 08/02/2024.
//

import Foundation

public struct  AboutUsItemModel:Hashable {
   public var         id: Int
   public var        title: String
   public var        description: String
}

public var        ABOUT_US_ITEMS: [AboutUsItemModel] = [
    AboutUsItemModel(id: 1, title: "About Us", description: ""),
    AboutUsItemModel(id: 2, title: "Awards & Certifications", description: ""),
    AboutUsItemModel(id: 3, title: "Our culture", description: "")
]
