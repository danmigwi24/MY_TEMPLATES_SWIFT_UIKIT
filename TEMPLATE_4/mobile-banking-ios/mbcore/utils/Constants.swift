//
//  Constants.swift
//  EasyRent
//
//  Created by  Daniel Kimanioloh on 22/09/2018.
//  Copyright © 2018  Daniel Kimanioloh. All rights reserved.
//

import Foundation

public struct UserPrefKeys {
    public static let KEY_SIGNUP_COMPLETE = "sigup-completed"
    public static let KEY_LOGIN_COMPLETE = "sigin-completed"
    public static let KEY_TRACK_IDLELING = "isidling"
    public static let KEY_WELCOMED = "welcomed"
    public static let KEY_FIRST_NAME = "first-name"
    public static let KEY_FULL_NAME = "full-name"
    public  static let KEY_FON_NUMBER = "fon-number"
    public static let KEY_NEW_USER = "newuser"
    public static let CUSTOMER_NUMBER = "customer-number"
    public static let KEY_NIN = "nin"
    public static let KEY_MAIL = "mail"
    public static let KEY_SESSION = "session-key"
    public static let Landing_Page_Dialog_Value = "this_value_help_decide_where_to_navigate"
}

extension Notification.Name {
    public static var appTimeOut: Notification.Name {
          return .init(rawValue: "NSNotification.App.AppTimeout")
        
    }
    static var appCheckRuntime: Notification.Name {
          return .init(rawValue: "NSNotification.App.CheckRuntime")
        
    }
    static let didReceiveData = Notification.Name("didReceiveData")
}

public struct AppNotifications{
   // public static let APP_IDLE_TIMEOUT = "NSNotification.App.AppTimeout"

    public static let TOGGLE_MENU = "NSNotification.toggle.menu"
    public static let OTP_CODE_RECEIVED = "NSNotification.OTP.Code"
    public static let SHOW_SIGNUP = "NSNotification.Redirect.To.Signup"
    public static let SHOW_SET_PIN = "NSNotification.Redirect.To.Set.Pin"
    public static let SHOW_LOGIN = "NSNotification.Redirect.To.Login"
    public static let SHOW_NOTIFICATIONS = "NSNotification.show.Notifications"
    public static let UPDATE_NOTIFICATIONS = "NSNotification.update.Notifications"
    public static let SHOW_TELL_A_FRIEND = "NSNotification.show.Tell.Friend"
    public static let SHOW_LOYALTY_POINTS = "NSNotification.show.Loyalty.Points"
    public static let SHOW_PROFILE = "NSNotification.show.user.Profile"
    public static let DO_LOGOUT = "NSNotification.logOut"
    public static let DRAWER_TOGGLED = "NSNotification.drawer.toggled"
    public static let UPDATE_NOK = "NSNotification.Update.NOK"
    public static let SHOW_ABOUT = "NSNotification.Show.About"
    public static let LOGIN_COMPLETED = "NSNotification.Lofin.Completed"
    public static let SHOW_PAYBILL = "NSNotification.Show.Paybill"
    public static let PREVIEW_NOTIFICATION = "NSNotification.Show.Local.Notification"
    public static let SHOW_CONTACT_US = "NSNotification.Show.Contact.Us"
    public static let PROFILE_UPDATED = "NSNotification.Profile.Updated"
    public static let SHOW_FEEDBACK = "NSNotification.Show.Local.Feedback"
    public static let SHOW_ALERTS_CONFIG = "NSNotification.Show.Alerts.Config"
    public static let SHOW_CHANGE_PIN = "NSNotification.Show.Change.Pin"
    
}

