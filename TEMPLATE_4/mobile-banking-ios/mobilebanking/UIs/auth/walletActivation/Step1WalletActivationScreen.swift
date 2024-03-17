//
//  Step1WalletActivationScreen.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 08/03/2024.
//

import Foundation
import SwiftUI
import MBCore



struct Step1WalletActivationScreen_Previews: PreviewProvider {
    static var previews: some View {
        Step1WalletActivationScreen()
    }
}


struct Step1WalletActivationScreen: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.dismiss) private var dismiss
    //
    @State private var navigateTo:Bool = false
    //
    @State private var showDialog:Bool = false
    //MARK: NEEDED FOR API
    @StateObject var sharedViewModel = SharedViewModel()
    @StateObject private var sheetNavigationViewModel = SheetNavigationViewModel()
    //
    var body: some View {
        MainContent()
    }
    
    
}

/**
 *VIEW EXTEXTIONS*
 */
extension Step1WalletActivationScreen {
    
    //MARK: SET UP UI
    @ViewBuilder
    func MainContent() -> some View {
        //ScrollView(.vertical,showsIndicators: false) {
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
        //}
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
        .navigationBarTitle("Identification",displayMode: .inline)
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                /*
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    HStack{
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.black)
                        Text("Back")
                            .foregroundColor(Color.blue)
                    }
                })
                 */
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    //self.navigateTo.toggle()
                    presentationMode.wrappedValue.dismiss()
                    saveUserDataBool(key: USERDEFAULTS.HAS_FINISHED_ACCOUNT_OPENING, data: false)
                }, label: {
                    HStack{
                        Text("Cancel")
                            .foregroundColor(Color.blue)
                    }
                })
                
            }
        }
    }
    
    
    
    
    //MARK: SET UP UI
    @ViewBuilder
    func SetUpUI(geometry:GeometryProxy) -> some View {
        ZStack(){
            NavigationLink("", destination: Step2WalletActivationScreen(), isActive: $navigateTo).opacity(0)
            VStack(spacing: 0){
                //
                ContentView(geometry:geometry)
                    .padding(10)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .frame(minHeight: geometry.size.height * 0.8)
               // Spacer()
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
        VStack(spacing:5){
            //
            //TitleAndDescriptionView(title: "You will have to capture your National ID or Passport", description: "By proceeding you will scan your ID or passport, try fitting It on to the frame within the camera to capture all details")
            //
            AccountOpeningTitlesView(title:"Please Provide your National ID card Details", description: "Enter your National ID details below then proceed to capture Photos of your ID both front and back").onTapGesture {
                alertDialog(message: "Test")
            }
            //
            Button(action: {
                self.navigateTo.toggle()
            }, label: {
                CustomTextMedium(text: "Enter your details manualy !", textColor: Color(hexString: CustomColors.darkBlue), fontSize: 14, textAlignment: .trailing).vSpacingWithMaxWidth(.trailing)
            })
            
            LottieView(name: LottieFiles.Identification)
                .frame(maxWidth: .infinity)
                .frame(height: 350)
                .padding(.horizontal,20)
            
            Spacer()
            ButtonSection().frame(alignment: .bottom)
            
        }
        
    }
    
    //
    @ViewBuilder
    func ButtonSection() -> some View {
        VStack{
            CustomButtonFilled(
                action: {
                    print("SCAN NATIONAL ID")
                },
                title: "SCAN NATIONAL ID",
                bgColor: Color(hexString:CustomColors.lightBlue),
                textColor: Color.white
            )
            
            CustomButtonStroke(
                action: {
                    
                },
                title: "SCAN PASSPORT",
                bgColor: Color.white,
                textColor: Color(hexString:CustomColors.lightBlue),
                strokeColor: Color(hexString:CustomColors.lightBlue),
                strokeWidth: 1
            )
        }
    }
    
    
    private func alertDialog(message:String?){
        //CustomAlertDailog(title: "Info", message: message ?? "Response could not be processed", primaryText: "Ok", primaryAction: {})
        showCustomizedSwiftMessages(title: "Error", body:"Middle name required",isError: false,dismissAfter: 10)
        //sharedViewModel.showAlert(message: message ?? "Response could not be processed")
        //alertView()
    }
    
 
    
}


