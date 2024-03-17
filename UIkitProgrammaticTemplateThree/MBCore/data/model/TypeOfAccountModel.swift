//
//  TypeOfAccountModel.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 08/02/2024.
//

import Foundation



public struct  TypeOfAccountModel : Identifiable,Equatable,Hashable {
   public var        id: Int// = UUID().uuidString
    public let     title:String
    public let     description:String
    public let     image:String
}

public let     listOfTypeOfAccountModel = [
    TypeOfAccountModel(id: 1, title: "Personal Accounts", description: "You will find personal products that are tailored for Individuals and personal use only", image: "PersonalAccounts"),
    TypeOfAccountModel(id: 2, title: "Business Accounts", description: "You will find business products that are tailored for Businesses only", image: "BusinessAccounts"),
    TypeOfAccountModel(id: 3, title: "Islamic Accounts", description: "You will find islamic products that are tailored for Muslims that follow sheria laws", image: "IslamicAccounts"),
    TypeOfAccountModel(id: 4, title: "Students Accounts", description: "You will be able to find various products that are tailored For students and children below 18 years", image: "StudentsAccounts"),
]
