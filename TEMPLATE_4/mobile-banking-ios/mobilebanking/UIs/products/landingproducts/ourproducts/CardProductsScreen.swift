//
//  CardProductsScreen.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 21/02/2024.
//

import Foundation
import SwiftUI
import MBCore
import CoreLocation


struct CardProductsScreen: View {
    
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
extension CardProductsScreen {
    
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
        .navigationBarTitle("Card Products",displayMode: .inline)
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
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
            }
        }
        .toolbar {
            /*
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                        self.navigateToContinue.toggle()
                    
                }, label: {
                    Text("Next")
                        .foregroundColor(Color.blue)
                })
            }
             */
        }
        
    }
    
}

/**
 *VIEW EXTEXTIONS*
 */
extension CardProductsScreen {
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
                    .frame(minHeight: geometry.size.height * 0.85)
                
                
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
                
                CustomTextBold(text: "Here are some of the card products that We offer at Eclectics", textColor: Color(hexString: CustomColors.black), fontSize: 16, textAlignment: .leading).vSpacingWithMaxWidth(.leading)
                //
                CustomTextSemiBold(text: "You can only apply for one product at a time, select and Apply for a card that you are eligible for", textColor: Color(hexString: CustomColors.darkBlue), fontSize: 14, textAlignment: .leading).vSpacingWithMaxWidth(.leading)
                //
                RecommendedCardProductsSection(geometry: geometry)
            }
        }.padding(10)
    }
    
    
    @ViewBuilder
    func RecommendedCardProductsSection(geometry:GeometryProxy) -> some View {
        
        VStack(spacing:5){
            HStack{
                //
                CustomTextSemiBold(text: "Recommended card products", textColor: Color(hexString: CustomColors.darkBlue), fontSize: 14, textAlignment: .leading).vSpacingWithMaxWidth(.leading)
            }
            
            ScrollView(.horizontal,showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    ForEach(0..<4) { index in
                        RecommendedCardProductsItem(geometry: geometry).padding(.horizontal,4)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func RecommendedCardProductsItem(geometry:GeometryProxy) -> some View {
        VStack{
            Image("OurCardProducts1")
                .resizable()
            //.frame(maxWidth: .infinity)
                .frame(maxWidth: geometry.size.width * 0.82 )
                .frame(height: geometry.size.height * 0.25, alignment: .topLeading)
                .aspectRatio(contentMode: .fill)
            
            VStack(spacing: 0){
                //
                CustomTextBold(text: "Credit card", textColor: Color(hexString: CustomColors.darkBlue), fontSize: 14, textAlignment: .leading).vSpacingWithMaxWidth(.leading)
                
                let data  = """
                
                Earn Credit Card reward points each time you use your Standard Chartered VISA Gold Credit Card for shopping, entertainment, travel and much more. Register and log in at 360° Rewards. In case of loss or theft of your Gold Credit Card you can be at ease knowing you are covered against any misuse or abuse of your card for the first 24 hours.
                
                """
                
                CustomTextRegular(text: data, textColor: Color(hexString: CustomColors.black), fontSize: 12, textAlignment: .leading).vSpacingWithMaxWidth(.leading)
                //
                
                Spacer()
                //
                OurProductButtonSectionView(titleOne: "APPLY FOR THIS PRODUCT", titleTwo:"LEARN MORE", actionTop: {}, actionButtom: {})
                
            }.padding(10)
                .frame(minHeight: geometry.size.height * 0.45, alignment: .topLeading)
            
        }
        
        .background(Color(hexString: CustomColors.lightGray))
        .cornerRadius(10)
        .frame(maxWidth: geometry.size.width * 0.82 )//,maxHeight: geometry.size.height * 0.4)
    }
    
    
}

