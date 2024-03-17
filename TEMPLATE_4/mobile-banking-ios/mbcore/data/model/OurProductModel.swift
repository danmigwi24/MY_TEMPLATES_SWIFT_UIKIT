//
//  OurProductModel.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 08/02/2024.
//

import Foundation




public struct OurProductModel : Identifiable,Equatable,Hashable {
   public var     id: Int//String = UUID().uuidString
    public let   title:String
    public let   description:String
    public let   image:String
}

public let   listOfOurProductModel = [
    OurProductModel(id: 1, title: "Bank Accounts", description: "", image: "BankAccounts"),
    
    OurProductModel(id: 2,title: "Card Products", description: "", image: "CardsProducts"),
   
    OurProductModel(id: 3,title: "Loan Products", description: "", image: "LoanProducts"),
    
    OurProductModel(id: 4,title: "Investment Products", description: "", image: "InvestmentProducts"),
    OurProductModel(id: 5,title: "InsuranceProducts", description: "", image: "InsuranceProducts"),
]

