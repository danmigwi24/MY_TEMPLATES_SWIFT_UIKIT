//
//  AppConfig.swift
//  iOSTemplateApp
//
//  Created by  Daniel Kimani on 19/03/2019.
//  Copyright © 2020 Eclectics Int. All rights reserved.
//

import Foundation
import CoreData

public class AppConfig:NSObject{
    
    public static let PINMaskingKey = "*"
    public static let TOUCH_ID_MASK = "----"
    
    fileprivate static var _config: Config?
    var persistentContainer:NSPersistentContainer?
    
    
    public static var Current:Config?{
        get {
            if _config == nil {
                //Init...
                let _ = AppConfig()
            }
            
            return _config
        }
        set{
            //
            if let g = newValue {
                //Only Crypto Config can be changed
                _config?.cryptoConfig = g.cryptoConfig
            }
        }
    }
    
    override init(){
        super.init()
        //
        do {
            //
            if let url = Bundle.main.url(forResource: "mb-config", withExtension: "plist") {
                //
                let data = try Data(contentsOf: url)
                //
                var config = try PropertyListDecoder().decode(Config.self, from: data)
                
                
                //
                if config.Environment!.IsDevt {
                    //
                    config.showLimits = false
                }
                AppConfig._config = config
            }
        }catch{
            AppConfig._config = nil
            print(error)
            AppUtils.Log(from:self,with:"Load Config Error :: \(error)")
        }
    }
}

public struct Config: Decodable {
    private var environments : [AppEnvironment]
    public var client:Client
    public var restrictResponses:Bool
    public var showLimits:Bool
    public var migrations:DbMigration
    public var enforceNoK:Bool
    public var enforceLoginOtp:Bool
    public var enforceUpdates:Bool
    public var useSwiftUI:Bool
    //
    public var accountLength:Int
    //
    public var urls:ExternalLinks
    //
    public var messages:AppMessages
    //
    public var limits:TransactionLimit
    //
    public var cryptoConfig:CryptoConfig
    //
    public var services:AppServices
    //
    public var contacts:AppContacts
    //
    public var invites:AppInvite
    // MARK: Computed field
    public var Environment:AppEnvironment?{
        get{
            //Get the environment marked as active
            return environments.first(where: { (e) -> Bool in
                return e.active
            })
        }
    }
    //
    enum CodingKeys : String, CodingKey {
        case environments
        case client = "client"
        case restrictResponses = "restrictResponse"
        case cryptoConfig = "crypto"
        case migrations = "db-migrations"
        case showLimits = "show-limits"
        case enforceNoK = "enforce-nok"
        case enforceUpdates = "enforce-updates"
        case useSwiftUI = "use-swift-ui"
        //
        case urls = "urls"
        //
        case accountLength = "acc-length"
        case enforceLoginOtp = "enforce-rv-otp"
        //
        case messages
        case limits
        case services
        case contacts
        case invites
    }
    
}
//
public struct CryptoConfig: Decodable {
    public var active:Bool
    public var aesKey:String
    public var rsaKey:String
    enum CodingKeys : String, CodingKey {
        case active = "enabled"
        case aesKey = "aes-key"
        case rsaKey = "rsa-pk"
    }
}
//
public struct AppCharges:Decodable {
    public var linkAccount:String
    public var approveTransfer:String
    public var startSTO:String
    public var amendSTO:String
    enum CodingKeys:String,CodingKey{
        case linkAccount = "link-account"
        case approveTransfer = "approve-transfer"
        case startSTO = "start-sto"
        case amendSTO = "amend-sto"
    }
    
}
//
public struct AppMessages:Decodable{
    public var serviceError:String
    public var connectionError:String
    public var transactionSuccess:String
    public var appUpdates:String
    public var idfaPermission:String
    public var deviceRootError:String
    public var deviceSimulationError:String
    public var sessionExpired:String
    
    enum CodingKeys:String,CodingKey{
        case serviceError = "service-error"
        case connectionError = "conn-error"
        case transactionSuccess = "trans-success"
        case appUpdates = "app-update"
        case idfaPermission = "IDFA-permission"
        case deviceRootError = "device-root-error"
        case deviceSimulationError = "device-simulation-error"
        case sessionExpired = "session-expired"
    }
}
//
public struct AppInvite:Decodable{
    public var whatsAppInvite:String
    public var fbMessangerInvite:String
    public var twitterInvite:String
    public var emailInvite:String
    public var hangoutsInvite:String
    public var smsInvite:String
    
