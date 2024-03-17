//
//  HomeAdsModel.swift
//  MBCore
//
//  Created by Daniel Kimani on 14/03/2024.
//

import Foundation

public struct  HomeAdsModel : Identifiable,Equatable,Hashable {
    
    public var id: Int
    public var name: String?
    public var imageURL: String?
    public var link: String?
}




public let  listOfHomeAdsModel = [
    HomeAdsModel(
        id: 1 ,
        name: "Freaky flower",
        imageURL: "https://images.unsplash.com/photo-1503965830912-6d7b07921cd1?q=80&w=3474&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        link: "https://images.unsplash.com/photo-1503965830912-6d7b07921cd1?q=80&w=3474&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
    
    HomeAdsModel(
        id: 2 ,
        name: "Freaky flower",
        imageURL: "https://picsum.photos/id/237/200/300",
        link: "https://picsum.photos/id/237/200/300"),
]
