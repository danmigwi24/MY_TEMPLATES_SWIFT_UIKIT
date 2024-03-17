//
//  ForgetPinSecurityQuestionsScreen.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 16/02/2024.
//


import Foundation
import SwiftUI
import MBCore

import CoreLocation


struct ForgetPinSecurityQuestionsScreen_Previews: PreviewProvider {
    static var previews: some View {
        ForgetPinSecurityQuestionsScreen()
    }
}


struct ForgetPinSecurityQuestionsScreen: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var navigateTo:Bool = false
    //
    @State private var answerToQuestion:String = ""
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
extension ForgetPinSecurityQuestionsScreen {
    
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
        .navigationBarTitle("Security Questions",displayMode: .inline)
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
extension ForgetPinSecurityQuestionsScreen {
    
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
        //ScrollView(.vertical,showsIndicators: false) {
            VStack(spacing:0){
                
                CustomTextBold(text: "Give answers to the following questions", textColor: Color(hexString: CustomColors.black), fontSize: 16, textAlignment: .leading).vSpacingWithMaxWidth(.leading)
                //
                CustomTextSemiBold(text: "Answer the following questions with the answers you gave during registration", textColor: Color(hexString: CustomColors.darkBlue), fontSize: 14, textAlignment: .leading).vSpacingWithMaxWidth(.leading)
                
                ItemSection(geometry: geometry, title: "", action: {})
            //}
        }.padding(10)
    }
    
    @ViewBuilder
    func ItemSection(geometry:GeometryProxy,title:String,action: @escaping()->()) -> some View {
        VStack{
            CustomTextFieldView(text: $answerToQuestion, hint: "Give your answers here", labelText: "Q1. What’s your pet name?", leadingIcon: Image(""))
            Spacer()
            //ButtonSection()
        }
        .padding(.vertical,15)
        .vSpacingWithMaxWidth(.leading)
    }
    
    @ViewBuilder
    func ButtonSection()->some View {
        VStack{
            CustomButtonFilled(
                action: {
                    
                },
                title: "CONTINUE",
                bgColor: Color(hexString: CustomColors.blue),
                textColor: Color(hexString: CustomColors.white)
            )
        }
    }
    
}




