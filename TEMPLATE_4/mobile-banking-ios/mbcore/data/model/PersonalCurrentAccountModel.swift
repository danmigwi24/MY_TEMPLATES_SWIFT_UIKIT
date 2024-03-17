//
//  PersonalCurrentAccountModel.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 16/02/2024.
//

import Foundation

public struct  PersonalCurrentAccountModel : Identifiable,Equatable,Hashable {
   public var        id: String = UUID().uuidString
    public let     title:String
    public let     description:String
    public let     color:String
}

public let     listOfPersonalCurrentAccountModel = [
    PersonalCurrentAccountModel(title: "Identification Documents", description: "National ID / Passport", color: CustomColors.darkBlue),
    
    PersonalCurrentAccountModel(title: "Tax Pin", description: "Your KRA Pin will be required", color: CustomColors.orange),
    
    PersonalCurrentAccountModel(title: "AGE", description: "Age limit of 21 to 65 years apply to credit card and other loan products", color: CustomColors.lightBlue),
    
    PersonalCurrentAccountModel(title: "Residences", description: "Kenyan resident or non-Kenyan with a work permit from Kenyan Authorities", color: CustomColors.darkBlue),
    
    PersonalCurrentAccountModel(title: "Personal use only", description: "This account is for personal use only and opening A business account through this channel is not allowed", color: CustomColors.orange),
    
   
    PersonalCurrentAccountModel(title: "Minimum opening balance", description: "Make a minimum deposit of KES 100.00 for your account to be able to make transactions within the account", color: CustomColors.lightBlue),
    
   
]

