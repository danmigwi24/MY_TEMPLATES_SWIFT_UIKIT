//
//  Step1ConfirmCreatePinAccountOpeningScreen.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 20/02/2024.
//

import Foundation

import Foundation
import SwiftUI
import MBCore
import LocalAuthentication


struct Step2ConfirmCreatePinScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.dismiss) private var dismiss
    //
    var createdPin:String
    @State var reenteredPin:String = ""
    //
    @State private var navigateTo:Bool = false
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
extension Step2ConfirmCreatePinScreen {
    
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
                        .frame(width: geometry.size.width,height: geometry.size.height)
                    //
                    
                }
                
            }.frame(maxWidth: .infinity,maxHeight: .infinity)
        }
        .onAppear {
            Logger("CREATED PIN : \(createdPin)")
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
        .navigationBarItems(
            leading:
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label:{
                    HStack{
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.black)
                        Text("Back")
                            .foregroundColor(Color.blue)
                    }
                })
        )
        
    }
    
    
    
    //MARK: SET UP UI
    @ViewBuilder
    func SetUpUI(geometry:GeometryProxy) -> some View {
        ZStack{
            
            //
            NavigationLink("", destination: EnableBiometricScreen(), isActive: $navigateTo)
            //
            VStack(spacing:10){
                
                LogoView()
                //
                CustomTextBold(text: "Confirm pin", textColor: .black, fontSize: 20, textAlignment: .center).vSpacingWithMaxWidth(.center)
                //
                CustomTextMedium(text: "Re-enter your new pin", textColor: Color(hexString: CustomColors.darkBlue), fontSize: 14, textAlignment: .center).vSpacingWithMaxWidth(.center)
                //
                KeyPadView(pinCode: $reenteredPin).frame(minHeight:  geometry.size.height * 0.4,maxHeight: geometry.size.height * 0.6)//.background(Color.red)
                //
                CustomSpacer(height: 20)
                //
                
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
        .onChange(of: reenteredPin) { newValue in
            print("newValue => \(newValue)")
            if newValue.count >= 4{
                if  validateFields(){
                    performCreatePin()
                }
                /*
                 sharedViewModel.isLoading = true
                 DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                 sharedViewModel.isLoading = false
                 self.navigateTo.toggle()
                 }
                 */
            }
        }
    }
    
    
}


extension Step2ConfirmCreatePinScreen{
    
    //MARK: Validate Fields
    func validateFields() -> Bool {
        //
        guard reenteredPin == createdPin else {
            showCustomizedSwiftMessages(title: "Error", body:"Pin mismatch required")
            return false
        }
        //
        return true
    }
    //MARK: - RESEND
    private  func performCreatePin(){
        var payload = CreateNewPinRequest()
        payload.oldPin = getUserData(key: USERDEFAULTS.OLD_CODE)
        payload.newPin = reenteredPin
        
        AppUtils.Timber(with: "accountWalletActivation \(payload)")
        //
        sharedViewModel.isLoading = true
        RequestManager.ApiInstance.createNewPin(requestBody: payload) {status, message,responseModel in
            
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
                        print("SUCCESS")
                        sheetNavigationViewModel.navigateToCreatePin = false
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
    
    
}
