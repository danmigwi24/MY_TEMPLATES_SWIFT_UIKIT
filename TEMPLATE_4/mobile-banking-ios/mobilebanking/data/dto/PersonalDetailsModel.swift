//
//  PersonalDetailsModel.swift
//  MBCore
//
//  Created by Daniel Kimani on 08/03/2024.
//

import Foundation
import RealmSwift

//
public class PersonalDetailsModel:Object {
    @Persisted(primaryKey: true) public var id:Int = 1
    //
    @Persisted public var phoneNumber: String? = ""
    @Persisted public var reqType: String? = ""
    @Persisted public var transactionType: String? = ""
    @Persisted public var accountType: String? = ""
    @Persisted public var currency: String? = ""
    @Persisted public var firstName: String? = ""
    @Persisted public var middleName: String? = ""
    @Persisted public var lastName: String? = ""
    @Persisted public var documentType: String? = ""
    @Persisted public var grantType: String? = ""
    @Persisted public var gender: String? = ""
    @Persisted public var emailAddress: String? = ""
    @Persisted public var idNumber: String? = ""
    @Persisted public var dob: String? = ""
    //
    @Persisted public var kraPin: String? = ""
    @Persisted public var employmentType: String? = ""
    @Persisted public var buildingName: String? = ""
    @Persisted public var streetName: String? = ""
    @Persisted public var locationName: String? = ""
    @Persisted public var postalCode: String? = ""
    @Persisted public var employment: String? = ""
    @Persisted public var postalAddress: String? = ""
}

//
