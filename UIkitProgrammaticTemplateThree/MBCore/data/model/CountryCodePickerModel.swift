//
//  CountryCodePickerModel.swift
//  maishafiti-uikit
//
//  Created by Daniel Kimani on 11/10/2023.
//

import Foundation



public struct  CountryModel:Equatable,Hashable {
    public let     countryAbbreviation:String
    public let     countryName: String
    public let     countryCallingCode:String
    public let     countryCallingCodeWithPlus:String
    public let     countryFlag:String
}

extension CountryModel {
    public func toDropDownItems() -> DropdownItem<CountryModel> {
        return DropdownItem(
            title: "\(self.countryFlag)\(self.countryName)" ,
            description: self.countryAbbreviation,
            model: self
        )
    }
}


public let     COUNTRYPICKER = [
    CountryModel(
        countryAbbreviation: "KE",
        countryName: "Kenya",
        countryCallingCode: "254",
        countryCallingCodeWithPlus: "+254",
        countryFlag: "🇰🇪"
    ),
    CountryModel(
        countryAbbreviation: "UG",
        countryName: "Uganda",
        countryCallingCode: "256",
        countryCallingCodeWithPlus: "+256",
        countryFlag: "🇺🇬"
    ),
    CountryModel(
        countryAbbreviation: "TZ",
        countryName: "Tanzania",
        countryCallingCode: "255",
        countryCallingCodeWithPlus: "+255",
        countryFlag: "🇹🇿"
    ),
]




public let     ALL_AND_COUNTRYPICKER = [
    CountryModel(
        countryAbbreviation: "ALL",
        countryName: "All",
        countryCallingCode: "All",
        countryCallingCodeWithPlus: "All",
        countryFlag: ""
    ),
    CountryModel(
        countryAbbreviation: "KE",
        countryName: "Kenya",
        countryCallingCode: "254",
        countryCallingCodeWithPlus: "+254",
        countryFlag: "🇰🇪"
    ),
    CountryModel(
        countryAbbreviation: "UG",
        countryName: "Uganda",
        countryCallingCode: "256",
        countryCallingCodeWithPlus: "+256",
        countryFlag: "🇺🇬"
    ),
    CountryModel(
        countryAbbreviation: "TZ",
        countryName: "Tanzania",
        countryCallingCode: "255",
        countryCallingCodeWithPlus: "+255",
        countryFlag: "🇹🇿"
    ),
]




