//
//  DropdownItem.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 28/02/2024.
//

import Foundation

//public struct DropdownItem: CustomStringConvertible, Identifiable, Equatable,Hashable {
public struct  DropdownItem<T:Hashable>: CustomStringConvertible, Identifiable, Equatable,Hashable {
    public let     id = UUID().uuidString
   public var        title: String
   public var        description : String = ""
   public var        model : T //= nil

   public var        returnedModel: T {
        return self.model
    }
}


