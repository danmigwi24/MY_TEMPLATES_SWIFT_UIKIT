//
//  CalculatorItemModel.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 08/02/2024.
//

import Foundation

public struct  CalculatorItemModel : Identifiable,Equatable,Hashable {
    public  var     id: Int //= UUID().uuidString
    public let     title:String
    public let     description:String
    public let     image:String
}

public let     listOfCalculatorItemModel = [
    CalculatorItemModel(id:1,title: "Unsecured Loan calculator", description: "Calculate your repayments and loan amount that you qualify for", image: "UnsecuredLoanCalculator"),
    
    CalculatorItemModel(id:2,title: "Home mortgage", description: "Calculate your house affordability today and estimate how much you can afford", image: "Home mortgage"),
   
    CalculatorItemModel(id:3,title: "Vehicle Asset Financing", description: "Calculate your car affordability today and estimate how much you can afford", image: "Vehicle Asset Financing"),
    
    CalculatorItemModel(id:4,title: "Loan affordability ratio", description: "Calculate how much you can afford based on your income details", image: "Loan affordability ratio"),
]
