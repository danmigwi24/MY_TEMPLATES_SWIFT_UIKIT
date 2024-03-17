//
//  ForgotPasswordScreen.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 08/02/2024.
//
import Foundation
import SwiftUI
import MBCore

import CoreLocation


struct ForgotPasswordScreen_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordScreen()
    }
}


struct ForgotPasswordScreen: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var navigateTo:Bool = false
    //
    @State private var showDialog:Bool = false
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
extension ForgotPasswordScreen {
    
    //MARK: SET UP UI
    @ViewBuilder
    func MainContent() -> some View {
        VStack(spacing: 0){
            GeometryReader { geometry in
                //
                LoadingView(isShowing: self.$sharedViewModel.isLoading) {
                    SetUpUI(geometry:geometry)
                        .frame(width: geometry.size.width,height: geometry.size.height)
                     
                    
                    //
                }
                
            }
            
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
        .navigationBarTitle("Forgot Pin",displayMode: .inline)
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(false)
        .navigationBarItems(
            leading:
                HStack{
                    /*
                    Button(action: {
                        // Action to perform when the "Next" button is tapped
                      //submitAction()
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Back")
                            .foregroundColor(Color.blue)
                    })
                    */
                },
            trailing:
                HStack{
                    Button(action: {
                        // Action to perform when the "Next" button is tapped
                      //submitAction()
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Next")
                            .foregroundColor(Color.blue)
                    })
                }
        )
        
    }
    
}
/**
 *VIEW EXTEXTIONS*
 */
extension ForgotPasswordScreen {
    
    //MARK: SET UP UI
    @ViewBuilder
    func SetUpUI(geometry:GeometryProxy) -> some View {
        ZStack(){
            NavigationLink("", destination: DeviceVerificationScreen(whatIsVerified: 3), isActive: $navigateTo).opacity(0)
            VStack(){
                //
                ContentView(geometry:geometry)
                //.background(Color.red)
                    .frame(maxWidth: .infinity,alignment: .center)
                    .frame(minHeight: geometry.size.height * 0.8)
                
                
            } 
            
            /*
             *DIALOG VISIBILITY
             */
            if showDialog{
                CustomSwiftUIDialog(showDialog: $showDialog) {
                    SampleDailog(showDialog: $showDialog){
                        
                    }
                }
            }
            
        }
    }
    
    
    @ViewBuilder
    func ContentView(geometry:GeometryProxy) -> some View {
        ScrollView(.vertical,showsIndicators: false) {
            VStack(spacing:0){
                
                CustomTextBold(text: "You can now reset or change your mobile banking pin", textColor: Color(hexString: CustomColors.black), fontSize: 16, textAlignment: .leading).vSpacingWithMaxWidth(.leading)
                //
                CustomTextSemiBold(text: "If you forgot your pin select one of the methods to use to Reset your mobile banking pin", textColor: Color(hexString: CustomColors.darkBlue), fontSize: 14, textAlignment: .leading).vSpacingWithMaxWidth(.leading)
                VStack{
                    
                    NavigationLink(destination: ForgetPinSecurityQuestionsScreen(), label: {
                        ItemSection(geometry: geometry,title: "Use Security questions",action: {})
                    })
                    Divider()
                    NavigationLink(destination: VerifyYourIdentityScreen(), label: {
                        ItemSection(geometry: geometry,title: "Verify your identity",action: {})
                    })
                    Divider()
                    NavigationLink(destination: LocateUsScreen(), label: {
                        ItemSection(geometry: geometry,title: "Visit branch",action: {})
                    })
                }
            }
        }.padding(10)
    }
    
    @ViewBuilder
    func ItemSection(geometry:GeometryProxy,title:String,action: @escaping()->()) -> some View {
        HStack{
            CustomTextSemiBold(text: title, textColor: Color(hexString: CustomColors.darkBlue), fontSize: 14, textAlignment: .leading).vSpacingWithMaxWidth(.leading)
            Spacer()
            Image(systemName: "chevron.forward")
            //.resizable()
                .frame(width: 18,height: 15)
                .scaledToFit()
                .foregroundColor(.black)
        }
        .padding(.vertical,15)
        .vSpacingWithMaxWidth(.leading)
    }
    
    
}