//MARK: Application Segues. Defined in app zibs
public struct AppSegues{
    //MAIN STORYBOARD
    public static let ONBOARDING = "showOnboardingSegue"
    public static let WELCOME_SEGUE = "showWelcomeSegue"
    public static let HELLO_SEGUE = "showHelloSegue"
    public static let ACTIVATE_ACCOUNT = "showActivateAccountSegue"
    public static let REGISTRATION_A_SEGUE = "showRegistrationASegue"
    public static let REGISTRATION_B_SEGUE = "showRegistrationBSegue"
    public static let OTP_SEGUE = "showOtpSegue"
    public static let SET_QUESTIONS_SEGUE = "showSetQuestionsSegue"
    public static let SET_EMAIL_SEGUE = "showSetEmailSegue"
    public static let CURRENT_PIN_SEGUE = "showCurrentPinSegue"
    public static let SET_PIN_SEGUE = "showSetPinSegue"
    public static let REENTER_PIN_SEGUE = "showRenterPinSegue"
    public static let UNWIND_TO_DASHBOARD_SEGUE = "unwindsegueToDashboard"
    
    //LANDING STORYBOARD
    public static let FRMOTPTOLOGIN = "goToLoginSegue"
    public static let LANDING = "showLandingSegue"
    public static let LOGIN_SEGUE = "showLoginSegue"
    public static let DASHBOARD_SEGUE = "showDashboardSegue"
    public static let MINI_STATEMENT = "showMiniStatementSegue"
    public static let FULL_STATEMENT = "showFullStatementSeque"
    public static let FULL_STATEMENT_DASHBOARD = "showFDashboardstatementSegue"
    public static let FORGOT_PIN = "showForgotPinSegue"
    public static let FromConfirmToLogin = "fromConfirmToLogin"
    
    //AIRTIME STORYBOARD
    public static let BUY_AIRTIME = "showBuyAirtimeSegue"
    
    //VALIDATE STORYBOARD
    public static let VALIDATE_TRANSACTION = "showValidateTransactionSegue"
    public static let AUTH_TRANSACTION = "showAuthVc"
    
    //SUCCESS STORYBOARD
    public static let TRANSACTION_SUCCESS = "showSuccessVc"
    
    //PAYBILL STORYBOARD
    public static let PAY_BILL = "showPaybillSegue"
    public static let BILL_SCHOOL = "showSchoolSegue"
    public static let BILL_PAYMENT = "showBillPaymentSegue"
    public static let KPLC_PAYMENT = "showKplcPaymentSegue"
    public static let SCHOOL_SERVICES = "showSchoolService"
    public static let SCHOOL_PAYMENT = "showSchoolPayment"
    public static let WATER_COMPANY = "showWaterCompanySegue"
    public static let WATER_PAYMENT = "showWaterPaymentSegue"
    
    //transfers storyboard
    public static let FUNDS_TRANSFER_SEGUE = "showFundsTransferSegue"
    public static let TRANSFER_OWN = "showTransferOwnSegue"
    public static let TRANSFER_MOBILE = "showTransferMobileSegue"
    
    //WITHDRAW STORYBOARD
    public static let WITHDRAW_CASH = "showWithdrawCashSegue"
    
    //DEPOSIT STORYBOARD
    public static let DEPOSIT_MONEY = "showCashDepositSegue"
    public static let DRAWER_PROFILE = "showSlidingDrawer"
    
    //WU
    public static let TRANSFER_WU = "showWU"

    
    
    public static let TRANSFER_HISTORY = "showFTHistorySegue"
    public static let TRANSFER_INTERNAL = "showTransferInternalSegue"
    //
    public static let TRANSFER_EFT = "showTransferEFTSegue"
    //
    public static let TRANSFER_RTGS = "showTransferRTGSSegue"
    //
    public static let TRANSFER_PESALINK = "showTransferPesalinkSegue"
    public static let TRANSFER_PESALINK_ACCOUNT = "showPesalinkSendToAccountSegue"
    public static let TRANSFER_PESALINK_CARD = "showPesalinkToCardSegue"
    //
    public static let TRANSFER_PESALINK_MOBILE = "showPesalinkToMobileSegue"
    //
    public static let TRANSFER_PESALINK_PRIMARY_ACCOUNT = "showPesalinkPrimaryAccountSegue"
    //
    public static let TRANSFER_PESALINK_LINK_TO_MOBILE = "showPesalinkLinkToMobileSegue"
    public static let TRANSFER_PESALINK_UNLINK_MOBILE = "showUnlinkPhoneSegue"
    public static let PESALINK_SETTINGS = "showPesalinkSettingsSegue"
    public static let PREVIEW_PESALINK_ACCOUNT = ""
    public static let PESALINK_HISTORY = "showPesalinkHistorySegue"
    
    
    public static let CONFIRM_PIN_SEGUE  = "showConfirmPinSegue"
    public static let GET_STARTED = "showGetStartedSegue"
    
