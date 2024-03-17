//
//  KeychainAccess.swift
//  MB
//
//  Created by Daniel Kimani on 10/02/2024.
//

import Foundation
class KeychainAccess {
    
    static let TAG = "Keychain: "
    ///
    func addKeychainData(itemKey: String, itemValue: String) throws {
        ///we convert the itemValue(dataToBeStored) into a Data object(binary representation)
        guard let valueData = itemValue.data(using: .utf8) else {
            AppUtils.Log(from:self,with:KeychainAccess.TAG + "Unable to store data, invalid input - key: \(itemKey), value: \(itemValue)")
            return
        }
        
        //before adding a new value with the same key we first delete e old value if stored first
        do {
            try deleteKeychainData(itemKey: itemKey)
        } catch {
            AppUtils.Log(from:self,with:KeychainAccess.TAG + "nothing to delete ..")
            throw error
        }
        ///proceed to write a query to add the new itemValue
        let queryAdd: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            //kSecAttrService as String: "cbkonnect" as AnyObject,
            kSecAttrAccount as String: itemKey as AnyObject,
            kSecValueData as String: valueData as AnyObject,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
        ]
        let resultCode: OSStatus = SecItemAdd(queryAdd as CFDictionary, nil)
        
        if resultCode != 0 {
            AppUtils.Log(from:self,with:KeychainAccess.TAG + "Keychain value not added - Error: \(resultCode)")
        } else {
            AppUtils.Log(from:self,with:KeychainAccess.TAG + "value added successfully")
        }
    }
    ///To delete an item from keychain, we write a query specifying the item class and the attribute primary key.
    func deleteKeychainData(itemKey: String) throws {
        let queryDelete: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: itemKey as AnyObject
        ]
        
        let resultCodeDelete = SecItemDelete(queryDelete as CFDictionary)
        
        if resultCodeDelete != 0 {
            AppUtils.Log(from:self,with:KeychainAccess.TAG + "unable to delete from keychain: \(resultCodeDelete)")
        } else {
            AppUtils.Log(from:self,with:KeychainAccess.TAG + "successfully deleted item")
        }
    }
    ///To retrieve data from keychain we write a query specifying the itemclass, unique attribute identifier, specify if data shud b returned and the match limit expected
    func queryKeychainData (itemKey: String) throws -> String? {
        //
        let queryLoad: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            //kSecAttrService as String :"cbkonnect" as AnyObject,
            kSecAttrAccount as String: itemKey as AnyObject,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var result: AnyObject?
        ///since this retrieve func require 2 args query that define creteria to use to load the keychain dta, and pointer which basically hold a memory reference to data being loaded. since this arg requires to b a pointer(&), we first call withUnsafeMutablePointer to help help create a mutable pointer to a varibale results, this pointer is later passed on as an arg to another func UnsafeMutablePointer($0), hence ensure the data retrieved is looaded in this memory address location
        ///$0 represent first arg passed to the closure
        ///withUnsafeMutablePointer take in an arg and a closure, a closure gives as osstatus to b used on determining if item have been saved or not.
       
        let resultCodeLoad = withUnsafeMutablePointer(to: &result) {
            SecItemCopyMatching(queryLoad as CFDictionary, UnsafeMutablePointer($0))
        }
        /// If resultCodeLoad is not equal to zero, it means that the keychain item was not found or there was an error in retrieving it. In this case, the code creates a new keychain query with the same parameters as before and attempts to retrieve the item again using SecItemCopyMatching.
        /// The objects parameter contains an array of values corresponding to the keys in the forKeys parameter
        if resultCodeLoad != 0 {
            //
            let keychainQuery: NSMutableDictionary =
                NSMutableDictionary(
                    objects:[
                        kSecClassGenericPassword,
                        itemKey,
                        kCFBooleanTrue,
                        kSecMatchLimitOne
                    ],
                    
                   forKeys:[
                        kSecClass as! NSCopying,
                        kSecAttrAccount as! NSCopying,
                        kSecReturnData as! NSCopying,
                        kSecMatchLimit as! NSCopying
                   ]
                )
            // Search for the keychain items
            let status: OSStatus = SecItemCopyMatching(keychainQuery, &result)
            //
            if status != errSecSuccess {
                AppUtils.Log(from:self,with:KeychainAccess.TAG + "Nothing was retrieved from the keychain. Status code \(status)")
            }
        }
        ///if data was successfully loaded from keychain we cast the results to Data, then convert the data into a string and return its value
        guard let resultVal = result as? NSData, let keyValue = String(data: resultVal as Data, encoding: String.Encoding.utf8) else {
            AppUtils.Log(from:self,with:KeychainAccess.TAG + "error parsing keychain result - \(resultCodeLoad)")
            return nil
        }
        return keyValue
    }
    ///MARK :
    func updateValue(key:String, newValue: String) {
        //allowLossyConversion set to false ensure any emoji for example cant b converted to the alternate char hence conversion fails
        if let dataFromString: Data = newValue.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            
            // Instantiate a new default keychain query
            let keychainQuery: NSMutableDictionary = NSMutableDictionary(
                objects:[
                    kSecClassGenericPassword,
                    key
                  ],
                forKeys: [
                    kSecClass as! NSCopying,
                    kSecAttrAccount as! NSCopying])
            //
            let status = SecItemUpdate(keychainQuery as CFDictionary, [kSecValueData:dataFromString] as CFDictionary)
            //
            if (status != errSecSuccess) {
                if let err = SecCopyErrorMessageString(status, nil) {
                    AppUtils.Log(from:self,with:KeychainAccess.TAG + "Read \(key) failed: \(err)")
                }
            }
        }
    }
    ///MARK :
    func removeValue(key:String) {
        
        // Instantiate a new default keychain query
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [
            kSecClassGenericPassword,
            //"cbkonnect",
            key, kCFBooleanTrue], forKeys: [
                kSecClass as! NSCopying,
                //kSecAttrService as! NSCopying,
                kSecAttrAccount as! NSCopying, kSecReturnData as! NSCopying])
        
        // Delete any existing items
        let status = SecItemDelete(keychainQuery as CFDictionary)
        if (status != errSecSuccess) {
            if let err = SecCopyErrorMessageString(status, nil) {
                AppUtils.Log(from:self,with:KeychainAccess.TAG + "Remove \(key) failed: \(err)")
            }
        }
        
    }
    ///MARK :
    class func addValue(key:String, val: String) {
        //
        if let dataFromString = val.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            
            // Instantiate a new default keychain query
            let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [
                kSecClassGenericPassword,
                //"cbkonnect",
                key, dataFromString], forKeys: [
                    kSecClass as! NSCopying,
                    //kSecAttrService,
                    kSecAttrAccount as! NSCopying, kSecValueData as! NSCopying])
            
            // Add the new keychain item
            let status = SecItemAdd(keychainQuery as CFDictionary, nil)
            
            if (status != errSecSuccess) {    // Always check the status
                if let err = SecCopyErrorMessageString(status, nil) {
                    AppUtils.Log(from:self,with:KeychainAccess.TAG + "Write \(key) failed : \(err)")
                }
            }
        }
    }
}
