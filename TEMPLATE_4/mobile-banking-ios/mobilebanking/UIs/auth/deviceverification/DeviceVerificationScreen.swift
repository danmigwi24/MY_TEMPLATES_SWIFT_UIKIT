//
//  DeviceVerificationScreen.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 07/02/2024.
//

import Foundation
import SwiftUI
import MBCore





enum  OtpType{
    case  DEVICE_VERIFICATION,RESET_DEVICE_VERIFICATION
}


struct DeviceVerificationScreen: View {
    //1 -> Login , 2 -> Signup,3 -> forgot pin
    //@Binding
    var whatIsVerified:Int
    @State var otpText : String = ""
    //
    @State private var navigateToFirstTimeLogin:Bool = false
    @State private var navigateToCreatePin:Bool = false
    //
    @State private var remainingTime: Int = 5
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    //
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    //
    @State private var  deviceVerificationRequest = DeviceVerificationRequest()
    //MARK: NEEDED FOR API
    @StateObject var sharedViewModel = SharedViewModel()
    @EnvironmentObject var sheetNavigationViewModel: SheetNavigationViewModel
    //
    var body: some View {
        MainContent()
    }
    
    
}

/**
 *VIEW EXTEXTIONS*
 */
extension DeviceVerificationScreen {
    
    //MARK: SET UP UI
    @ViewBuilder
    func MainContent() -> some View {
        ZStack{
            Color(hexString: CustomColors.white).edgesIgnoringSafeArea(.all)
            VStack{
                GeometryReader { geometry in
                    //
                    LoadingView(isShowing: self.$sharedViewModel.isLoading) {
                        // SetUpUI()
                        SetUpUI(geometry:geometry)
                            .frame(width: geometry.size.width,height: geometry.size.height)
                        
                        //.frame(width:geometry.size.width,height: geometry.size.height)
                        //
                    }
                    
                }
            }//.edgesIgnoringSafeArea(.top)
        }
        .onChange(of: otpText) { newValue in
            if newValue.count >= 6 {
                //MARK: YOU CAN PERFORM AUTO VERIFICATION HERE
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
        .onAppear {
            Logger("whatIsVerified ============================== \(whatIsVerified)")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
                //otpText = "768678"
                //UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            
        }
        .alert(isPresented: $sharedViewModel.showAlert){
            CustomAlert(
                isPresented: $sharedViewModel.showAlert,
                title: "Info",
                decription: sharedViewModel.alertMessage
            )
        }
        .actionSheet(isPresented: self.$sharedViewModel.showActionSheet) {
            CustomActionSheet(
                isPresented: $sharedViewModel.showActionSheet,
                title: "Info",
                decription: sharedViewModel.actionSheetMessage
            )
        }
        
        .navigationBarTitle("",displayMode: .inline)
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    prepareRequest()
                    //navigateAction()
                }, label: {
                    Text("Next")
                        .foregroundColor(Color.blue)
                }).disableWithOpacity(remainingTime != 0)
            }
        }
        
    }
    
    
    
    //MARK: SET UP UI
    @ViewBuilder
    func SetUpUI(geometry:GeometryProxy) -> some View {
        ZStack(alignment: .top){
            //
            NavigationLink("", destination: LoginScreen(), isActive: $navigateToFirstTimeLogin).opacity(0)
            NavigationLink("", destination: Step1CreatePinScreen(), isActive: $navigateToCreatePin).opacity(0)
            //
            VStack(spacing: 10){
                
                //
                Spacer()
                //
                ContentView(geometry:geometry)
                    .padding(10)
                    .frame(maxWidth: .infinity,alignment: .center)
                    .frame(maxHeight: geometry.size.height * 0.8)
                    .background(Color.white)
                
                
            }
        }
    }
    
    @ViewBuilder
    func ContentView(geometry:GeometryProxy) -> some View {
        VStack{
            let phoneNo = getUserData(key: USERDEFAULTS.USER_PHONENUMBER)
            let formatPhoneNumber = formatPhoneNumber(phoneNo) ?? phoneNo
            //
            CustomTextBold(
                text: "We’ve sent you a verification code to +\(formatPhoneNumber)",
                textColor: .black,
                fontSize: 24,
                textAlignment: TextAlignment.leading
            )
            .padding(.vertical,12)
            .vSpacingWithMaxWidth(.leading)
            .onTapGesture {
                self.navigateToFirstTimeLogin.toggle()
            }
            
            //
            AutoFetchOTPTextField(
                otpText: $otpText,
                hint: "",
                numberofOtpFields: 6
            )
            .padding(.horizontal,20)
            .vSpacingWithMaxWidth(.center)
            //
            CountDownTimerView(
                remainingTime: $remainingTime,
                resendTitle: "Resend"
            )
            .vSpacingWithMaxWidth(.center)
            //
            Spacer()
            //
            if remainingTime == 0 {
                ButtonSection()
            }else{
                
            }
            
            
        }
    }
    
    //
    @ViewBuilder
    func ButtonSection() -> some View {
        VStack{
            CustomButtonFilled(
                action: {
                    performResendRequest()
                },
                title: "Resend",//otpText == "" ? "Resend" : "Continue",
                bgColor: remainingTime == 0 ? Color(hexString: CustomColors.darkBlue) : Color.gray.opacity(0.4),
                textColor: remainingTime == 0 ? Color.white : Color.black
            )
            .disableWithOpacity(remainingTime != 0)
            .padding(.horizontal,10)
            .padding(.bottom,20)
        }
    }
}