    enum CodingKeys:String,CodingKey{
        case whatsAppInvite = "whatsapp-invite"
        case fbMessangerInvite = "fb-messanger-invite"
        case twitterInvite = "twitter-invite"
        case emailInvite = "email-invite"
        case hangoutsInvite = "hangouts-invite"
        case smsInvite = "sms-invite"
    }
}
//
public struct ExternalLinks:Decodable{
    public var tncLink:String
    public var privacyLink:String
    public var appStoreLink:String
    public var googleKey:String
    
    enum CodingKeys:String,CodingKey{
        case tncLink = "tnc-url"
        case privacyLink = "privacy-url"
        case appStoreLink = "app-store"
        case googleKey = "google-key"
    }
}
//
public struct TransactionLimit:Decodable{
    public var minAirtime:Double
    public var maxAirtime:Double
    public var minPaybill:Double
    public var maxPaybill:Double
    public var minMobileMoney:Double
    public var maxMobileMoney:Double
    public var minEFT:Double
    public var maxEFT:Double
    public var minRTGS:Double
    public var maxRTGS:Double
    public var minPesalink:Double
    public var maxPesalink:Double
    public var minIT:Double
    public var maxIT:Double
    public var minOT:Double
    public var maxOT:Double
    public var minFCY:Double
    enum CodingKeys:String,CodingKey{
        case minAirtime = "min-airtime"
        case maxAirtime = "max-airtime"
        case minPaybill = "min-paybill"
        case maxPaybill = "max-paybill"
        case minEFT = "min-eft"
        case maxEFT = "max-eft"
        case minMobileMoney = "min-mobile-money"
        case maxMobileMoney = "max-mobile-money"
        case minRTGS = "min-rtgs"
        case maxRTGS = "max-rtgs"
        case minPesalink = "min-pesalink"
        case maxPesalink = "max-pesalink"
        case minIT = "min-it"
        case maxIT = "max-it"
        case minOT = "min-ot"
        case maxOT = "max-ot"
        case minFCY = "min-fcy"
    }
}
//
public struct AppEnvironment:Decodable {
    public var name:String
    public var active:Bool
    public var earlyRelease:Bool
    public var appTimeout:Double
    //
    public var rootURL:String
    public var endPoint:String
    //
    public var ussdShortCode:String
    public var shufflePINKeyboard:Bool
    //
    public var PK_1,PK_2:String
    // Mark: Computed value
    public var IsDevt :Bool {
        get{
            return name.lowercased() == "development"
        }
    }
    // Mark: Computed value
    public var IsEarlyTest:Bool{
        get{
            return !IsDevt && earlyRelease
        }
    }
    
    enum CodingKeys:String,CodingKey{
        case name
        case active
        case earlyRelease = "early-build"
        case rootURL = "base-path"
        case appTimeout = "app-timeout"
        case endPoint = "end-point"
        case ussdShortCode = "short-code"
        case shufflePINKeyboard = "shuffle-keyboard"
        case PK_1 = "pks-1"
        case PK_2 = "pks-2"
    }
}
//
public struct AppServices:Decodable,PropertyNames{
    //MARK: Endpoints
    public var handShake:AppService
    public var branches:AppService
    public var agencies:AppService
    public var phoneLookup:AppService
    public var requestOtp:AppService
    public var verifyOtp:AppService
    public var login:AppService
    public var register:AppService
    public var secQuestions: AppService
    public var setQuestionAnswers: AppService
    public var getUserQuestions: AppService
    public var unlock:AppService
    public var charges:AppService
    public var mini: AppService
    public var bi: AppService
    public var full: AppService
    public var deposit: AppService
    public var internalTransfer: AppService
    public var internalTransferLookUp: AppService
    public var withdraw: AppService
    public var billers: AppService
    public var billerPresentment: AppService
    public var waterPresentment: AppService
    public var payBill: AppService
    public var billerCategory: AppService //schoolfees
    public var billServices: AppService
    public var feesPresentment: AppService
    public var waterCompany: AppService
    public var wuToken: AppService
    public var wuJwt: AppService
    public var wulookUp: AppService
    public var sendWuKyc: AppService
    public var ipslPhoneLookup, ipslAccLookup,ipslbanks, ipslft, ipslLinking: AppService
    public var chargesNonB,airtimeNonB,listBillNonB,billCategoryNonbank, waterCompanyNonB,waterPresentmentNonB,studentPrsentmentNonB,tvPresentmentNonB,billPaymentNonB: AppService
    public var acctypes:AppService
    public var accrequirements:AppService
    public var iprs:AppService
    public var newAccOpening:AppService
    public var existAccOpening:AppService
    public var tokenFt:AppService
    public var tokenLookUp:AppService
    public var tokenEncashment:AppService
    public var registerTill,tillLookup:AppService
    
    
    public var logOut: AppService
    
    
    
    
    public var updateSecQns,secQuestionsAnswer,userSecQuestions:AppService
    public var nccRegions:AppService
    public var accountCards,cardLimits,blockCard,unblockCard,updateCardLimits:AppService
    public var nccVehicleTypes:AppService
    public var nccPresentment:AppService
    public var ecitizenPresentment:AppService
    public var insuranceLead:AppService
    
