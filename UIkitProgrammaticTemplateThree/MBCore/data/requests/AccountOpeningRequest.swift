//
//  AccountOpeningRequest.swift
//  MBCore
//
//  Created by Daniel Kimani on 07/03/2024.
//

import Foundation

// MARK: - AccountOpeningRequest
public struct AccountOpeningRequest: Codable, Hashable {
    //
    public init(){}
    //
    public var transactionDetails: AccountOpeningTransactionDetails?

    enum CodingKeys: String, CodingKey {
        case transactionDetails = "transaction_details"
    }
    /*
    public init(transactionDetails: AccountOpeningTransactionDetails?) {
        self.transactionDetails = transactionDetails
    }
     */
}


// MARK: - AccountOpeningTransactionDetails
public struct AccountOpeningTransactionDetails: Codable, Hashable {
    //
    public init(){}
    //
    public var phoneNumber: String?
    public var reqType: String?
    public var transactionType: String?
    public var accountType: String?
    public var currency: String?
    public var params: AccountOpeningParams?
    public var firstName: String?
    public var middleName: String?
    public var lastName: String?
    public var documentType: String?
    public var grantType: String?
    public var gender: String?
    public var emailAddress: String?
    public var idNumber: String?

    enum CodingKeys: String, CodingKey {
        case phoneNumber = "phone_number"
        case reqType = "req_type"
        case transactionType = "transaction_type"
        case accountType = "account_type"
        case currency = "currency"
        case params = "params"
        case firstName = "first_name"
        case middleName = "middle_name"
        case lastName = "last_name"
        case documentType = "document_type"
        case grantType = "grant_type"
        case gender = "gender"
        case emailAddress = "email_address"
        case idNumber = "id_number"
    }

    
    /*
    public init(phoneNumber: String?, reqType: String?, transactionType: String?, accountType: String?, currency: String?, params: AccountOpeningParams?, firstName: String?, middleName: String?, lastName: String?, documentType: String?, grantType: String?, gender: String?, emailAddress: String?, idNumber: String?) {
        self.phoneNumber = phoneNumber
        self.reqType = reqType
        self.transactionType = transactionType
        self.accountType = accountType
        self.currency = currency
        self.params = params
        self.firstName = firstName
        self.middleName = middleName
        self.lastName = lastName
        self.documentType = documentType
        self.grantType = grantType
        self.gender = gender
        self.emailAddress = emailAddress
        self.idNumber = idNumber
    }
     */
}


// MARK: - AccountOpeningParams
public struct AccountOpeningParams: Codable, Hashable {
    //
    public init(){}
    //
    public var kraPin: String?
    public var employmentType: String?
    public var buildingName: String?
    public var streetName: String?
    public var locationName: String?
    public var postalCode: String?
    public var employment: String?
    public var postalAddress: String?

    enum CodingKeys: String, CodingKey {
        case kraPin = "kra_pin"
        case employmentType = "employment_type"
        case buildingName = "building_name"
        case streetName = "street_name"
        case locationName = "location_name"
        case postalCode = "postal_code"
        case employment = "employment"
        case postalAddress = "postal_address"
    }
    /*
    public init(kraPin: String?, employmentType: String?, buildingName: String?, streetName: String?, locationName: String?, postalCode: String?, employment: String?, postalAddress: String?) {
        self.kraPin = kraPin
        self.employmentType = employmentType
        self.buildingName = buildingName
        self.streetName = streetName
        self.locationName = locationName
        self.postalCode = postalCode
        self.employment = employment
        self.postalAddress = postalAddress
    }
     */
}
