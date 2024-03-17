//
//  VerifyYourIdentityScreen.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 16/02/2024.
//


import Foundation
import SwiftUI
import MBCore

import CoreLocation


struct VerifyYourIdentityScreen_Previews: PreviewProvider {
    static var previews: some View {
        VerifyYourIdentityScreen()
    }
}


struct VerifyYourIdentityScreen: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var navigateTo:Bool = false
    //
    @State private var listOfIdentificationOption:[String] = ["National ID","Passport"]
    @State private var selectedIdentificationOption:String = "National ID"
    @State private var identificationOption:String = ""
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
extension VerifyYourIdentityScreen {
    
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
        .navigationBarTitle("Identification",displayMode: .inline)
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(false)
        
        
    }
    
}
/**
 *VIEW EXTEXTIONS*
 */
extension VerifyYourIdentityScreen {
    
    //MARK: SET UP UI
    @ViewBuilder
    func SetUpUI(geometry:GeometryProxy) -> some View {
        ZStack(){
            NavigationLink("", destination: Text(""), isActive: $navigateTo).opacity(0)
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
            VStack(spacing:0){
                
                CustomTextBold(text: "Provide your ID/Passport number", textColor: Color(hexString: CustomColors.black), fontSize: 16, textAlignment: .leading).vSpacingWithMaxWidth(.leading)
                //
                CustomTextSemiBold(text: "Kindly use the national ID/Passport that you used during your Registration", textColor: Color(hexString: CustomColors.darkBlue), fontSize: 14, textAlignment: .leading).vSpacingWithMaxWidth(.leading)
              
                InputField()
        }.padding(10)
    }
    
    //
    @ViewBuilder
    func InputField() -> some View {
        VStack{
            CustomDropDownWithMenuView(label: "ID Type", placeHolder: "") {
                Menu(content: {
                    VStack{
                        ForEach(listOfIdentificationOption, id: \.self) { item in
                            Button(action: {
                                selectedIdentificationOption = item
                            }, label: {
                                Text(item)
                            })
                            
                        }
                    }
                }, label: {
                    HStack{
                        CustomTextBold(text: selectedIdentificationOption, textColor: .black, fontSize: 14, textAlignment: .leading)
                        Spacer()
                        Image(systemName: "arrowtriangle.down.fill")
                            .frame(width: 18,height: 15)
                            .scaledToFit()
                            .foregroundColor(.black)
                    }
                })
            }
            
            //
            FloatingTextFieldView(text: $identificationOption,label: selectedIdentificationOption, placeHolder: "Eg. 12345678",action: {
                
            })
            
            Spacer()
            CustomButtonFilled(
                action: {},
                title: "CONTINUE",
                bgColor: Color(hexString: CustomColors.blue),
                textColor: Color(hexString: CustomColors.white)
            )
        }.padding(.vertical,10)
        
    }
    
    
}




