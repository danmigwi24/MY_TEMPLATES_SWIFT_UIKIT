//
//  SecurityQuestionsResponseModel.swift
//  MBCore
//
//  Created by Daniel Kimani on 15/03/2024.
//

import Foundation


public struct GetSecurityQuestionsResponse: Codable, Hashable {
    public var status : String?
    public var message : String
    public var data  : [QuestionsDatum]
    public var exist : Bool
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case data = "data"
        case exist = "exist"
    }
}



// MARK: - GetSecurityQuestionsResponse
public struct QuestionsDatum: Codable, Hashable {
    //public init(){}
    //
    public var active: Bool
    public var createdOn: String
    public var id: Int
    public var question: String
    
    enum CodingKeys: String, CodingKey {
        case active = "active"
        case createdOn = "createdOn"
        case id = "id"
        case question = "question"
    }
}

extension QuestionsDatum {
    public func toDropDownItems() -> DropdownItem<QuestionsDatum> {
        return DropdownItem(
            title: "\(self.question )" ,
            description: "\(self.id )",
            model: self
        )
    }
}


public let listOfQuestionsDatum = [
    QuestionsDatum(
        active:true,
        createdOn:"",
        id:0,
        question: ""
    )
]

