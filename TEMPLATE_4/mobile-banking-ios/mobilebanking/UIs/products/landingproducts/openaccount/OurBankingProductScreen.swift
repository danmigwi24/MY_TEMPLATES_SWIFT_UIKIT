//
//  OurBankingProductScreen.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 16/02/2024.
//

import Foundation
import SwiftUI
import MBCore

import CoreLocation


struct OurBankingProductScreen_Previews: PreviewProvider {
    static var previews: some View {
        OurBankingProductScreen()
    }
}


struct OurBankingProductScreen: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var navigateTo:Bool = false
    //
    @State private var showDialog:Bool = false
    //MARK: NEEDED FOR API
    @StateObject private var sharedViewModel = SharedViewModel()
    
    //
    @State private var currentIndictorRecommended:Int = 0
    @State private var currentIndictorCurrent:Int = 0
    //
   private let listOfRecommendedProductsItem = listOfRecommendedProductsModel
    //
    private let listOfCurrentSavingAccountsItem = listOfCurrentSavingAccountsModel
    //
    var body: some View {
        MainContent()
    }
    
    
}

/**
 *VIEW EXTEXTIONS*
 */
extension OurBankingProductScreen {
    
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
        .navigationBarTitle("Our Banking Products",displayMode: .inline)
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label:{
                    HStack{
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.black)
                        Text("Back")
                            .foregroundColor(Color.blue)
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
            NavigationLink("", destination: PersonalCurrentAccountScreen(), isActive: $navigateTo).opacity(0)
            VStack(){
               
                
                //
                ContentView(geometry:geometry)
                //.background(Color.red)
                    .frame(maxWidth:geometry.size.width,alignment: .center)
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
            VStack(spacing:4){
                
                CustomTextBold(text: "Here are some of the loan products that We offer at Eclectics", textColor: Color(hexString: CustomColors.black), fontSize: 16, textAlignment: .leading).vSpacingWithMaxWidth(.leading)
                //
                CustomTextSemiBold(text: "You can only apply for one product at a time, select and Apply for a loan that you are eligible for", textColor: Color(hexString: CustomColors.darkBlue), fontSize: 14, textAlignment: .leading).vSpacingWithMaxWidth(.leading)
                RecommendedProductsSection(geometry: geometry)
                CurrentSavingAccountsSection(geometry: geometry)
            }
        }.padding(10)
    }
    
    @ViewBuilder
    func RecommendedProductsSection(geometry:GeometryProxy) -> some View {
        
        VStack(spacing:2){
            /*
            HStack{
                //
                CustomTextSemiBold(text: "Recommended products", textColor: Color(hexString: CustomColors.darkBlue), fontSize: 14, textAlignment: .leading).vSpacingWithMaxWidth(.leading)
            }
            */
            
           PagingView(index: $currentIndictorRecommended.animation(), title: "Recommended products", maxIndex: listOfRecommendedProductsItem.count - 1) {
                   ForEach(listOfRecommendedProductsItem) { item in
                       RecommendedProductsItem(
                        geometry: geometry,
                        item: item,
                        widthValue: geometry.size.width * 0.75
                       )
                       .padding(.vertical,4)
                   }
                }
            .frame(maxWidth: geometry.size.width)
            .frame(minHeight: geometry.size.height * 0.4, alignment: .topLeading)
        }
    }
    
    
    
    
    
    @ViewBuilder
    func RecommendedProductsItem(geometry:GeometryProxy,item:RecommendedProductsModel,widthValue:CGFloat) -> some View {
        ZStack{
            Image(item.image)
                .resizable()
                .frame(maxWidth: widthValue)
                .frame(height: geometry.size.height * 0.35, alignment: .topLeading)
                .aspectRatio(contentMode: .fill)
            
            VStack(spacing: 0){
                //
                Spacer()
                CustomTextBold(text: item.title, textColor: Color(hexString: CustomColors.white), fontSize: 14, textAlignment: .leading).vSpacingWithMaxWidth(.leading)
                
                CustomTextRegular(text: item.description, textColor: Color(hexString: CustomColors.white), fontSize: 12, textAlignment: .leading).vSpacingWithMaxWidth(.leading)
                //
                OurBankingProductButtonSectionView(titleOne: "OPEN AN ACCOUNT", titleTwo:"LEARN MORE", actionTop: {
                    navigateTo.toggle()
                }, actionButtom: {}).vSpacingWithMaxWidth(.bottomLeading)
            }.padding(10)
            
        }
        .cornerRadius(10)
        .frame(maxWidth: widthValue,maxHeight: geometry.size.height * 0.35)
    }
    
