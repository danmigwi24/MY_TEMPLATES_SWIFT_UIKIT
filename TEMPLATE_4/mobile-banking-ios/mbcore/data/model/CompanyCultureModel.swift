//
//  CompanyCultureModel.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 08/02/2024.
//

import Foundation





public struct CompanyCultureModel : Identifiable,Equatable,Hashable {
   public var     id: String = UUID().uuidString
    public let   title:String
    public let   description:String
    public let   image:String
}

public let   listOfCompanyCultureModel = [
    CompanyCultureModel(title: "Personal Accounts", description: "You will find personal products that are tailored for Individuals and personal use only", image: "PersonalAccounts"),
    CompanyCultureModel(title: "Business Accounts", description: "You will find business products that are tailored for Businesses only", image: "PersonalAccounts"),
    CompanyCultureModel(title: "Islamic Accounts", description: "You will find islamic products that are tailored for Muslims that follow sheria laws", image: "PersonalAccounts"),
    CompanyCultureModel(title: "Students Accounts", description: "You will be able to find various products that are tailored For students and children below 18 years", image: "PersonalAccounts"),
]