extension DeviceVerificationScreen {
    func navigateAction(){
                self.navigateToFirstTimeLogin.toggle()
    }
    
    func navigateActionWithParams(){
        Logger("whatIsVerified ============================== \(whatIsVerified)")
        //
        if otpText != ""{
            if whatIsVerified == 1 {
                self.navigateToFirstTimeLogin.toggle()
                Logger("navigateToLogin")
            }else if whatIsVerified == 2{
                self.navigateToCreatePin.toggle()
                Logger("navigateToCreatePin")
            }else{
                //self.navigateToLogin.toggle()
            }
        }else{
            remainingTime = 10
        }
    }
    
    /*
     ** API REQUEST PREPERATION
     */
    private func prepareRequest(){
        //
        var payload = DeviceVerificationRequest()
        payload.phoneNumber = getUserData(key: USERDEFAULTS.USER_PHONENUMBER)
        payload.otpValue = otpText
        //
        if whatIsVerified == 1 {
            payload.otpType = "\(OtpType.DEVICE_VERIFICATION)"
        }else if whatIsVerified == 2{
            payload.otpType = "\(OtpType.RESET_DEVICE_VERIFICATION)"
        }else{
            payload.otpType = "\(OtpType.DEVICE_VERIFICATION)"
        }
        self.performVerificationRequest(model: payload)
    }
    
    //MARK: - AccountLookUp
    private  func performVerificationRequest(model: DeviceVerificationRequest){
        AppUtils.Timber(with: "accountWalletActivation \(model)")
        sharedViewModel.isLoading = true
        RequestManager.ApiInstance.verifyDevice(requestBody: model) {status, message,responseModel in
            
            DispatchQueue.main.async{
                sharedViewModel.isLoading = false
                
                if status {
                    guard let response = responseModel else {
                        alertDialog(message: "\(message ?? "")")
                        return
                    }
                    
                    guard let status =  response.status else {
                        alertDialog(message: "\(message ?? "")")
                        return
                    }
                    
                    //00 -> Mobile Activation
                    //05-> Device verify
                    //06-> Login
                    //07-> Identification mismatch. You have 4 lookup counts left.
                    //10-> AccountLookup Failed -> Wallet creation
                    
                    if status == "00"{
                        //alertDialog(message: "Mobile Activation")
                        print("SUCCESS")
                        navigateAction()
                    }else{
                        alertDialog(message: response.message)
                    }
                    
                    
                    
                }else{
                    alertDialog(message: "\(message ?? "")")
                }
            }
            //
        }
    }
    
    //MARK: - RESEND
    private  func performResendRequest(){
        //
        
        //
        var payload = ResendVerificationRequest()
        payload.phoneNumber = getUserData(key: USERDEFAULTS.USER_PHONENUMBER)
        //
        if whatIsVerified == 1 {
            payload.otpType = "\(OtpType.DEVICE_VERIFICATION)"
        }else if whatIsVerified == 2{
            payload.otpType = "\(OtpType.RESET_DEVICE_VERIFICATION)"
        }else{
            payload.otpType = "\(OtpType.DEVICE_VERIFICATION)"
        }
        AppUtils.Timber(with: "accountWalletActivation \(payload)")
        //
        sharedViewModel.isLoading = true
        RequestManager.ApiInstance.resendOtp(requestBody: payload) {status, message,responseModel in
            
            DispatchQueue.main.async{
                sharedViewModel.isLoading = false
                
                if status {
                    guard let response = responseModel else {
                        alertDialog(message: "\(message ?? "")")
                        return
                    }
                    
                    guard let status =  response.status else {
                        alertDialog(message: "\(message ?? "")")
                        return
                    }
                    
                    //00 -> Mobile Activation
                    //05-> Device verify
                    //06-> Login
                    //07-> Identification mismatch. You have 4 lookup counts left.
                    //10-> AccountLookup Failed -> Wallet creation
                    
                    if status == "00"{
                        //alertDialog(message: "Mobile Activation")
                        print("SUCCESS")
                        remainingTime = 20
                    }else{
                        alertDialog(message: response.message)
                    }
                    
                    
                    
                }else{
                    alertDialog(message: "\(message ?? "")")
                }
            }
            //
        }
    }
    //
    private func alertDialog(message:String?){
        //CustomAlertDailog(title: "Info", message: message ?? "Response could not be processed", primaryText: "Ok", primaryAction: {})
        //showCustomizedSwiftMessages(title: "Error", body:"Middle required")
        sharedViewModel.showAlert(message: message ?? "Response could not be processed")
    }
    
    //MARK: Validate Fields
    func validateFields() -> Bool {
        guard !otpText.isEmpty else {
            showCustomizedSwiftMessages(title: "Error", body:"Firstname required")
            return false
        }
        
        return true
        
    }
}
