//
//  LoginScreen.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 07/02/2024.
//

import Foundation
import SwiftUI
import MBCore
import LocalAuthentication


struct LoginScreen: View {
    
    @State var pinCode:String = ""
    //
    @State private var navigateToHome:Bool = false
    @State private var navigateToForgotPassword:Bool = false
    @State private var navigateToTakeSelfie:Bool = false
    //
    @State private var showDialog:Bool = false
    @State private var showDialogVoiceActication:Bool = false
    @State private var showDialogFingerPrint:Bool = false
    @State private var showDialogFace:Bool = false
    //
    @State private var isUnlockedWithFaceId = false
    
    //MARK: NEEDED FOR API
    @EnvironmentObject var sheetNavigationViewModel: SheetNavigationViewModel
    @StateObject var sharedViewModel = SharedViewModel()
    //
    var body: some View {
        MainContent()
    }
    
    
}

/**
 *VIEW EXTEXTIONS*
 */
extension LoginScreen {
    
    //MARK: SET UP UI
    @ViewBuilder
    func MainContent() -> some View {
        VStack{
            GeometryReader { geometry in
                //
                LoadingView(
                    isShowing: self.$sharedViewModel.isLoading
                ) {
                    SetUpUI(geometry:geometry)
                        .background(Color.white)
                        .frame(width: geometry.size.width,height: geometry.size.height)
                    //
                    
                }
                
            }.frame(maxWidth: .infinity,maxHeight: .infinity)
        }
        .onAppear {
            
            
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
    }
    
    
    
    //MARK: SET UP UI
    @ViewBuilder
    func SetUpUI(geometry:GeometryProxy) -> some View {
        ZStack(alignment: .top){
            //
            NavigationLink("", destination: ForgotPasswordScreen(), isActive: $navigateToForgotPassword)
            NavigationLink("", destination: HomeMainScreen(), isActive: $navigateToHome)
            NavigationLink("", destination: TakeSelfieScreen(), isActive: $navigateToTakeSelfie)
            //
            VStack(spacing:10){
                
                LogoView()
                //
                ContentView(geometry: geometry)
                
            }
            .padding(.horizontal,10)
            .padding(.bottom,10)
            
            if showDialog {
                CustomSwiftUIDialog(showDialog: $showDialog) {
                    ActivateYourBiometricsDialog(){
                        withAnimation(.spring()) {
                            showDialog = false
                            showDialogVoiceActication = true
                        }
                        
                    }
                }
                
            }
            
            if showDialogVoiceActication {
                CustomSwiftUIDialog(showDialog: $showDialogVoiceActication) {
                    ActivateUseVoiceIDBiometricsDialog(){
                        withAnimation(.spring()) {
                            showDialogVoiceActication = false
                        }
                    }
                }
            }
            
            
        }
        .background(Color(hexString: CustomColors.white).edgesIgnoringSafeArea(.all))
        .onChange(of: pinCode) { newValue in
            print("newValue => \(newValue)")
            if newValue.count >= 4{
                submitAction()
            }
        }
    }
    @ViewBuilder
    func ContentView(geometry:GeometryProxy)-> some View {
        VStack{
            //
            let hello = "Hello \(getUserData(key: USERDEFAULTS.USER_NAME))!"
            CustomTextBold(text: "Hello Doe!", textColor: .black, fontSize: 20, textAlignment: .center).vSpacingWithMaxWidth(.center)
            //
            CustomTextMedium(text: "Enter your Pin to Login", textColor: Color(hexString: CustomColors.darkBlue), fontSize: 14, textAlignment: .center).vSpacingWithMaxWidth(.center)
            //
            KeyPadView(pinCode: $pinCode)
                .frame(minHeight:  geometry.size.height * 0.45)
            //.frame(maxHeight: geometry.size.height * 0.6)
            //.background(Color.red)
            //
            ForgotPinBiometricsView()
            //
        }
        
        .sheet(
            isPresented: $sheetNavigationViewModel.navigateToCreatePin,
            onDismiss: {
                // This closure gets executed when the sheet is dismissed
                print(" Sheet dismissed")
                
            }){
                NavigationView() {
                    Step1CreatePinScreen()
                }
            }
            .sheet(
                isPresented: $sheetNavigationViewModel.navigateToPanicPin,
                onDismiss: {
                    // This closure gets executed when the sheet is dismissed
                    print("Sheet dismissed")
                    //navigateToAccountLookUp.toggle()
                }){
                    NavigationView() {
                        Step1CreatePanicPinScreen()
                    }
                }
                .sheet(
                    isPresented: $sheetNavigationViewModel.navigateToSecurityQuestions,
                    onDismiss: {
                        // This closure gets executed when the sheet is dismissed
                        print("Sheet dismissed")
                        //navigateToAccountLookUp.toggle()
                    }){
                        NavigationView() {
                            SecurityQuestionScreen()
                        }
                    }
                    .sheet(
                        isPresented: $sheetNavigationViewModel.navigateToMinimumDeposit,
                        onDismiss: {
                            // This closure gets executed when the sheet is dismissed
                            print("Sheet dismissed")
                            //navigateToAccountLookUp.toggle()
                        }){
                            NavigationView() {
                                MinimumDepositScreen()
                            }
                        }
    }
    
    @ViewBuilder
    func ForgotPinBiometricsView()-> some View {
        VStack{
            Button(
                action: {
                    self.navigateToForgotPassword.toggle()
                }, label: {
                    CustomTextSemiBold(
                        text: "Forgot Pin?",
                        textColor: Color(hexString: CustomColors.blue),
                        fontSize: 16,
                        textAlignment: .center
                    ).vSpacingWithMaxWidth(.center)
                }
            )
            
            
            HStack(spacing:0){
                
                Rectangle().fill(Color.black.opacity(0.5))
                    .frame(maxWidth: .infinity)
                    .frame(height: 1)
                //
                CustomTextRegular(
                    text: "Use Biometrics",
                    textColor: Color.black,
                    fontSize: 12,
                    textAlignment: .center
                )
                .padding(.vertical,4)
                .vSpacingWithMaxWidth(.center)
                .onTapGesture {
                    showDialog.toggle()
                }
                
                //
                Rectangle().fill(Color.black.opacity(0.5))
                    .frame(maxWidth: .infinity)
                    .frame(height: 1)
                
            }.vSpacingWithMaxWidth(.center)
            
            HStack(spacing:5){
                
                UseBiometricsView(image: "fingerprint", title: "Fingerprint")
                    .onTapGesture {
                        faceIdAuthentication()
                    }
                //Spacer()
                UseBiometricsView(image: "face_recognition", title: "Face ID")
                    .onTapGesture {
                        self.navigateToTakeSelfie.toggle()
                    }
                
                
                //Spacer()
                UseBiometricsView(image: "voice_logo", title: "Voice ID")
                    .onTapGesture {
                        //self.showDialogVoiceActication.toggle()
                        
                        CustomAlertDailogWithCancelAndConfirm(
                            title: "Activate your biometrics",
                            message: "You don’t have any biometrics activated yet on Your account. Activate biometrics for easier Login and authorisation",
                            secondaryTitle: "Cancel",
                            primaryText: "Activate",
                            secondaryAction: {
                                
                            },
                            primaryAction: {
                                CustomAlertDailogWithCancelAndConfirm(
                                    title: "Use Voice ID",
                                    message: "Repeat the following words to capture your voice to Login.\n“My voice is my password”",
                                    secondaryTitle: "Cancel",
                                    primaryText: "Speak",
                                    secondaryAction: {
                                        
                                    },
                                    primaryAction: {
                                        
                                        CustomAlertDailogWithCancelAndConfirm(
                                            title: "",
                                            message: "“My voice is my password”",
                                            secondaryTitle: "Cancel",
                                            primaryText: "Stop",
                                            secondaryAction: {
                                                
                                            },
                                            primaryAction: {
                                                sharedViewModel.isLoading = true
                                                sharedViewModel.loadingMessage = "We are processing your voice Please wait…"
                                                DispatchQueue.main.asyncAfter(deadline: .now()+5){
                                                    sharedViewModel.isLoading = false
                                                    CustomAlertDailog(
                                                        title: "Voice recognition successful",
                                                        message: "Your voice has been recognized successfully You can proceed to your account",
                                                        primaryText: "Continue",
                                                        primaryAction: {
                                                            
                                                        }
                                                    )
                                                }
                                                
                                            }
                                        )
                                        
                                    }
                                )
                            }
                        )
                    }
            }//.padding()
        }
    }
    
    @ViewBuilder
    func UseBiometricsView(image:String,title:String) -> some View {
        HStack(spacing: 5){
            //Spacer()
            Image(image)
                .resizable()
                .frame(width: 24,height: 24)
                .scaledToFit()
            
            CustomTextRegular(
                text: title,
                textColor: Color.blue,
                fontSize: 12,
                textAlignment: .center
            )
            .vSpacingWithMaxWidth(.center)
        }
        .padding(.horizontal)
        .padding(.vertical,5)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .stroke(.gray.opacity(0.4), lineWidth: 1)
        )
        //        .overlay(
        //            RoundedRectangle(cornerRadius: 5)
        //                .stroke(Color.gray, lineWidth: 1)
        //        )
    }
    
}