    @ViewBuilder
    func CurrentSavingAccountsSection(geometry:GeometryProxy) -> some View {
        
        VStack(spacing:0){
            /*
            HStack{
                //
                CustomTextSemiBold(text: "Current & Saving Accounts", textColor: Color(hexString: CustomColors.darkBlue), fontSize: 14, textAlignment: .leading).vSpacingWithMaxWidth(.leading)
            }
           
            ScrollView(.horizontal,showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    ForEach(0..<4) { index in
                        CurrentSavingAccountsItem(geometry: geometry).padding(.horizontal,4)
                    }
                }
            }
             */
            PagingView(index: $currentIndictorCurrent.animation(), title: "Current & Saving Accounts", maxIndex: listOfCurrentSavingAccountsModel.count - 1) {
                    ForEach(listOfCurrentSavingAccountsModel) { item in
                        CurrentSavingAccountsItem(
                         geometry: geometry,
                         item: item,
                         widthValue: geometry.size.width * 0.7
                        )
                        .padding(.vertical,4)
                    }
                 }
             .frame(maxWidth: geometry.size.width)
             .frame(minHeight: geometry.size.height * 0.4, alignment: .topLeading)
        }
    }
    
    @ViewBuilder
    func CurrentSavingAccountsItem(geometry:GeometryProxy,item:CurrentSavingAccountsModel,widthValue:CGFloat) -> some View {
        ZStack{
            Image(item.image)
                .resizable()
                .frame(maxWidth: widthValue)
                .frame(height: geometry.size.height * 0.35, alignment: .topLeading)
                .aspectRatio(contentMode: .fill)
            
            VStack(spacing: 0){
                //
                Spacer()
                CustomTextBold(text: item.title, textColor: Color(hexString: CustomColors.white), fontSize: 14, textAlignment: .leading).vSpacingWithMaxWidth(.leading)
                
                CustomTextRegular(text: item.description, textColor: Color(hexString: CustomColors.white), fontSize: 12, textAlignment: .leading).vSpacingWithMaxWidth(.leading)
                //
                OurBankingProductButtonSectionView(titleOne: "OPEN AN ACCOUNT", titleTwo:"LEARN MORE", actionTop: {
                    navigateTo.toggle()
                }, actionButtom: {
                    
                }).vSpacingWithMaxWidth(.bottomLeading)
            }.padding(10)
            
        }
        //.background(Color(hexString: CustomColors.lightGray))
        .cornerRadius(10)
        .frame(maxWidth: widthValue,maxHeight: geometry.size.height * 0.35)
    }
    
    
}

extension OurBankingProductScreen{

}

struct OurBankingProductButtonSectionView:View {
    let titleOne:String
    let titleTwo:String
    let actionTop:()->()
    let actionButtom:()->()
    
    var body: some View{
        VStack{
            CustomButtonFilled(
                action: {
                    actionTop()
                },
                title: titleOne,
                bgColor: Color(hexString:CustomColors.lightBlue),
                textColor: Color.white,
                paddingVertical: 8
            )
            
            CustomButtonStroke(
                action: {
                    actionButtom()
                },
                title: titleTwo,
                bgColor: Color.clear,
                textColor: Color(hexString:CustomColors.white),
                strokeColor: Color(hexString:CustomColors.white),
                strokeWidth: 1,
                paddingVertical: 8
            )
        }
    }
}


