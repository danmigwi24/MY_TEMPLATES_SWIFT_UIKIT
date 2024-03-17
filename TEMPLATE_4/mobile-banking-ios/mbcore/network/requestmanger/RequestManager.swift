//
//  RequestManager.swift
//  s19HealthCore
//
//  Created by  Daniel Kimani on 26/03/2020.
//  Copyright © 2020 Eclectics Int. All rights reserved.
//

import Foundation
import Combine

public class RequestManager:NSObject,RequestProtocol {
    
    internal var config:Config?
    var router:RequestPaths!
    let APP_CONFIG_ERROR = "Invalid App State. Please re-install"
    /**create a url session responsible for receiving and sending data
     the configurations enables one  to customize the URLSessionConfiguration (e.g. tweak the cache, custom headers, etc.) **/
    internal lazy var requestsSession: URLSession = {
        //
        let configuration = URLSessionConfiguration.default
        /*tlsMinimumSupportedProtocolVersion - this property determines the minimum supported TLS protocol version for tasks within sessions based on this configuration.
         * Make a session. You'll need a delegate to validate TLS certificates later.
         *- Cut off old TLS versions.*/
        configuration.tlsMinimumSupportedProtocolVersion = .TLSv12
        //
        return URLSession(configuration: configuration,
                          delegate: self,
                          delegateQueue: nil)
    }()
    
    fileprivate static var _inst:RequestManager? = nil
    
    var authTokenItem:AuthTokenItem?{
        willSet{
            //
            AppUtils.Log(from:self,with:"Refresh token set...\(self.authTokenItem?.Token)")
        }
        didSet{
            //
            AppUtils.Log(from:self,with:"Refresh token set...\(self.authTokenItem?.Token)")
        }
    }
    
    
    var getTokenAttempts = 0
    //Shared Instance
    
    //
    public static var ApiInstance:RequestManager{
        get{
            if _inst == nil {
                _inst = RequestManager()
            }
            return _inst!
        }
        set{}
    }
    //
    
    
    private(set) lazy var SecService: SecurityService = {
        //
        return SecurityServiceImpl.Shared
    }()
    //
    private(set) lazy var Encryptor: EncryptionService = {
        //
        return EncryptionServiceImpl.Shared
    }()
    //
    
    var enabledServices = [AppService]()
    //
    internal let dispatchQueue = DispatchQueue(label: "apiservice.queue.dispatcheueuq")
    
    //
    internal var cancellables = Set<AnyCancellable>()
    
    override init(){
        super.init()
        config = AppConfig.Current
        router = RequestPaths(with:config!)
        //
        updateServicesList()
    }
    
    
    func updateServicesList(){
        guard let config = config else{
            return
        }
        //Add all
        for r in config.services.propertyValues(){
            if let s = r as? AppService {
                enabledServices.append(s)
            }
        }
    }
    
}


