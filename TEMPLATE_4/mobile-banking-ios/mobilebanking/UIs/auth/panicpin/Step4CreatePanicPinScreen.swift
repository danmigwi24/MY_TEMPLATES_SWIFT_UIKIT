//
//  Step4CreatePanicPinScreen.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 20/02/2024.
//


import Foundation
import SwiftUI
import MBCore
import LocalAuthentication


struct Step4CreatePanicPinScreen: View {
    //
    @State var pinCode:String = ""
    //
    @State private var navigateToConfirm:Bool = false
    //
    @State private var showDialog:Bool = false
    @State private var showDialogVoiceActication:Bool = false
    @State private var showDialogFingerPrint:Bool = false
    @State private var showDialogFace:Bool = false
    //
    @State private var isUnlockedWithFaceId = false
    
    //MARK: NEEDED FOR API
    @StateObject var sharedViewModel = SharedViewModel()
    //
    var body: some View {
        MainContent()
    }
    
    
}

/**
 *VIEW EXTEXTIONS*
 */
extension Step4CreatePanicPinScreen {
    
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
        .navigationBarBackButtonHidden(false)
        
    }
    
    
    
    //MARK: SET UP UI
    @ViewBuilder
    func SetUpUI(geometry:GeometryProxy) -> some View {
        ZStack{
            
            //
            NavigationLink("", destination: MinimumDepositScreen(), isActive: $navigateToConfirm).opacity(0)
            //
            VStack(spacing:10){
                
                LogoView()
                    
                //
                CustomTextBold(text: "Confirm panic pin", textColor: .black, fontSize: 20, textAlignment: .center).vSpacingWithMaxWidth(.center)
                //
                CustomTextMedium(text: "Create a new 4-digit pin", textColor: Color(hexString: CustomColors.darkBlue), fontSize: 14, textAlignment: .center).vSpacingWithMaxWidth(.center)
                //
                KeyPadView(pinCode: $pinCode).frame(minHeight:  geometry.size.height * 0.4,maxHeight: geometry.size.height * 0.6)//.background(Color.red)
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
        .onChange(of: pinCode) { newValue in
            print("newValue => \(newValue)")
            if newValue.count >= 4{
                sharedViewModel.isLoading = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    sharedViewModel.isLoading = false
                    self.navigateToConfirm.toggle()
                }
            }
        }
    }
}