    public var insuranceProducts:AppService
    
    public var mpesaStkPush:AppService
    public var validateAccOpening:AppService
    public var activateWallet:AppService
    public var updateNok:AppService
    public var activateDigitalAccount,activateExtDigitalAccount:AppService
    public var loanProducts:AppService
    public var loanDetails,loanScoreParams,externalLoanScoreParams:AppService
    public var loanPayment:AppService
    public var userLoans:AppService
    public var loanFullstatement:AppService
    public var loanRequest,applyLoan,loanMiniStatement,loanHistory :AppService
    public var openAccount,openAccountLead,openDigitalAccountSignup,activateDormantAccount:AppService
    public var checkOtp:AppService
    public var rtgsTransfer:AppService
    public var forex:AppService
    public var linkPesalinkPhone:AppService
    public var updatePesalink:AppService
    public var pesalinkTransfer:AppService
    public var paybill:AppService
    public var billPresentment:AppService
    public var lockSavings:AppService
    public var openFixedSavings,closeFixedSavings,depositFixedSavings:AppService
    public var openCallSavings,closeCallSavings,depositCallSavings:AppService
    public var externalSor,internalSor:AppService
    public var stopChequebook,confirmChequebook:AppService
    public var newChequebook,bankersCheque:AppService
    public var replaceCard, newCard:AppService
    public var fullstatement:AppService
    public var ministatement:AppService
    public var editSor,stopSor:AppService
    public var sorLookup:AppService
    public var pesalinkLookup:AppService
    public var accountLookup:AppService
    public var bankLookup:AppService
    public var bankBranchesLookup:AppService
    public var schoolLookup:AppService
    public var schoolFees:AppService
    public var balanceInquiry:AppService
    public var transactionCharges:AppService
    public var topup:AppService
    public var eFundtransfer:AppService
    public var fundtransfer:AppService
    public var sendMobileMoney:AppService
    public var changePin,transactionOtp:AppService
    
    public var financialData:AppService
    public var feedback,complaint:AppService
    public var rechargeDebitCardCoreAcc:AppService
    public var rechargeDebitCardMobileMoney:AppService
    public var connectDebitCard:AppService
    public var addBeneficiary:AppService
    public var removeBeneficiary:AppService
    public var allBeneficiaries:AppService
    public var merchantLookup:AppService
    public var merchantPayment:AppService
    public var cardlessWithdrawal,agentLookup,agentWithdrawal,atmWithdrawal:AppService
    public var merchantRefPayment:AppService
    public var redeemLoyaltyPoints,transferLoyaltyPoints:AppService
    public var loyaltyPointsBalance:AppService
    public var inviteFriend:AppService
    public var depositMoney:AppService
    public var depositFromMpesa:AppService
    public var tellers:AppService
    public var ads:AppService
    public var callSavingAccounts,fixedSavingAccounts:AppService
    public var fetchTellers:AppService
    public var resetPinOtp:AppService
    public var linkAccount:AppService
    public var unlinkedBankAccounts, unlinkBankAccount, dormantBankAccounts, linkedBankAccounts, linkBankAccount:AppService
    public var enabledServices:AppService
    
