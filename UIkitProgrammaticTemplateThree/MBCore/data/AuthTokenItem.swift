//
//  AccessTokenItem.swift
//  c19HealthCore
//
//  Created by  Daniel Kimani on 12/04/2020.
//  Copyright © 2020 Eclectics Int. All rights reserved.
//

import Foundation

public struct  AccountStatus{
    public static  let   STATUS_OKAY = 1
    public static  let   STATUS_NOT_WHITELISTED = 2
    public static  let   STATUS_NOT_REGISTERED = 9
    public static  let   STATUS_NOT_APPROVED = 5
}

public class AuthTokenItem: NSObject {
   public var        Token:String?
   public var        Issued:Date = Date()
   public var        ValidityInMinutes = 10
   public var        RefreshToken:String?
   public var        ResetPass = false
}

public class RefreshToken{
   public var        accessToken:String?
   public var        value:String?
   public var        expires:Date?
   public var        issued:Date?
    
    init(with accessToken:String,refreshToken:String,expires:Date){
        self.accessToken = accessToken
        self.value = refreshToken
        self.expires = expires
    }
    
   public var        Value :String?{
        set{value = newValue}
        get{return value}
    }
    //
   public var        AccessToken :String?{
        set{accessToken = newValue}
        get{return accessToken!}
    }
    //
   public var        Expires :Date?{
        set{expires = newValue}
        get{return expires}
    }
    //
   public var        Issued :Date?{
        set{expires = newValue}
        get{return expires}
    }
}
