//
//  ForexAndStockScreen.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 08/02/2024.
//

import Foundation
import SwiftUI
import MBCore



struct ForexAndStockScreen_Previews: PreviewProvider {
    static var previews: some View {
        GetStartedLandingPageScreen()
    }
}


struct ForexAndStockScreen: View {
    
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
extension ForexAndStockScreen {
    
    //MARK: SET UP UI
    @ViewBuilder
    func MainContent() -> some View {
        VStack{
            GeometryReader { geometry in
                //
                //
                LoadingView(isShowing: self.$sharedViewModel.isLoading) {
                    SetUpUI()
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
        .navigationBarTitle("Forex And Stock",displayMode: .inline)
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
    
    
    
    
    //MARK: SET UP UI
    //MARK: SET UP UI
    @ViewBuilder
    func SetUpUI() -> some View {
        ZStack(){
            NavigationLink("", destination: Text(""), isActive: $navigateTo)
            VStack(spacing: 0){
                ContentView()
                //.background(Color.red)
                    .frame(maxWidth: .infinity,alignment: .center)
                    .frame(height: UIScreen.main.bounds.height * 0.8)
                Spacer()
                
            }
            
            
        }
    }
    
    @ViewBuilder
    func ContentView() -> some View {
        ZStack(alignment: Alignment.top){
            VStack(spacing:10){
                
                CustomTextBold(
                    text: "Understand the stock market and forex Trading to assist you in making profitable Investments today!",
                    textColor: Color(hexString: CustomColors.black),
                    fontSize: 16,
                    textAlignment: TextAlignment.leading
                ).vSpacingWithMaxWidth(.leading)
                
                CustomTextBold(
                    text: "Best performing stock exchange",
                    textColor: Color(hexString: CustomColors.darkBlue),
                    fontSize: 12,
                    textAlignment: TextAlignment.leading
                ).vSpacingWithMaxWidth(.leading)
                
                HStack(){
                    BestPerformingStockExchangeSection(image: "safaricomltd", title: "Safaricom Ltd", desc: "KES 32.90", interest: "+0.70%")
                    BestPerformingStockExchangeSection(image: "CICInsurance", title: "CIC Insurance", desc: "KES 32.90", interest: "+0.70%")
                    BestPerformingStockExchangeSection(image: "EquityBank", title: "Equity Bank", desc: "KES 32.90", interest: "+0.70%")
                }
                GeneralPerformanceSection()
                
            }.padding(10)
        }
    }
    
    
    
    @ViewBuilder
    func BestPerformingStockExchangeSection(image:String,title:String,desc:String,interest:String) -> some View {
        VStack{
            HStack{
                Image(image)
                    .resizable()
                    .frame(width: 30,height: 30,alignment: .topLeading)
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                Spacer()
            }
            CustomTextBold(
                text: title,
                textColor: Color(hexString: CustomColors.darkBlue),
                fontSize: 12,
                textAlignment: TextAlignment.leading
            ).vSpacingWithMaxWidth(.leading)
            
            CustomTextBold(
                text: desc,
                textColor: Color(hexString: CustomColors.green),
                fontSize: 12,
                textAlignment: TextAlignment.leading
            ).vSpacingWithMaxWidth(.leading)
            
            CustomTextBold(
                text: interest,
                textColor: Color(hexString: CustomColors.green),
                fontSize: 12,
                textAlignment: TextAlignment.leading
            ).vSpacingWithMaxWidth(.leading)
            
            
        }
        .padding(5)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color(hexString: CustomColors.lightGray)))
    }
    func GeneralPerformanceSection() -> some View {
        VStack{
            CustomTextBold(
                text: "General performance of all foreign exchange, Nairobi stock exchange and crypto currency",
                textColor: Color(hexString: CustomColors.darkBlue),
                fontSize: 14,
                textAlignment: TextAlignment.leading
            )
            .vSpacingWithMaxWidth(.topLeading)
            ScrollView {
                ForEach(listOfForexAndStockItemModel) { item in
                    ForexAndStockItemView(item: item)
                }
                
            }
            
        }
    }
    
}



struct ForexAndStockItemView: View {
    let item: ForexAndStockItemModel
    
    var body: some View {
        ZStack {
            HStack(spacing:4){
                
                Image(item.image)
                    .resizable()
                    .frame(width: 50,height: 50,alignment: .bottomTrailing)
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                
                HStack(spacing: 0) {
                    
                    VStack(spacing: 0){
                        CustomTextRegular(
                            text: item.title,
                            textColor: .black,
                            fontSize: 14,
                            textAlignment: TextAlignment.leading
                        )
                        .vSpacingWithMaxWidth(.topLeading)
                        
                        CustomTextRegular(
                            text: item.description,
                            textColor: Color(hexString: CustomColors.gray),
                            fontSize: 14,
                            textAlignment: TextAlignment.leading
                        )
                        .vSpacingWithMaxWidth(.topLeading)
                    }
                    
                    CustomTextRegular(
                        text: item.buy,
                        textColor: Color(hexString: CustomColors.green),
                        fontSize: 14,
                        textAlignment: .center
                    )
                    .vSpacingWithMaxWidth(.top)
                    
                    CustomTextRegular(
                        text: item.sell,
                        textColor: Color(hexString: CustomColors.red),
                        fontSize: 14,
                        textAlignment: .center
                    )
                    .vSpacingWithMaxWidth(.top)
                }
                
            }
            .padding(10)
            //.background(Color.secondary.opacity(0.1))
            .cornerRadius(10)
        }
    }
}