    public static let MOBILE_BANKING = "showMobileBankingSegue"
    
    
    
    
   
    
    
    public static let REGISTRATION_F_SEGUE = "showRegistrationFSegue"
    public static let REGISTRATION_G_SEGUE = "showRegistrationGSegue"
    
    public static let ABOUT_US = "showAboutSegue"
    public static let SHOW_PRODUCTS = "showProductsSegue"
    public static let CONTACT_US  = "showContactUsSegue"
    
   
    
    public static let MOBILE_BANKING_DASHBOARD = "showMobileBankingDashSegue"
    public static let MOBILE_BANKING_MENUS = "showMobileBankingMenusSegue"
    
    
    
    public static let GET_HELP_US = "showHelpSegue"
    public static let LOCATE_US = "showLocateUsSegue"
    public static let FOREX_SEGUE = "showForexSegue"
    
   
    
    public static let QUICK_SERVICES = "showQuickServicesSegue"
    public static let SHOW_FAQs = "showFAQsSegues"
    public static let SHOW_FAQ_DETAILS = "showFAQDetailsSegue"
    
    
    public static let SHOW_CONTACTS = "showConSegue"
    //
    
    public static let ACCOUNTS_SEGUE = "accountsSegue"
    public static let START_SEGUE = "showStartSegue"
    public static let RETURNING_LOGIN = "showReturningLoginSegue"
    
    
    public static let ANSWER_SEC_QNS = "showAnswerSecQnsSegue"
    
    
    public static let SERVICES_SEGUE = "showServicesSegue"
    public static let LINK_ACCOUNT_SEGUE = "showLinkAccountSegue"
    public static let SIGNUP_DIVERT_SEGUE = "showSignupDivertSegue"
    
    public static let UPDATE_PROFILE = "shwoUpdateProfileSegue"
    
    //
    
    public static let MY_ACCOUNT_TRASNFER = "showMyAccountTransferSegue"
    public static let CONFIRM_MY_ACCOUNT_TRANSFER = "showConfirmMyAccountTransferSegue"
    public static let TRANSFER_SUCCESS = "showTransferSuccessSegue"
    
    public static let AIRTIME_PROVIDERS = "showAirtimeProvsSegue"
    
    public static let AIRTIME_HISTORY = "showAirtimeBenSegue"
    public static let AIRTIME_PURCHASE_SUCCESS = "showAirtimePurchaseSuccessSegue"
    //
    public static let STATEMENTS_SEGUE = "showStatementsSegue"
    
    
    //
    public static let MOBILE_MONEY_PROVIDERS = "showMobileMoneyProvidersSegue"
    public static let SEND_MOBILE_MONEY = "showSendMobileMoneySegue"
    public static let SEND_MM_HISTORY = "showMMHistorySegue"
    
