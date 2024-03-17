//
//  ForexAndStockItemModel.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 08/02/2024.
//

import Foundation

public struct  ForexAndStockItemModel : Identifiable,Equatable,Hashable {
    public var    id: String = UUID().uuidString
    public let     title:String
    public let     description:String
    public let     buy:String
    public let     sell:String
    public let     image:String
}

public struct BestPerformingStockItemModel : Identifiable,Equatable,Hashable {
    public var    id: String = UUID().uuidString
    public let   title:String
    public let   description:String
    public let   image:String
}

public let   listOfForexAndStockItemModel:[ForexAndStockItemModel] = [
    ForexAndStockItemModel( title: "US dollar", description: "USD", buy: "Kes 112.80", sell: "Kes 116.80", image: "usdollar"),
    ForexAndStockItemModel( title: "British pound", description: "GBP", buy: "Kes 112.80", sell: "Kes 116.80", image: "britishpound"),
]
public let   listOfBestPerformingStockItemModel:[ForexAndStockItemModel] = []
