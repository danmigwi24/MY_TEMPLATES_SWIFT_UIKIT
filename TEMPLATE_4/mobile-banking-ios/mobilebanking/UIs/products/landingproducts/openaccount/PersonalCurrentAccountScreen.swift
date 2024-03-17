//
//  PersonalCurrentAccountScreen.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 16/02/2024.
//

import Foundation
import SwiftUI
import MBCore

import CoreLocation


struct PersonalCurrentAccountScreen_Previews: PreviewProvider {
    static var previews: some View {
        PersonalCurrentAccountScreen()
    }
}


struct PersonalCurrentAccountScreen: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var navigateTo:Bool = false
    //
    @State private var showDialog:Bool = false
    //
    @State private var isTermsChecked:Bool = false
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
extension PersonalCurrentAccountScreen {
    
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
        .navigationBarTitle("Personal Current Account",displayMode: .inline)
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label:{
                    HStack{
                        Image(systemName: "chevron.backward")
                        //                            .resizable()
                        //                            .frame(width: 18,height: 15)
                        //                            .scaledToFit()
                            .foregroundColor(.black)
                        ///*
                        
                        Text("Back")
                            .foregroundColor(Color.blue)
                        //*/
                    }
                })
        )
        .navigationBarItems(
            trailing:
                HStack{
                    /*
                     Button(action: {
                     // Action to perform when the "Next" button is tapped
                     //submitAction()
                     presentationMode.wrappedValue.dismiss()
                     }, label: {
                     Text("Next")
                     .foregroundColor(Color.blue)
                     })
                     */
                    
                }
        )
        
    }
    
    
}

/**
 *VIEW EXTEXTIONS*
 */
extension PersonalCurrentAccountScreen {
    
    //MARK: SET UP UI
    @ViewBuilder
    func SetUpUI(geometry:GeometryProxy) -> some View {
        ZStack(){
            NavigationLink("", destination: Step1AccountOpeningScreen(), isActive: $navigateTo).opacity(0)
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
       // ScrollView(.vertical,showsIndicators: false) {
            VStack(){
                
                CustomTextBold(text: "Perfect! Let’s get started with your account Opening process", textColor: Color(hexString: CustomColors.black), fontSize: 16, textAlignment: .leading).vSpacingWithMaxWidth(.leading)
                //
                CustomTextSemiBold(text: "Here are some of the requirements you will need to open An account with us", textColor: Color(hexString: CustomColors.darkBlue), fontSize: 14, textAlignment: .leading).vSpacingWithMaxWidth(.leading)
                
                PersonalCurrentAccountSection(geometry: geometry)
                Spacer()
                TermsSection()
                CustomButtonFilled(
                    action: {
                        navigateTo.toggle()
                    },
                    title: "LET’S START",
                    bgColor: Color(hexString:CustomColors.lightBlue),
                    textColor: Color.white
                )
            }.frame(maxHeight: .infinity)
        //}
        .padding(10)
        
    }
    
    @ViewBuilder
    func PersonalCurrentAccountSection(geometry:GeometryProxy) -> some View {
        VStack(spacing:0){
            ScrollView(.vertical,showsIndicators: false) {
                LazyVStack(spacing: 0) {
                    ForEach(listOfPersonalCurrentAccountModel,id: \.self) { item in
                        PersonalCurrentAccountItem(geometry: geometry,item:item).padding(5)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func PersonalCurrentAccountItem(geometry:GeometryProxy,item:PersonalCurrentAccountModel) -> some View {
        HStack{
            RoundedRectangle(cornerRadius: 10).fill(Color(hexString: item.color)).frame(width: 3)
            VStack(spacing: 0){
                //
                CustomTextBold(text: item.title, textColor: Color(hexString: CustomColors.darkBlue), fontSize: 16, textAlignment: .leading).vSpacingWithMaxWidth(.leading)
                
                CustomTextRegular(text: item.description, textColor: Color(hexString: CustomColors.gray), fontSize: 12, textAlignment: .leading).vSpacingWithMaxWidth(.leading)
                //r
            }.padding(10)
            
            Image(systemName: "checkmark.circle")
                .foregroundColor(Color(hexString: CustomColors.green))

        }
        .cornerRadius(10)
        .frame(maxWidth: geometry.size.width * 0.9)
    }
    
    //MARK: PrivacyPolicy SECTION
    @ViewBuilder
    func TermsSection() -> some View {
        VStack{
            HStack{
                Toggle(
                    isOn: $isTermsChecked,
                    label: {
                        Text("Check")
                            .fontWeight(.regular)
                    }
                )
                .toggleStyle(ToggleCheckboxStyles(isChecked: $isTermsChecked))
                .font(.title)
                
                HStack{
                    VStack {
                        Text("I agree to the")
                            .foregroundColor(Color(hexString: CustomColors.black))
                        + Text(" Terms and Conditions")
                            .foregroundColor(Color(hexString: CustomColors.darkBlue))
                            .underline()
                        + Text(".")
                            .foregroundColor(Color.black)
                    }
                    
                    .font(.custom(CustomFontNames.NunitoSans_Regular, size: 14).weight(.regular))
                    
                }.hSpacing(.leading).padding(.vertical,10)
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            
        }
    }
    
    
}





