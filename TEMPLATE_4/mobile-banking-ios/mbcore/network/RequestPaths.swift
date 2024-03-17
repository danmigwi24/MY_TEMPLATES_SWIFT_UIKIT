//
//  RequestPaths.swift
//
//  Created by  Daniel Kimanioloh on 9/20/17.
//

import Foundation


public struct RequestPaths{
    public var DEVT_PATH = ""
    
    public var BASE_PATH = ""
    
    public var TOKEN_PATH = "/token"
    
    private var _config:Config
    
    public init(with config:Config){
        _config = config
        //
        ///*
        guard let env = config.Environment//,
              //let rooturl = env.rootURL,
              //let end = env.endPoint
        else{
            AppUtils.Log(from:self as AnyObject,with:"Could not read config..")
            return
        }
         //*/
              let rooturl = env.rootURL
              let end = env.endPoint
        
        /**this specifies the domain name**/
        BASE_PATH = "\(rooturl)\(end)"
        
        //
        TOKEN_PATH = rooturl + "/token"
        //
        AppUtils.Log(from:self as AnyObject,with:"Current BASE URL => \(BASE_PATH)")
    }
    
    public func getServiceUrl(_ service:String) -> URL?{
        //
        guard let url = URL(string: "\(BASE_PATH)\(service)/") else{
            //
            return nil
        }
        //
        return url
    }
}