extension LoginScreen{
    
    func faceIdAuthentication(){
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            let reason = "Authenticate to access the app"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason){ success, authenticationError in
                if success{
                    print("successed")
                    self.navigateToHome.toggle()
                }else{
                    print("failed")
                }
            }
        }else{
            CustomAlertDailog(
                title: "Info",
                message: "Biometric authentication unavailable",
                primaryText: "Okay",
                primaryAction: {
                    
                }
            )
            // Device does not support Face ID or Touch ID
            print("Biometric authentication unavailable")
        }
    }
    
    private func submitAction(){
        //        sharedViewModel.isLoading = true
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
        //            sharedViewModel.isLoading = false
        //self.navigateToHome.toggle()
        preparePerformLogin()
        //}
    }
    
    
    
    private func preparePerformLogin(){
        saveUserData(key: USERDEFAULTS.OLD_CODE, data: pinCode)
        //
        var payload = LoginRequest()
        payload.deviceID = AppUtils().getDeviceID()
        payload.pin = pinCode
        payload.username = getUserData(key: USERDEFAULTS.USER_PHONENUMBER)
        
        self.performLogin(model: payload)
    }
    
    //MARK: - AccountLookUp
    private  func performLogin(model: LoginRequest){
        AppUtils.Timber(with: "signin \(model)")
        sharedViewModel.isLoading = true
        RequestManager.ApiInstance.loginRequest(requestBody: model) {status, message,response in
            
            DispatchQueue.main.async{
                sharedViewModel.isLoading = false
                if status {
                    handleSuccessful(response: response)
                    
                }else{
                    alertDialog(message: "\(message ?? "")")
                    //self.navigateToHome.toggle()
                }
            }
            //
        }
    }
    //
    private func alertDialog(message:String?){
        CustomAlertDailog(title: "Info", message: message ?? "Response could not be processed", primaryText: "Ok", primaryAction: {
            
        })
    }
    
    private func handleSuccessful(response:LoginResponse?){
        if response?.status == "00"{
            if response?.data.changePin == true{
                //alertDialog(message: "PROCEED TO CHANGE PIN")
                sheetNavigationViewModel.navigateToCreatePin.toggle()
            }else if response?.data.panic == true{
                //alertDialog(message: "PROCEED TO PANIC")
                sheetNavigationViewModel.navigateToPanicPin.toggle()
            }else if response?.data.setSECQns == true{
                //alertDialog(message: "PROCEED TO SET SECURITY QUESTIONS")
                sheetNavigationViewModel.navigateToSecurityQuestions.toggle()
            }else{
                self.navigateToHome.toggle()
            }
        }else{
            sharedViewModel.showAlert(title: "Failed", message: response?.message ?? "Failed to login")
        }
    }
    
}
