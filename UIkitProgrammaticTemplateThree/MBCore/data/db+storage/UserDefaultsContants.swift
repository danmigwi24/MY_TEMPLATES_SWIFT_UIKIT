//
//  UserDefaultsContants.swift
//  MobileBanking
//
//  Created by Daniel Kimani on 06/02/2024.
//

import Foundation


//
public enum USERDEFAULTS {
    public static let HAS_SEEN_ONBOARDING = "HAS_SEEN_ONBOARDING"
    //
    public static let IS_FIRST_TIME_INSTALL = "IS_FIRST_TIME_INSTALL"
    //
    public static let USER_PHONENUMBER = "USER_PHONENUMBER"
    public static let USER_NAME = "USER_NAME"
    public static let FULL_NAME = "FULL_NAME"
    public static let DOB = "DOB"
    public static let GENDER = "GENDER"
    public static let USER_IDNUMBER = "USER_NAME"
    public static let ACCESS_TOKEN = "TOKEN"
    public static let OLD_CODE = "OLD_CODE"
    //
    public static let USER_LANGUAGE = "USER_LANGUAGE"
    public  static let EDITTED_PROFILE_IMAGE = "EDITTED_PROFILE_IMAGE"
    public  static let SIGNING_IMAGE = "SIGNING_IMAGE"
    //MARK: ECNCRYPTION
    public  static let SESSION_ID = "SESSION_ID"
    public  static let GENERATED_IV = "GENERATED_IV"
    public  static let AES_KEY = "AES_KEY"
    //MARK: ACC
    public static let HAS_FINISHED_ACCOUNT_OPENING = "HAS_FINISHED_ACCOUNT_OPENING"
    public static let IS_EDITING_USER_DATA = "IS_EDITING_USER_DATA"
    //
    public  static let ID_FRONT_IMAGE = "ID_FRONT_IMAGE"
    public  static let ID_BACK_IMAGE = "ID_BACK_IMAGE"
    public  static let SELFIE_IMAGE = "SELFIE_IMAGE"
    //
    
    //
}
//

extension USERDEFAULTS{
    public  static let KEY_LOGIN_COMPLETE = "KEY_LOGIN_COMPLETE"
    public  static let KEY_TRACK_IDLELING = "KEY_TRACK_IDLELING"
}
