//
//  OurProductScreen.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 08/02/2024.
//

import Foundation
import SwiftUI
import MBCore



struct OurProductScreen_Previews: PreviewProvider {
    static var previews: some View {
        GetStartedLandingPageScreen()
    }
}


struct OurProductScreen: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var navigateToOurProduct:Bool = false
    //
    @State private var showDialog:Bool = false
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
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
extension OurProductScreen {
    
    //MARK: SET UP UI
    @ViewBuilder
    func MainContent() -> some View {
        VStack{
            GeometryReader { geometry in
                //
                //
                LoadingView(isShowing: self.$sharedViewModel.isLoading) {
                    SetUpUI(geometry:geometry)
                        .frame(width: geometry.size.width,height: geometry.size.height)
                     
                        .padding(.top,20)
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
        .navigationBarTitle("Our Product",displayMode: .inline)
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
    //MARK: SET UP UI
    @ViewBuilder
    func SetUpUI(geometry:GeometryProxy) -> some View {
        ZStack(){
            NavigationLink("", destination: OurLoanProductsScreen(), isActive: $navigateToOurProduct)
            VStack(spacing: 0){
                
                
                //
                ContentView(geometry:geometry)
                //.background(Color.red)
                    .frame(maxWidth: .infinity,alignment: .center)
                    .frame(minHeight: geometry.size.height * 0.8)
                Spacer()
                
            }
            
            
        }
    }
    
    @ViewBuilder
    func ContentView(geometry:GeometryProxy) -> some View {
        ZStack(alignment: Alignment.top){
            VStack(spacing:4){ //
                TitleAndDescriptionView(title: "Hello! Welcome to Eclectics Mobile Banking app", description: "Please provide your phone number so that we can fetch Your account details")
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(listOfOurProductModel) { product in
                            if product.id == 1{
                                NavigationLink(destination: TypesofAccountsScreen(), label: {
                                    ProductView(product: product)
                                })
                            }else if product.id == 2{
                                NavigationLink(destination: CardProductsScreen(), label: {
                                    ProductView(product: product)
                                })
                            }else if product.id == 3{
                                NavigationLink(destination: OurLoanProductsScreen(), label: {
                                    ProductView(product: product)
                                })
                            }else if product.id == 4{
                                NavigationLink(destination: InvestmentProductsScreen(), label: {
                                    ProductView(product: product)
                                })
                            }else if product.id == 5{
                                NavigationLink(destination: InsuranceProductsScreen(), label: {
                                    ProductView(product: product)
                                })
                            }
                            
                        }
                    }
                }
                
            }.padding(10)
        }
    }
    
}



struct ProductView: View {
    let product: OurProductModel
    
    var body: some View {
        ZStack {
            VStack(spacing:0){
                HStack{
                    CustomTextSemiBold(
                        text: product.title,
                        textColor: Color(hexString: CustomColors.darkBlue),
                        fontSize: 14, textAlignment: .center
                    )
                    Spacer()
                    Button(action: {
                        
                    }, label: {
                        HStack{
                            Image(systemName: "arrow.forward")
                                .resizable()
                                .frame(width: 18,height: 15)
                                .scaledToFit()
                                .foregroundColor(Color(hexString: CustomColors.orange))
                        }
                    })
                    
                }.vSpacingWithMaxWidth()
                
                Image(product.image)
                    .resizable()
                    .frame(width: 122,height: 78,alignment: .bottomTrailing)
                    .aspectRatio(contentMode: .fill)
                
            }
            .padding(10)
            .background(Color.secondary.opacity(0.1))
            .cornerRadius(10)
        }
    }
}


