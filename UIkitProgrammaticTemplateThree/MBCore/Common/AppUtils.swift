//
//  AppUtils.swift
//

import Foundation
import UIKit
import os.log
import AdSupport
#if canImport(AppTrackingTransparency)
import AppTrackingTransparency
#endif

//import SecurityBox

let DATE_FORMAT_0 = "EEE, dd MMM yyyy kk:mm:ss z"
let DATE_FORMAT_1 = "MM/dd/yyyy kk:mm:ss a"
let DATE_FORMAT_2 = "yyyy-MM-dd'T'HH:mm:ss"
let DATE_FORMAT_3 = "yyyy-MM-dd'T'HH:mm:ssZ"
let DATE_FORMAT_4 = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"

public class AppUtils{
    
    //To get the application Id
    
    static var TAG:String = "AppUtils : "
    static let log = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "general")
    
    public init() {}
    
    public func getDeviceID() -> String {
        let uuidKey = "\(Bundle.main.bundleIdentifier ?? "").sec"
        // create a keychain helper instance
        let keychain = KeychainAccess()
        //Default test ID
        var devtId:String?
        // check if we already have a uuid stored, if so return it,uuidKey here is the primary key used to store the device Id value
        if let uuid = try? keychain.queryKeychainData(itemKey: uuidKey), uuid != nil {
#if !DEBUG
            return uuid
#endif
            return "c57f3d7a60a48b22"
        }
        if devtId == nil || devtId?.lengthOfBytes(using: .utf8) == 0{
            devtId = UIDevice.current.identifierForVendor?.uuidString
            print("Am in this development enviroment still and DEVICE ID IS \(devtId)")
        }
        // store new identifier in keychain
        try? keychain.addKeychainData(itemKey: uuidKey, itemValue: devtId!)
        //for debug
        return devtId!
    }
    //
    public func geneneratedSessionID()->String{
        let value = UUID().uuidString.lowercased()
        saveUserData(key: USERDEFAULTS.SESSION_ID, data: value)
        generateAESIV()
        return value
    }
    //
    public func getGeenerateSessionID()->String{
        return getUserData(key: USERDEFAULTS.SESSION_ID)
    }
    //
    public func getAppVersion()->String{
        return "\(Bundle.main.releaseVersionNumberAndBuildNumber)"
    }
    
    // Define AES_IV_LENGTH somewhere in your code
    let AES_IV_LENGTH = 16 // for example
    
    public  func generateAESIV() -> String {
        // Choose a Character randomly from this String
        let alphaNumericString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz"
        // Create a StringBuffer size of alphaNumericString
        var stringBuilder = ""
        for _ in 0..<AES_IV_LENGTH {
            // Generate a random number between 0 to alphaNumericString variable length
            let index = Int.random(in: 0..<alphaNumericString.count)
            // Add Character one by one at the end of stringBuilder
            let char = alphaNumericString[alphaNumericString.index(alphaNumericString.startIndex, offsetBy: index)]
            stringBuilder.append(char)
        }
        //let iv = String(data:Data(count: 12),encoding: .utf8) ?? ""
        saveUserData(key: USERDEFAULTS.GENERATED_IV, data: stringBuilder)
        return stringBuilder
    }
    
    
    public  func getGenerateAESIV() -> String {
        return getUserData(key: USERDEFAULTS.GENERATED_IV)
    }
    
    
    
    public func extractBaseURL() -> String {
        
        guard let config = AppConfig.Current?.Environment else {
            return ""
        }
        let root = config.rootURL
        let end = config.endPoint
        
        return "\(root)\(end)"
    }
    
    
    public static var defaultDateFormat : String{
        get{
            return  DATE_FORMAT_3
        }
    }
    
    public class func compareDate(dateInitial:Date, dateFinal:Date) -> Bool {
        let order = Calendar.current.compare(dateInitial, to: dateFinal, toGranularity: .second)
        switch order {
        case .orderedSame:
            return true
        default:
            return false
        }
    }
    //
    
    
    ///
    public class func parseDate(with date : String?, completion: @escaping (Bool,Date) -> Swift.Void) -> Date?{
        //
        guard let date = date else{
            //
            return nil
        }
        AppUtils.Log(from:self,with:AppUtils.TAG+" Date String = \(date)")
        let dateFormatter = DateFormatter()
        // dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = DATE_FORMAT_0
        //dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        var dateFromString:Date?
        //
        if let date = dateFormatter.date(from: date) {
            //AppUtils.Log(from:self,with:MtejaUtils.TAG+"Function 2: SUCCEEDED");
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            let _ = dateFormatter.string(from: date)
            
            AppUtils.Log(from:self,with:AppUtils.TAG+"F1 > Parsed Date = '\(date)' to '\(date.description(with: Locale.current))'")
            completion(true,date)
            //
            dateFromString = date
            //
        }else{
            //dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = DATE_FORMAT_1
            //
            if let date = dateFormatter.date(from: date) {
                //
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                let _ = dateFormatter.string(from: date)
                
                AppUtils.Log(from:self,with:AppUtils.TAG+"F2 > Parsed Date = '\(date)' to '\(date.description(with: Locale.current))'")
                completion(true,date)
                //
                dateFromString = date
            }//
            else{
                //dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                dateFormatter.dateFormat = DATE_FORMAT_2
                //
                if let date = dateFormatter.date(from: date) {
                    //AppUtils.Log(from:self,with:MtejaUtils.TAG+"Function 3:...");
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                    let _ = dateFormatter.string(from: date)
                    
                    AppUtils.Log(from:self,with:AppUtils.TAG+"F3 > Parsed Date = '\(date)' to '\(date.description(with: Locale.current))'")
                    completion(true,date)
                    //
                    dateFromString = date
                }else{
                    //dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                    dateFormatter.dateFormat = DATE_FORMAT_3
                    //
                    if let date = dateFormatter.date(from: date) {
                        //
                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                        let _ = dateFormatter.string(from: date)
                        
                        AppUtils.Log(from:self,with:AppUtils.TAG+"F4 > Parsed Date = '\(date)' to '\(date.description(with: Locale.current))'")
                        completion(true,date)
                        //
                        dateFromString = date
                    }else{
                        //dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                        dateFormatter.dateFormat = DATE_FORMAT_4
                        //
                        if let date = dateFormatter.date(from: date) {
                            //
                            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                            let _ = dateFormatter.string(from: date)
                            
                            AppUtils.Log(from:self,with:AppUtils.TAG+"F5 > Parsed Date = '\(date)' to '\(date.description(with: Locale.current))'")
                            completion(true,date)
                            //
                            dateFromString = date
                        }else{
                            AppUtils.Log(from:self,with:AppUtils.TAG+"!!!!>>>>>>>>>>>>>>>>>>PARSE DATE FAILED<<<<<<<<<<<!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                            completion(false,Date())
                        }
                    }
                }
                
            }
        }
        
        //
        return dateFromString
    }
    
    public class func getMaskedString(_ string:String?, prefixedBy:Int, sufixedBy:Int) -> String{
        //
        guard let text = string else{
            //Ooops..
            return ""
        }
        //
        if text.lengthOfBytes(using: .utf8) > (prefixedBy+sufixedBy){
            //
            let startConditionIndex = prefixedBy
            let endConditionIndex = text.count - sufixedBy
            //
            return String(text.enumerated().map { (index, element) -> Character in
                if index <= startConditionIndex {
                    return element
                }
                //
                if index < endConditionIndex {
                    return  "•"
                }
                return element
            })
        }
        
        return text
    }
    
    public class func getDateString(from date:Date, dateFormatter:DateFormatter) -> String{
        //
        let pars = Calendar.current.dateComponents([.day, .year, .month], from: date)
        //
        
        if pars.year == Calendar.current.dateComponents([.day, .year, .month], from: Date()).year{
            //
            if pars.month == Calendar.current.dateComponents([.day, .year, .month], from: Date()).month{
                dateFormatter.dateFormat = "HH:mm a"
                //
                if pars.day == Calendar.current.dateComponents([.day, .year, .month], from: Date()).day{
                    //
                    return "Today, \(dateFormatter.string(from: date))"
                }else if pars.day == Calendar.current.dateComponents([.day, .year, .month], from: Calendar.current.date(byAdding: .day, value: -1, to: Date())!).day{
                    //
                    return "Yesterday, \(dateFormatter.string(from: date))"
                }
            }
        }
        //
        return dateFormatter.string(from: date)
    }
    
    public class func getTimeGreetingVerb() -> String{
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 0..<12 :
            return(NSLocalizedString("Good Morning", comment: "Morning"))
        case 12 :
            return(NSLocalizedString("Good Afternoon", comment: "Noon"))
        case 13..<17 :
            return(NSLocalizedString("Good Afternoon", comment: "Afternoon"))
        case 17..<22 :
            return(NSLocalizedString("Good Evening", comment: "Evening"))
        default:
            return(NSLocalizedString("Good Day", comment: "Night"))
            //
        }
        //
        //return(NSLocalizedString("Good Day", comment: "Night"))
    }
    
    
    
    public static func generateRandomBytes(ofLength:Int) -> String? {
        
        var keyData = Data(count: ofLength)
        let result = keyData.withUnsafeMutableBytes {
            SecRandomCopyBytes(kSecRandomDefault, ofLength, $0.baseAddress!)
        }
        if result == errSecSuccess {
            return keyData.base64EncodedString()
        } else {
            return nil
        }
    }
    
    
    public static func generateRandomData(ofLength length: Int) throws -> Data? {
        var bytes = [UInt8](repeating: 0, count: length)
        let status = SecRandomCopyBytes(kSecRandomDefault, length, &bytes)
        if status == errSecSuccess {
            return Data(_ : bytes)
        }
        //
        return nil
    }
    
    public static func Log(from obj:AnyObject, with :String){
        //let message = #"String interpolation looks like this: \(with)."#
        if let env = AppConfig.Current?.Environment, env.IsDevt {
            //
            //debugPrint("\(String(describing: type(of: obj))) |:> \n\(with)\n")
            print("\(String(describing: type(of: obj))) |:> \n\(with)\n")
        }
        //print("\(String(describing: type(of: obj))) |:> \(with)")
    }
    
    public static func Timber(with :String){
        
        if let env = AppConfig.Current?.Environment, env.IsDevt {
            print("-----LOG BY TIMBER------ \n\(with)\n")
        }
        //print("\(String(describing: type(of: obj))) |:> \(with)")
    }
    
    
    
    
}
