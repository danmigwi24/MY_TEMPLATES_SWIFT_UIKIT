//
//  LoginData.swift
//  AppCore
//
//  Created by LenoxBrown on 18/08/2022.
//

import Foundation

//MARK: - Login Data

public struct DefaultResponse: Codable{
    public init(){}
    public var message: String? = nil
    public var status: Int? = nil
    public var data: DataResponse? = nil
}


public struct DataResponse: Codable {
    public init(){}
    
    public var signature: String? = nil
    public var phone: String? = nil
    public var customerNumber: String? = nil
    public var firstName: String? = nil
    public var email: String? = nil
    public var nin: String? = nil
    public var firstlogin: String? = nil
    public var lastName: String? = nil
    public var isSecutityQuestionSet: String? = nil
    public var linnkedAccounts: [LinkedAccounts]? = nil
    public var jwt: String? = nil
    public var isRegistered: String? = nil
    public var enforceOTP: String? = nil
    
    public var transactionRef: String? = nil
    public var accountName: String? = nil
    public var accountStatus: String? = nil
    public var pdfUrl: String? = nil
    
    //wu
    public var wuToken: String? = nil
    public var wuJwt: String? = nil
    public var wuAuthCode: String? = nil

    enum CodingKeys : String, CodingKey {
        case signature
        case isRegistered
        case enforceOTP
        //login
        case firstlogin
        case customerNumber
        case firstName
        case email
        case lastName
        case isSecutityQuestionSet
        case nin
        case jwt
        case linnkedAccounts
        case accountStatus
        case accountName = "AccountName"
        
        // transaction
        case pdfUrl
        case transactionRef
        
        //wu
        case wuToken = "Access-Token"
        case wuJwt = "JWT"
        case wuAuthCode = "authorization_code"
    }
}

//MARK: - LinkedAccounts
public struct LinkedAccounts: Codable{
    public init(){}
    
    public var accountNo: String? = nil
    public var accountStatus: String? = nil
    public var accountCode: String? = nil
    public var accountType: String? = nil
    public var maskedAccount: String? {
        guard let accName = accountType, let acc = accountNo else {
               return nil
           }
        return "\(accName.capitalized)-\(acc.maskAccount())"
       }


    public var accountServices: AccountMandates? = nil
    
    enum CodingKeys: String, CodingKey{
        case accountNo = "LINKEDACCOUNT"
        case accountCode = "ACCOUNTTYPE"
        case accountStatus = "ACCOUNTSTATUS"
        case accountType = "ACCOUNTNAME"
        case accountServices = "ACCOUNTMANDATES"
    }
}

//MARK: - AccountMandates
public struct AccountMandates: Codable{
    public init(){}
    
    public var FULLSTATEMENT: Int = 0
    public var STATUS: Int = 0
    public var B2B: Int = 0
    public var C2B: Int = 0
    public var B2C: Int = 0
    public var field48: String? = nil
    public var BILLPAYMENT: Int = 0
    public var BI: Int = 0
    public var MINISTATEMENT: Int = 0
    public var field39: String? = nil
    public var AIRTIMETOPUP: Int = 0
    public var FT: Int = 0
}