    //
    public static let BILL_PAYMENTS = "showBillPaymentsSegue"
    public static let PAY_BILLS = "showPayBillsSegue"
    //
    public static let MPESA_CHECKOUT = "showMpesaCheckoutSegue"
    public static let MPESA_FLOAT = "showMpesaFloatSegue"
    //
    public static let DIASPORA_BANKING = "showDiasporaBankingSegue"
    public static let DIASPORA_DEPOSIT = "showDeposit1Segue"
    public static let DIASPORA_LINK_CARD = ""
    public static let DIASPORA_MY_CARDS = "showCardsSegue"
    public static let DB_DEPOSIT_1 = "showDeposit1Segue"
    public static let DB_DEPOSIT_2 = "showDeposit2Segue"
    //
    public static let REQUESTS_SEGUE = "showRequestsSegue"
    //
    public static let CHEQUE_BOOK_REQUEST = "showChequeBookSegue"
    public static let CHEQUE_SLEAVE_REQUEST = "showBankersChequeSegue"
    //
    public static let CARD_REQUEST = "showCardReqSegue"
    //
    public static let MANAGE_CARDS = "showManageCardsSegue"
    public static let CARD_SETTINGS = "showCardSettingsSegue"
    public static let LINK_DEBIT_CARD = "showLinkCardSegue"
    public static let UNLINK_DEBIT_CARD = "showUnLinkCardSegue"
    public static let RECHARGE_CARD = "showRechargeCardSegue"
    //
    public static let CARDLESS_WITHDRAW = "showCardlessWithdrawSegue"
    //
    public static let STANDING_ORDERS = "showStandingOrdersSegue"
    public static let STANDING_ORDER_LIST = "showSORListSegue"
    //
    public static let CHOOSE_BILLER = "showChooseBillerSegue"
    
    public static let NCC_PARKING = "showNCCPaybillSegue"
    
    //
    public static let PAY_MERCHANT_SERVICES = "showMerchantServicesSegue"
    public static let SEARCH_MERCHANT = "showSearchMerchantSegue"
    public static let MPESA_CHECKOUT_HISTORY = "showMpesaCheckoutHistSegue"
    //
    public static let SEARCH_SCHOOL = "showSearchSchoolSegue"
    //
    public static let PAY_SCHOOL_FEES = "showPaySchoolFeesSegue"
    //
    public static let SAVINGS_SEGUE = "showSavingsSegue"
    public static let OPEN_LOCK_SAVINGS = "showOpenLockSavingsSegue"
    public static let SEND_TO_LOCK_SAVINGS = "showSendToLockSavingsSegue"
    public static let SAVINGS_MINI_STATEMENT = "showSavingsMiniStatementSegue"
    public static let WITHDRAW_SAVINGS = "showWithdrawSavingsSegue"
    //
    public static let SAVING_ACCOUNTS = "showSavingAccountsSegue"
    public static let OPEN_CALL_DEPOSIT = "showOpenCallDepositSegue"
    public static let OPEN_FIXED_DEPOSIT = "showOpenFixedSavingsSegue"
    //
    
    //
   
    public static let SHOW_PRODUCT_ENTRIES = "showProductEntriesSegue"
    public static let PRODUCT_DETAILS = "showProductDetailsSegue"
    //
    public static let INVITE_FRIEND = "showInviteFriendSegue"
    public static let SHOW_PROFILE = "showProfileSegue"
    //
    public static let CREATE_STANDING_ORDER = "showSORSegue"
    //
    public static let LINKED_ACCOUNTS = "showLinkedAccountsSegue"
    public static let LOAN_CALCULATOR = "showCalculatorSegue"
    public static let LOAN_CALCULATIONS = "showLoanCalculationsSegue"
    
    //
    public static let SHOW_LOANS = "showLoansSegue"
    public static let MY_LOANS = "showMyLoansSegue"
    public static let LOAN_OPTIONS = "showLoanOptionsSegue"
    public static let REQUEST_LOAN = "showApplyLoanSegue"
    public static let LOAN_MINI_STATEMENT = "showLoanStatementSegue"
    public static let LOAN_FULL_STATEMENT = "showLoanFullStatementSegue"
    public static let LOAN_HISTORY = "showLoanFullHistorySegue"
    public static let PAY_LOAN = "showRepayLoanSegue"
    public static let LOAN_DETAILS = "showLoanDetailsSegue"
    public static let APPLY_SCORED_LOAN = "showScoredLoanSegue"
    public static let SHOW_CURRENT_LOANS = "showActiveLoansSegue"
    //
    public static let LOAN_SERVICES_01 = "showLoanServices01Segue"
    public static let LOAN_SERVICES_02 = "showLoanServices02Segue"
    //
    public static let ACCOUNTS_LIST = "showAccountsListSegue"
    public static let ACCOUNT_OPENING = "showAccountOpeningSegue"
    
    
    //
    public static let CREATE_STO = "showCreateSTOSegue"
    public static let UPDATE_STO = "showUpdateSORSegue"
    public static let MY_STOs = "showMySTOsSegue"
    //
    public static let SHOW_NOTIFICATIONS = "showNotificationsSegue"
    public static let NOTIFICATION_DETAILS = "showNotifDetailsSegue"
    
