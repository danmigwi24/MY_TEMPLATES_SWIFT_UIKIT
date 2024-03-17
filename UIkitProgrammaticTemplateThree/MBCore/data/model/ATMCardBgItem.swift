//
//  ATMCardBgItem.swift
//  MBCore
//
//  Created by Daniel Kimani on 28/02/2024.
//

import Foundation
public struct  ATMCardBgItem : Identifiable,Equatable,Hashable {
   public var        id: String = UUID().uuidString
    public let     bg:String
}

public let listOfATMCardBgItem = [
    ATMCardBgItem( bg: "")
    ]
