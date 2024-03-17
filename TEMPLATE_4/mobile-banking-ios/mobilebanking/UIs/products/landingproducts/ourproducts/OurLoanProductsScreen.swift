//
//  OurLoanProductsScreen.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 15/02/2024.
//

import Foundation
import SwiftUI
import MBCore

import CoreLocation


struct OurLoanProductsScreen_Previews: PreviewProvider {
    static var previews: some View {
        GetStartedLandingPageScreen()
    }
}


struct OurLoanProductsScreen: View {
    
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
extension OurLoanProductsScreen {
    
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
        .navigationBarTitle("Our Loan Products",displayMode: .inline)
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
extension OurLoanProductsScreen {
    //MARK: SET UP UI
    @ViewBuilder
    func SetUpUI(geometry:GeometryProxy) -> some View {
        ZStack(){
            NavigationLink("", destination: Text(""), isActive: $navigateTo).opacity(0)
            VStack(){
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
        ScrollView(.vertical,showsIndicators: false) {
            VStack(spacing:0){
                
                CustomTextBold(text: "Here are some of the loan products that We offer at Eclectics", textColor: Color(hexString: CustomColors.black), fontSize: 16, textAlignment: .leading).vSpacingWithMaxWidth(.leading)
                //
                CustomTextSemiBold(text: "You can only apply for one product at a time, select and Apply for a loan that you are eligible for", textColor: Color(hexString: CustomColors.darkBlue), fontSize: 14, textAlignment: .leading).vSpacingWithMaxWidth(.leading)
                RecommendedLoanProductsSection(geometry: geometry)
            }
        }.padding(10)
    }
    
    
    @ViewBuilder
    func RecommendedLoanProductsSection(geometry:GeometryProxy) -> some View {
        
        VStack(spacing:0){
            HStack{
                //
                CustomTextSemiBold(text: "Recommended loan products", textColor: Color(hexString: CustomColors.darkBlue), fontSize: 14, textAlignment: .leading).vSpacingWithMaxWidth(.leading)
            }
            
            ScrollView(.horizontal,showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    ForEach(0..<4) { index in
                        RecommendedLoanProductsItem(geometry: geometry).padding(.horizontal,4)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func RecommendedLoanProductsItem(geometry:GeometryProxy) -> some View {
        VStack{
            Image("SalaryAdvance")
                .resizable()
                  //.frame(maxWidth: .infinity)
                .frame(maxWidth: geometry.size.width * 0.82 )
                 .frame(height: geometry.size.height * 0.25, alignment: .topLeading)
                .aspectRatio(contentMode: .fill)
                
            VStack(spacing: 0){
                //
                CustomTextBold(text: "Salary Advance", textColor: Color(hexString: CustomColors.darkBlue), fontSize: 14, textAlignment: .leading).vSpacingWithMaxWidth(.leading)
                
                CustomTextRegular(text: "Enjoy quick salary advances when you are in need of A quick loan to sort out your regular bills", textColor: Color(hexString: CustomColors.black), fontSize: 12, textAlignment: .leading).vSpacingWithMaxWidth(.leading)
                //
                CustomTextBold(text: "Eligibility criteria", textColor: Color(hexString: CustomColors.darkBlue), fontSize: 14, textAlignment: .leading).vSpacingWithMaxWidth(.leading)
                
                CustomTextRegular(text: "Minimum salary KES 15,000 per month\n\nRepayment period 1 month", textColor: Color(hexString: CustomColors.black), fontSize: 12, textAlignment: .leading).vSpacingWithMaxWidth(.leading)
                //
                CustomTextBold(text: "Benefits", textColor: Color(hexString: CustomColors.darkBlue), fontSize: 14, textAlignment: .leading).vSpacingWithMaxWidth(.leading)
                
                CustomTextRegular(text: "Get access up to 70% of your monthly salary", textColor: Color(hexString: CustomColors.black), fontSize: 12, textAlignment: .leading).vSpacingWithMaxWidth(.leading)
                
                //
                OurProductButtonSectionView(titleOne: "APPLY FOR THIS PRODUCT", titleTwo:"LEARN MORE", actionTop: {}, actionButtom: {})
            }.padding(10)

        }
       
        .background(Color(hexString: CustomColors.lightGray))
        .cornerRadius(10)
        .frame(maxWidth: geometry.size.width * 0.82 )//,maxHeight: geometry.size.height * 0.4)
    }
    
    
}



struct OurProductButtonSectionView:View {
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
                textColor: Color.white
            )
            
            CustomButtonStroke(
                action: {
                    actionButtom()
                },
                title: titleTwo,
                bgColor: Color.clear,
                textColor: Color(hexString:CustomColors.lightBlue),
                strokeColor: Color(hexString:CustomColors.lightBlue),
                strokeWidth: 1
            )
        }
    }
}