    //
    public static let TELLER_DETAILS = "showTellerSegue"
    public static let ECITIZEN_PAYBILL_SEGUE = "showECitizenPaybillSegue"
    //
    public static let SHOW_INSURANCE = "showInsuranceSegue"
    public static let COVER_OPTIONS = "showCoverOptionsSegue"
    public static let COVER_INFO = "showCoverInfoSegue"
    public static let RUNNING_COVERS = "showCoversListSegue"
    public static let SHOW_COVER_LEAD = "showInsuranceLeadSegue"
    //
    public static let PA_COVER_QUOTE = "showGetPAQuoteSegue"
    public static let PA_COVER_QUOTE_2 = "showGetPAQuote2Segue"
    public static let PA_COVER_QUOTE_3 = "showGetPAQuote3Segue"
    public static let PA_COVER_QUOTE_4 = "showGetPAQuote4Segue"
    public static let PA_COVER_QUOTE_5 = "showGetPAQuote5Segue"
    
    public static let MO_COVER_QUOTE = "showGetMOQuoteSegue"
    public static let MO_COVER_QUOTE_1 = "showGetMOQuote0Segue"
    public static let MO_COVER_QUOTE_2 = "showGetMOQuote1Segue"
    public static let MO_COVER_QUOTE_3 = "showGetMOQuote2Segue"
    public static let MO_COVER_QUOTE_4 = "showGetMOQuote3Segue"
    public static let MO_COVER_QUOTE_5 = "showGetMOQuote4Segue"
    public static let MO_COVER_QUOTE_6 = "showGetMOQuote5Segue"
    
    //
    public static let SHOW_TRADE_FINANCE = "showTradeFinanceSegue"
    public static let TF_BID_BOND_01 = "showBidBond01Segue"
    public static let TF_BID_BOND_02 = "showBidBond02Segue"
    public static let TF_BID_BOND_03 = "showGetBidBondQuote3Segue"
    public static let TF_PERFROMANCE_BIND = "showPerformanceBondSegue"
    public static let TF_BID_BOND_LEAD = "showTFBidBondLeadSegue"
    
    //
    public static let SHOW_MY_CLAIMS = "showMyClaimsSegue"
    public static let SHOW_ADD_CLAIM = "showAddClaim1Segue"
    public static let SHOW_ADD_CLAIM_2 = "showAddClaim2Segue"
    
    public static let ADD_COMPLAINT = "showAddComplaintSegue"
    
    public static let PAY_MERCHANT_01 = "showPayMerchant02Segue"
    public static let SHOW_SCAN_QR = "showSanQRSegue"
    
    static let TRANSFER_LOYALTY_POINTS = "showTransferLPSegue"
    static let REDEEM_LOYALTY_POINTS = "showRedeemPointsSegue"
    
    static let ACCOUNT_OPENING_02 = "showAccountOpening02segue"
    static let ACCOUNT_OPENING_03 = "showAccountOpening03segue"
    static let ACCOUNT_OPENING_04 = "showAccountOpening04segue"
    static let ACCOUNT_OPENING_05 = "showAccountOpening05segue"
    
    static let ACCOUNT_OPENING_DIVERT = "showOpenAccounDivertSegue"
}
