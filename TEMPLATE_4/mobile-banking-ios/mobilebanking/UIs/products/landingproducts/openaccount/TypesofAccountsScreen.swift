//
//  AccountTypeScreen.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 08/02/2024.
//

import Foundation
import SwiftUI
import MBCore



struct AccountTypeScreen_Previews: PreviewProvider {
    static var previews: some View {
        TypesofAccountsScreen()
    }
}


struct TypesofAccountsScreen: View {
    //
    @State private var navigateToOpenAccount:Bool = false
    @State private var navigateToDeviceVerification:Bool = false
    //
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
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
extension TypesofAccountsScreen {
    
    //MARK: SET UP UI
    @ViewBuilder
    func MainContent() -> some View {
        VStack{
            GeometryReader { geometry in
                //
                LoadingView(isShowing: self.$sharedViewModel.isLoading) {
                    SetUpUI(geometry:geometry)
                        .frame(width: geometry.size.width,height: geometry.size.height)
                     
                    
                }
                
            }
            
        }
        .onAppear {
            //getFontFamilyNames()
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
        .navigationBarTitle("Types of Accounts",displayMode: .inline)
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
    
    
    //MARK: SET UP UI
    @ViewBuilder
    func SetUpUI(geometry:GeometryProxy) -> some View {
        ZStack(){
            NavigationLink("", destination: OurBankingProductScreen(), isActive: $navigateToOpenAccount)
            VStack(){
               
                
                //
                ContentView(geometry: geometry)
                    .frame(maxWidth: .infinity,alignment: .center)
                    .frame(minHeight: geometry.size.height * 0.8)
                
            }
            
            
        }
    }
    
    //
    @ViewBuilder
    func ContentView(geometry:GeometryProxy) -> some View {
        ScrollView(.vertical,showsIndicators: false) {
            VStack(spacing:0){
                //
                TitleAndDescriptionView(title: "Here are some the accounts that we offer At Eclectics", description: "You can only proceed with one account type at a time Depending on your needs")
                //
                TypeOfAccountView(geometry: geometry)
                    .padding(.vertical,5)
                
            }.padding(.horizontal,10)
                .padding(.bottom,30)
        }
    }
    
    
    @ViewBuilder
    func TypeOfAccountView(geometry:GeometryProxy) -> some View {
        VStack{
            ForEach(listOfTypeOfAccountModel) { item in
                //NavigationLink(destination: OurBankingProductScreen()) {
                TypeOfAccountItem(geometry: geometry, item: item)
                //}
                
            }
        }
    }
    
    
    @ViewBuilder
    func TypeOfAccountItem(geometry:GeometryProxy,item:TypeOfAccountModel) -> some View {
        ZStack{
//            Image(item.image)
//            .resizable()
//            .scaledToFit()
//            .frame(maxWidth: .infinity,maxHeight: geometry.size.height * 0.2)
            
            VStack(alignment: HorizontalAlignment.leading,spacing:0){
                Spacer()
                //
                CustomTextBold(
                    text: "\(item.title)",
                    textColor: .white,
                    fontSize: 20,
                    textAlignment: TextAlignment.leading
                )
                .vSpacingWithMaxWidth(.leading)
                
                //
                CustomTextRegular(
                    text: "\(item.description)",
                    textColor: Color(hexString: CustomColors.white),
                    fontSize: 16,
                    textAlignment: TextAlignment.leading
                )
                .vSpacingWithMaxWidth(.leading)
                
                CustomButtonFilled(
                    action: {
                        self.navigateToOpenAccount.toggle()
                    },
                    title: "LET'S GET STARTED",
                    bgColor: Color(hexString: CustomColors.lightBlue),
                    textColor: .white,
                    paddingVertical: 8
                )
                .padding(.bottom,10)
                
            }
            .padding(10)
            .background(
                Image(item.image)
                .resizable()
                .frame(maxWidth: .infinity,maxHeight: geometry.size.height * 0.35)
                //.scaledToFit()
                .clipped()
                
            )
            .frame(maxWidth: .infinity,maxHeight: geometry.size.height * 0.35)
        }
        
    }
    
}


