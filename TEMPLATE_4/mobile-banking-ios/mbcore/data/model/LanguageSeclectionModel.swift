//
//  LanguageSeclectionModel.swift
//  MobileBanking
//
//  Created by Daniel Kimani on 06/02/2024.
//

import Foundation

public struct  LanguageModel:Equatable,Hashable {
    public let     languageAbbreviation:String
    public let     languageAbbreviationInCaps:String
    public let     languageName: String
    public let     languageFlag:String
}

public let     LANGUAGEPICKER = [
    LanguageModel(
        languageAbbreviation: "en",
        languageAbbreviationInCaps: "EN",
        languageName: "English",
        languageFlag: "🇬🇧"
    ),
    LanguageModel(
        languageAbbreviation: "fr",
        languageAbbreviationInCaps: "FR",
        languageName: "French",
        languageFlag: "🇫🇷"
    ),
    LanguageModel(
        languageAbbreviation: "pt-PT",
        languageAbbreviationInCaps: "PT",
        languageName:"Portuguese",
        languageFlag: "🇵🇹"
    ),
]