    enum CodingKeys:String,CodingKey{
        case handShake = "handshake"
        case branches = "branches"
        case agencies = "agencies"
        case charges = "charges"
        case requestOtp = "setOtp"
        case verifyOtp = "verifyOtp"
        case setQuestionAnswers = "set-question-answers"
        case getUserQuestions = "get-user-questions"
        case unlock = "unlock"
        case secQuestionsAnswer = "answer-sec-qns"
        case updateSecQns = "set-sec-qns"
        case mini = "mini"
        case bi = "bi"
        case full = "full"
        case deposit = "deposit"
        case internalTransfer = "internalFt"
        case internalTransferLookUp = "cbsLookup"
        case withdraw = "withdraw"
        case billers = "listBillers"
        case billerPresentment = "biller-presentment"
        case payBill = "billpayment"
        case billerCategory = "biller-categories"
        case billServices = "serviceCodes"
        case feesPresentment = "schoolfees-presentment"
        case waterPresentment = "water-presentment"
        case waterCompany = "water-company"
        case wuToken = "wu-token"
        case wuJwt = "getWuJwt"
        case sendWuKyc = "sendWuKyc"
        case wulookUp = "wuKycLookUp"
        case ipslPhoneLookup = "ipslPhoneLookup"
        case ipslAccLookup = "ipslAccLookup"
        case ipslbanks = "ipslbanks"
        case ipslft = "ipslft"
        case ipslLinking = "ipslLinking"
        case chargesNonB = "charges-nonb"
        case airtimeNonB = "airtime-nonb"
        case listBillNonB = "list-bill-nonb"
        case billCategoryNonbank = "bill-category-nonbank"
        case waterCompanyNonB = "water-company-nonB"
        case waterPresentmentNonB = "water-presentment-nonb"
        case studentPrsentmentNonB = "student-presentment-nonB"
        case tvPresentmentNonB = "tv-presentment-nonB"
        case billPaymentNonB = "bill-payment-nonb"
        case acctypes  = "acctypes"
        case accrequirements  = "accrequirements"
        case iprs  = "iprs"
        case newAccOpening  = "new-acc-opening"
        case existAccOpening  = "open-acc-existing"
        case tokenFt  = "tokenFt"
        case tokenLookUp  = "tokenLookUp"
        case tokenEncashment  = "tokenEncashment"
        case tillLookup  = "till-services"
        case registerTill  = "new-till"
        case logOut = "logout"
        
        
        
        
        case tellers = "client-tellers"
        case nccVehicleTypes = "ncc-vtypes"
        case accountCards = "account-cards"
        case cardLimits = "card-limits"
        case nccRegions = "ncc-regions"
        case nccPresentment = "ncc-presentment"
        case ecitizenPresentment = "ecitizen-presentment"
        case activateDigitalAccount = "open-digital-account"
        case activateExtDigitalAccount = "activate-ext-digital-account"
        case activateDormantAccount = "activate-dormant-account"
        case insuranceProducts = "insurance-products"
        
        
        
