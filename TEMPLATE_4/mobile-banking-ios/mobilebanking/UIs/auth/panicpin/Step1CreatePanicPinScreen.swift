//
//  Step1CreatePanicPinScreen.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 19/02/2024.
//

import Foundation
import SwiftUI
import MBCore
import CoreLocation
import CustomHalfSheet
import SwiftUI
import SwiftUIDigitalSignature
import Localize_Swift

struct Step1CreatePanicPinScreen_Previews: PreviewProvider {
    static var previews: some View {
        Step1CreatePanicPinScreen()
    }
}


struct Step1CreatePanicPinScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var navigateToContinue:Bool = false
    @State private var navigateToNotNow:Bool = false
    //
    @State private var showDialog:Bool = false
    @State private var isShowingHalfASheet = false
    //
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
extension Step1CreatePanicPinScreen {
    
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
        .navigationBarItems(
            leading: Button(action: {
                //backAction()
            }, label: {
                VStack{
                    //ADD your Header
                }
            })
        )
        .navigationBarTitle("Step1CreatePanicPinScreen.header".localized(),displayMode: .inline)
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(true)
    }
    
    
}
/**
 *VIEW EXTEXTIONS*
 */
extension Step1CreatePanicPinScreen {
    
    //MARK: SET UP UI
    @ViewBuilder
    func SetUpUI(geometry:GeometryProxy) -> some View {
        ZStack(){
            NavigationLink("", destination: Step2CreatePanicPinScreen(), isActive: $navigateToContinue).opacity(0)
            NavigationLink("", destination: MinimumDepositScreen(), isActive: $navigateToNotNow).opacity(0)
            VStack(){
                //
                ContentView(geometry:geometry)
                //.background(Color.red)
                    .padding(.horizontal,8)
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
            
            //MARK: HalfASheet
            HalfASheet(isPresented: $isShowingHalfASheet, title: "") {
                VStack(spacing: 0) {
                   
                }
                .padding(5)
            }
            // Customise by editing these.
            .height(.proportional(0.70))
            //.closeButtonColor(UIColor.white)
            //.backgroundColor(.white)
            .contentInsets(EdgeInsets(top: 10, leading: 10, bottom: 20, trailing: 10))
            
        }
    }
    
    @ViewBuilder
    func ContentView(geometry:GeometryProxy) -> some View {
        //ScrollView(.vertical,showsIndicators: false) {
        ZStack(alignment: .topLeading){
            VStack(){
                CustomTextBold(
                    text: "Step1CreatePanicPinScreen.title".localized(),
                    textColor: Color.black,
                    fontSize: 20,
                    textAlignment: .leading).vSpacingWithMaxWidth(.leading)

                CustomTextRegular(
                    text: "Step1CreatePanicPinScreen.description".localized(),
                    textColor: Color.black.opacity(0.5),
                    fontSize: 14,
                    textAlignment: .leading).vSpacingWithMaxWidth(.leading)

                //
                LottieView(name: LottieFiles.CREATE_PANIC_PIN)
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: geometry.size.height * 0.25,
                           maxHeight: geometry.size.height * 0.40)
                    .padding(.horizontal,10)
                //
                VStack(spacing: 10) {
                    
                    //fingerprint
                    HStack{
                        Image(systemName:"checkmark.circle" )
                            .resizable()
                            .frame(width: 26, height: 26)
                            .clipShape(Circle())
                            .foregroundColor(Color(hexString: CustomColors.green))
                        
                        CustomTextRegular(
                            text: "Step1CreatePanicPinScreen.text1".localized(),
                            textColor: Color(hexString: CustomColors.darkBlue),
                            fontSize: 14,
                            textAlignment: .leading).vSpacingWithMaxWidth(.leading)
                    }
                    
                    //Voice recognition
                    HStack{
                        Image(systemName:"checkmark.circle" )
                            .resizable()
                            .frame(width: 26, height: 26)
                            .clipShape(Circle())
                            .foregroundColor(Color(hexString: CustomColors.green))
                        
                        CustomTextRegular(
                            text: "Step1CreatePanicPinScreen.text2".localized(),
                            textColor: Color(hexString: CustomColors.darkBlue),
                            fontSize: 14,
                            textAlignment: .leading).vSpacingWithMaxWidth(.leading)
                    }
                    
                    //Face ID
                    HStack{
                        Image(systemName:"checkmark.circle" )
                            .resizable()
                            .frame(width: 26, height: 26)
                            .clipShape(Circle())
                            .foregroundColor(Color(hexString: CustomColors.green))
                        
                        CustomTextRegular(
                            text: "Step1CreatePanicPinScreen.text3".localized(),
                            textColor: Color(hexString: CustomColors.darkBlue),
                            fontSize: 14,
                            textAlignment: .leading).vSpacingWithMaxWidth(.leading)
                    }
                }
                //
                Spacer(minLength: geometry.size.height * 0.1)
                ButtonSection()
                
            }
        }
    }
    
    //
    @ViewBuilder
    func ButtonSection() -> some View {
        
        VStack{
            CustomButtonFilled(
                action: {
                    self.navigateToContinue.toggle()
                },
                title: "Step1CreatePanicPinScreen.setpanicpinbutton".localized(),
                bgColor: Color(hexString:CustomColors.lightBlue),
                textColor: Color.white
            )
            
            CustomButtonStroke(
                action: {
                    self.navigateToNotNow.toggle()
                },
                title: "GLOBAL.NOTNOW".localized(),
                bgColor: Color.clear,
                textColor: Color(hexString:CustomColors.blue),
                strokeColor: Color(hexString:CustomColors.blue),
                strokeWidth: 1
            )
        }
    }
    
}





