//
//  RecommendedProductsModel.swift
//  MBCore
//
//  Created by Daniel Kimani on 29/02/2024.
//

import Foundation

public struct  RecommendedProductsModel : Identifiable,Equatable,Hashable {
    public var      id: Int //= UUID().uuidString
    public let     title:String
    public let     description:String
    public let     image:String
}


extension RecommendedProductsModel {
    public func toDropDownItems() -> DropdownItem<RecommendedProductsModel> {
        return DropdownItem(
            title: "\(self.title)" ,
            description: self.description,
            model: self
        )
    }
}


public let  listOfRecommendedProductsModel = [
    RecommendedProductsModel(id: 1 , title: "Personal Current Account", description: "Enjoy one account where you can define how you bank in A ‘pay-as-you-go’ model, meaning you only pay for transactions Made", image: "PersonalCurrentAccount"),
    RecommendedProductsModel(id: 2 , title: "Personal Current Account", description: "Enjoy one account where you can define how you bank in A ‘pay-as-you-go’ model, meaning you only pay for transactions Made", image: "PersonalCurrentAccount"),
    RecommendedProductsModel(id: 3 , title: "Personal Current Account", description: "Enjoy one account where you can define how you bank in A ‘pay-as-you-go’ model, meaning you only pay for transactions Made", image: "PersonalCurrentAccount"),
]