        case insuranceLead = "insurance-leads"
        case phoneLookup  = "phone-lookup"
        case mpesaStkPush  = "mpesa-stk-push"
        case validateAccOpening  = "validate-acc-opening"
        case activateWallet  = "activate-wallet"
        case updateNok  = "update-nok"
        case secQuestions = "sec-questions"
        case userSecQuestions = "user-sec-qns"
        case loanProducts = "loan-products"
        case loanDetails  = "loan-details"
        case loanPayment  = "loan-payment"
        case userLoans  = "user-loans"
        case loanScoreParams = "loan-score-params"
        case loanFullstatement  = "loan-fullstatement"
        case loanRequest  = "loan-request"
        case applyLoan = "apply-loan"
        case loanMiniStatement = "loan-mini-statement"
        case loanHistory = "loan-history"
        case openAccount  = "open-account"
        case openDigitalAccountSignup = "open-digital-account-signup"
        case openAccountLead = "open-account-lead"
        case checkOtp  = "check-otp"
        case linkAccount  = "link-account"
        case rtgsTransfer  = "rtgs-transfer"
        case forex  = "forex"
        case linkPesalinkPhone  = "link-pesalink-phone"
        case updatePesalink  = "update-pesalink"
        case pesalinkTransfer  = "pesalink-transfer"
        case paybill  = "paybill"
        case billPresentment  = "bill-presentment"
        case lockSavings  = "lock-savings"
        case externalSor  = "external-sto"
        case internalSor  = "internal-sto"
        case editSor  = "edit-sto"
        case stopSor  = "stop-sto"
        case sorLookup  = "sto-lookup"
        case stopChequebook  = "stop-chequebook"
        case newChequebook  = "new-chequebook"
        case bankersCheque = "bankers-cheque"
        case replaceCard  = "replacecard"
        case newCard  = "newcard"
        case blockCard  = "block-card"
        case unblockCard = "unblock-card"
        case updateCardLimits = "update-card-limits"
        case fullstatement  = "fullstatement"
        case ministatement  = "ministatement"
        case pesalinkLookup  = "pesalink-lookup"
        case accountLookup  = "account-lookup"
        case bankLookup  = "bank-lookup"
        case bankBranchesLookup = "branches-lookup"
        case schoolLookup  = "school-lookup"
        case schoolFees  = "school-fees"
        case balanceInquiry  = "balance-inquiry"
        case transactionCharges  = "transaction-charges"
        case topup  = "topup"
        case eFundtransfer  = "e-ft"
        case fundtransfer  = "ft"
        case sendMobileMoney  = "mobile-money"
        case changePin  = "change-pin"
        case transactionOtp = "transaction-otp"
        case login  = "login"
        case register  = "register"
        case financialData = "financial-analysis"
        case feedback
        case complaint = "user-complaint"
        case rechargeDebitCardCoreAcc = "recharge-card-core-acc"
        case rechargeDebitCardMobileMoney = "recharge-card-mobile-money"
        case connectDebitCard = "connect-debit-card"
        case addBeneficiary = "add-beneficiary"
        case removeBeneficiary = "remove-beneficiary"
        case allBeneficiaries = "all-beneficiaries"
        case merchantLookup = "merchant-lookup"
        case merchantPayment = "merchant-payment"
        case cardlessWithdrawal = "cardless-withdrawal"
        case confirmChequebook = "confirm-chequebook"
        case merchantRefPayment = "merchant-ref-payment"
        case redeemLoyaltyPoints = "redeem-loyalty-points"
        case transferLoyaltyPoints = "transfer-loyalty-points"
        case loyaltyPointsBalance = "loyalty-points-balance"
        case inviteFriend = "invite-friend"
        case depositMoney = "deposit-money"
        case ads = "ads"
        case depositFromMpesa = "mpesa-deposit"
        //
        case callSavingAccounts = "call-saving-accs"
        case openCallSavings = "open-call-savings"
        case depositCallSavings = "deposit-call-savings"
        case closeCallSavings = "close-call-savings"
        //
        case fixedSavingAccounts = "fixed-saving-accs"
        case openFixedSavings = "open-fixed-savings"
        case depositFixedSavings = "deposit-fixed-savings"
        case closeFixedSavings = "close-fixed-savings"
        case fetchTellers = "tellers"
        case resetPinOtp = "reset-pin-otp"
        case linkBankAccount = "link-bank-account"
        case unlinkBankAccount = "unlink-bank-account"
        case linkedBankAccounts = "linked-bank-accounts"
        case unlinkedBankAccounts = "unlinked-bank-accounts"
        case dormantBankAccounts = "dormant-bank-account"
        //
        case agentLookup = "agent-lookup"
        case agentWithdrawal = "agent-withdrawal"
        case atmWithdrawal = "atm-withdrawal"
        case externalLoanScoreParams = "external-loan-score-param"
        case enabledServices = "enabled-services"
    }
}
//
public struct AppService:Decodable{
    
    public var icon:String
    public var code:String
    public var endpoint:String
    public var active:Bool
    
    enum CodingKeys:String,CodingKey{
        case icon
        case code
        case endpoint
        case active
    }
}
//
public struct AppContacts:Decodable{
    public var phone:String
    public var email:String
    public var fbLink:String
    public var fbProfile:String
    public var twitterLink:String
    public var twitterProfile:String
    public var linkedinLink:String
    public var linkedinProfile:String
    public var youtubeLink:String
    public var instagramLink:String
    public var instagramProfile:String
    
    enum CodingKeys:String,CodingKey{
        case phone
        case email
        case youtubeLink = "youtube-link"
        case fbProfile = "facebook-profile"
        case fbLink = "facebook-link"
        case twitterLink = "twitter-link"
        case twitterProfile = "twitter-profile"
        case linkedinLink = "linkedin-link"
        case linkedinProfile = "linkedin-profile"
        case instagramProfile = "instagram-profile"
        case instagramLink = "instagram-link"
    }
}
//
public struct Client:Decodable{
    public var name:String
    public var code:String
    public var swiftCode:String
    public var sortCode:String
    enum CodingKeys:String,CodingKey{
        case name
        case code
        case swiftCode
        case sortCode
    }
}
//
public struct DbMigration:Decodable{
    public var enabled:Bool
    public var version:String
    
    enum CodingKeys:String,CodingKey{
        case enabled
        case version = "current-version"
    }
}
