//
//  Step4AccountOpeningScreen.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 12/02/2024.
//

import Foundation
import SwiftUI
import MBCore




struct Step4AccountOpeningScreen_Previews: PreviewProvider {
    static var previews: some View {
        GetStartedLandingPageScreen()
    }
}


struct Step4AccountOpeningScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.dismiss) private var dismiss
    //
    @State private var navigateTo:Bool = false
    //
    @State private var showDialog:Bool = false
    
    //
    @State private var internetBankingSelected:Bool = false
    @State private var             uSSDMobileBankingSelected:Bool = false
    //
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
extension Step4AccountOpeningScreen {
    
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
        .navigationBarTitle("E-Channel Activation",displayMode: .inline)
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
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    //dismiss()
                    if validateFields(){
                        self.navigateTo.toggle()
                    }
                }, label: {
                    HStack{
                        Text("Next")
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
            NavigationLink("", destination: Step5AccountOpeningScreen(), isActive: $navigateTo).opacity(0)
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
    
    //
    @ViewBuilder
    func ContentView(geometry:GeometryProxy) -> some View {
       // ScrollView(.vertical,showsIndicators: false) {
            VStack(spacing:5){
                
                AccountOpeningTitlesView(title:"Let’s get to know you a little bit more as our Customer", description: "Please provide the details below to have us get your personal Information")
                
                
                InternetBankingSection()
                USSDMobileBankingSection().padding(.vertical,5)
                Spacer()//.background(Color.red)
                //ButtonSection()
                
            }.padding(10)
       // }
    }
    
    //
    @ViewBuilder
    func InternetBankingSection() -> some View {
        VStack{
            HStack{
                VStack{
                    CustomTextSemiBold(text: "Internet Banking", textColor: .black, fontSize: 16, textAlignment: .leading).vSpacingWithMaxWidth(.leading)
                    CustomTextRegular(text: "Banking transactions are conducted electronically via the internet.", textColor: .gray, fontSize: 14, textAlignment: .leading).vSpacingWithMaxWidth(.leading)
                }
                Image(systemName: internetBankingSelected ? "circle.fill" : "circle").frame(alignment: .topLeading)
            }
        }
        .padding(10)
        .onTapGesture {
            internetBankingSelected = true
            uSSDMobileBankingSelected = false
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black,lineWidth: 1)
            )
        
    }
    
    //
    @ViewBuilder
    func USSDMobileBankingSection() -> some View {
        VStack{
            HStack{
                VStack{
                    CustomTextSemiBold(text: "USSD Mobile Banking", textColor: .black, fontSize: 16, textAlignment: .leading).vSpacingWithMaxWidth(.leading)
                    CustomTextRegular(text: "Banking transactions are conducted electronically via the internet.", textColor: .gray, fontSize: 14, textAlignment: .leading).vSpacingWithMaxWidth(.leading)
                }
                Image(systemName: uSSDMobileBankingSelected ? "circle.fill" : "circle").frame(alignment: .topLeading)
            }
        }
        .padding(10)
        .onTapGesture {
            internetBankingSelected = false
            uSSDMobileBankingSelected = true
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black,lineWidth: 1)
            
        )
     
        
    }
    
    //
    @ViewBuilder
    func ButtonSection() -> some View {
        VStack{
            HStack(){
                Spacer()
                
                Button(action: {
                    self.navigateTo.toggle()
                }, label: {
                    ZStack{
                        Image(systemName: "arrow.forward")
                        //.resizable()
                            .foregroundColor(.white)
                        
                    }
                })
                .padding(20)
                .background(Capsule().fill(Color(hexString: CustomColors.blue)))
            }
        }
    }
    
}


extension Step4AccountOpeningScreen{
    
    //MARK: Validate Fields
    func validateFields() -> Bool {
        
//        guard !phoneNumber.isEmpty else {
//            showCustomizedSwiftMessages(title: "Error", body:"Required")
//            return false
//        }
        
        // All validations passed
        return true
    }
    
}






