//
//  ServiceModel.swift
//  MBCore
//
//  Created by Daniel Kimani on 14/03/2024.
//

import Foundation

public struct  ServiceModel:Hashable,Identifiable {
   public var         id: Int
   public var        title: String
   public var        description: String
}

public var  LIST_SERVICES: [ServiceModel] = [
    ServiceModel(id: 1, title: "My Accounts", description: ""),
    ServiceModel(id: 2, title: "My Cards", description: ""),
    ServiceModel(id: 3, title: "Fund Transfer", description: ""),
    ServiceModel(id: 4, title: "Withdraw Money", description: ""),
    ServiceModel(id: 5, title: "Loan Service", description: ""),
    ServiceModel(id: 6, title: "Buy Airtime", description: ""),
    ServiceModel(id: 7, title: "Bill Payments", description: ""),
    ServiceModel(id: 8, title: "Merchant payment", description: ""),
    ServiceModel(id: 9, title: "Savings", description: ""),
    ServiceModel(id: 10, title: "Budgets", description: ""),
    ServiceModel(id: 11, title: "Deposits", description: ""),
    ServiceModel(id: 12, title: "Statements", description: ""),
]


public var  LIST_OTHER_SERVICES: [ServiceModel] = [
    ServiceModel(id: 1, title: "Chama", description: ""),
    ServiceModel(id: 2, title: "Insurance", description: ""),
    ServiceModel(id: 3, title: "Diaspora Remittance", description: ""),
    ServiceModel(id: 4, title: "My Biz", description: ""),
    ServiceModel(id: 5, title: "Investment", description: ""),
    ServiceModel(id: 6, title: "Gamification", description: ""),
]
