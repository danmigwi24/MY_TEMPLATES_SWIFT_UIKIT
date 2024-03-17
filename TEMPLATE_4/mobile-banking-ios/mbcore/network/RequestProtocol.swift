//
//  RequestProtocol.swift
//  s19HealthCore
//
//  Created by  Daniel Kimani on 26/03/2020.
//  Copyright © 2020 Eclectics Int. All rights reserved.
//

import Foundation


protocol RequestProtocol:AnyObject {
    //MARK:-
    func composeRequest(_ url:URL,_ method:String, _ token:String?) -> URLRequest
}

extension RequestProtocol {
    
    //MARK:- Default behaviour for compose request === urlRequest - wll return a full url
    
    func composeRequest(_ url:URL,_ method:String, _ token:String?) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        // the request is JSON
        //urlRequest.addValue("application/json",forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("text/plain",forHTTPHeaderField: "Content-Type")
        // the response expected to be in JSON format
        //urlRequest.addValue("application/json",forHTTPHeaderField: "Accept")
        urlRequest.addValue("text/plain",forHTTPHeaderField: "Accept")
//        if let t = token {
//            urlRequest.addValue("Bearer \(t)",forHTTPHeaderField: "Authorization")
//        }
        AppUtils.Log(from: self, with: "URL REQUEST IS \(urlRequest)")
        return urlRequest
    }
   
    
}
