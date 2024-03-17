//
//  WelcomeAccountSelectionScreen.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 07/02/2024.
//

import Foundation
import SwiftUI
import MBCore
import Combine
import Localize_Swift



struct WelcomeAccountSelectionScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeAccountSelectionScreen()
    }
}


struct WelcomeAccountSelectionScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    //
    @State private var navigateToTest:Bool = false
    @State private var navigateToAccountLookUp:Bool = false
    
    //MARK: NEEDED FOR API
    @StateObject var sharedViewModel = SharedViewModel()
    //@StateObject private var sheetNavigationViewModel = SheetNavigationViewModel()
    @EnvironmentObject var sheetNavigationViewModel: SheetNavigationViewModel
    //
    var body: some View {
        MainContent()
    }
    
    
}

/**
 *VIEW EXTEXTIONS*
 */
extension WelcomeAccountSelectionScreen {
    
    //MARK: SET UP UI
    @ViewBuilder
    func MainContent() -> some View {
        ZStack{
            Color(hexString: CustomColors.white).edgesIgnoringSafeArea(.all)
            VStack{
                GeometryReader { geometry in
                    //
                    LoadingView(isShowing: self.$sharedViewModel.isLoading) {
                        SetUpUI(geometry:geometry)
                        
                            .frame(width: geometry.size.width,height:geometry.size.height)
                        
                        //
                    }
                    
                }
                
            }
        }
        .onAppear {
            Logger("onAppear [WelcomeAccountSelectionScreen]")
            getCurrentLanguage()
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
        .preferredColorScheme(.dark)
        .navigationBarTitle("",displayMode: .inline)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
    }
    
    
    
    //MARK: SET UP UI
    @ViewBuilder
    func SetUpUI(geometry:GeometryProxy) -> some View {
        ZStack{
            NavigationLink("", destination: DeviceVerificationScreen(whatIsVerified: 1), isActive: $navigateToTest).opacity(0)
            NavigationLink("", destination: AccountLookUpScreen(), isActive: $navigateToAccountLookUp).opacity(0)
            VStack{
                
                HStack{
                    VStack{
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label:{
                            HStack{
                                Image(systemName: "chevron.backward")
                                    .foregroundColor(.white)
                                Text("Back")
                                    .foregroundColor(Color.white)
                                
                            }
                        })
                        //
                        Image("mb_logo_e")
                            .aspectRatio(contentMode: .fill)
                            .onTapGesture {
                                self.navigateToTest.toggle()
                            }
                    }
                    Spacer()
                }.frame(maxWidth: .infinity)
                
                CustomTextBold(
                    text: "WelcomeAccountSelectionScreen.title".localized(),
                    textColor: Color.white,
                    fontSize:20,
                    textAlignment: TextAlignment.leading
                ).vSpacingWithMaxWidth(.leading)
                
                CustomTextMedium(
                    text: "WelcomeAccountSelectionScreen.description".localized(),
                    textColor: Color.white,
                    fontSize:16,
                    textAlignment: TextAlignment.leading
                ).vSpacingWithMaxWidth(.leading)
                
                //Spacer()
                LottieView(name: LottieFiles.WELCOME_BANK)
                    .frame(minHeight: geometry.size.height * 0.35 , maxHeight: geometry.size.height * 0.5,alignment: .topLeading)
                //.frame(height: 350,alignment: .topLeading)
                Spacer()
                
                ButtonSection()
                Spacer()
            }
            .padding(10)
            //.frame(maxWidth: .infinity,maxHeight: .infinity)
            
        }.background(
            Image("welcome_bg")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity,maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
        )
    }
    
    
    func ButtonSection()->some View {
        VStack{
            CustomButtonFilled(
                action: {
                    self.navigateToAccountLookUp.toggle()
                },
                title: "WelcomeAccountSelectionScreen.have_account".localized(),
                bgColor: Color.white,
                textColor: Color(hexString: CustomColors.darkBlue)
            )
            
            CustomButtonFilled(
                action: {
                    //self.navigateToAccountOpenning.toggle()
                    sheetNavigationViewModel.showAccountOpeningSheet = true
                },
                title: "WelcomeAccountSelectionScreen.new_account".localized(),
                bgColor: Color.clear,
                textColor: Color.white
            )
            
        }
        .sheet(
            isPresented: $sheetNavigationViewModel.showAccountOpeningSheet,
            onDismiss: {
                // This closure gets executed when the sheet is dismissed
                print("Acoount Opening Sheet dismissed")
                if getUserDataBool(key: USERDEFAULTS.HAS_FINISHED_ACCOUNT_OPENING){
                    sheetNavigationViewModel.showAccountLoginSheet.toggle()
                }else{
                    print("Acoount Opening Sheet dismissed with cancel")
                }
            }){
                NavigationView() {
                    Step1WalletActivationScreen()
                }
            }
            .sheet(
                isPresented: $sheetNavigationViewModel.showAccountLoginSheet,
                onDismiss: {
                    // This closure gets executed when the sheet is dismissed
                    print("Acoount Login Sheet dismissed")
                    //navigateToAccountLookUp.toggle()
                }){
                    NavigationView() {
                        LoginScreen()
                    }
                }
    }
    
}
