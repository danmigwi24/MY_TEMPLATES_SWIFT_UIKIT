//
//  SecurityQuestionsRequestModels.swift
//  MBCore
//
//  Created by Daniel Kimani on 15/03/2024.
//

import Foundation



// MARK: - AccountLookupRequest
public struct GetSecurityQuestionRequest: Codable, Hashable {
    public init() {}
    //
    public var test: String? = "test"
    //
    enum CodingKeys: String, CodingKey {
        case test = "test"
    }

  
}


public struct  AnsweredQuestionsDto: Codable, Hashable {
    
    public init(data: [AnsweredQuestion]) {
        self.data = data
    }
    
    public var data: [AnsweredQuestion]
    
    //
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}


public struct AnsweredQuestion: Codable, Hashable {
    //public init() {}
    
    public init(questionId: Int, answer: String) {
        self.questionId = questionId
        self.answer = answer
    }
    
    public var questionId : Int
    public var answer : String
    
    //
    enum CodingKeys: String, CodingKey {
        case questionId = "questionId"
        case answer = "answer"
    }
}
