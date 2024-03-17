//
//  GlobalUserDefaults.swift
//  maishafiti-uikit
//
//  Created by Daniel Kimani on 25/09/2023.
//

import SwiftUI
import MBCore

/**
 STRING
 */
public func saveUserData(key:String, data:String) {
    UserDefaults.standard.set(data, forKey: key)
}

public func getUserData(key:String)->String {
     //let data = UserDefaults.standard.object(forKey: key)
     let data = UserDefaults.standard.string(forKey: key)
    return data ?? ""
}


/**
 BOOL
 */
public  func saveUserDataBool(key:String, data:Bool) {
    UserDefaults.standard.set(data, forKey: key)
}

public func getUserDataBool(key: String) -> Bool {
    guard let status = UserDefaults.standard.object(forKey: key) as? Bool else {
        return false
    }
    return status
}





