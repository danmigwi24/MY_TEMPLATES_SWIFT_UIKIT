//
//  UnsecuredLoanCalculatorScreen.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 09/02/2024.
//

import Foundation
import SwiftUI
import MBCore
import CustomTextField


struct UnsecuredLoanCalculatorScreen_Previews: PreviewProvider {
    static var previews: some View {
        UnsecuredLoanCalculatorScreen(calculatorItemModel: listOfCalculatorItemModel[0])
    }
}


struct UnsecuredLoanCalculatorScreen: View {
    var calculatorItemModel:CalculatorItemModel //= ""
    //
    @State private var loanAmount:String = ""
    @State private var repaymentPeriod:String = ""
    @State private var interestRate:String = ""
    
    //
    @State private var navigateTo:Bool = false
    //
    @State private var showDialog:Bool = false
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
extension UnsecuredLoanCalculatorScreen {
    
    //MARK: SET UP UI
    @ViewBuilder
    func MainContent() -> some View {
        VStack{
            GeometryReader { geometry in
                //
                LoadingView(isShowing: self.$sharedViewModel.isLoading) {
                    SetUpUI(geomerty:geometry)
                        .frame(width: geometry.size.width,height: geometry.size.height)
                     
                    //
                }
                
            }
            
        }
        .onAppear {
            
            
        }
        .onDisappear{
            showDialog = false
        }
        .alert(isPresented: $sharedViewModel.showAlert){
            CustomAlert(
                isPresented: $sharedViewModel.showAlert,
                title: sharedViewModel.alertTitle,
                decription: sharedViewModel.alertMessage
            )
        }
        .actionSheet(isPresented: self.$sharedViewModel.showActionSheet) {
            CustomActionSheet(
                isPresented: $sharedViewModel.showActionSheet,
                title: sharedViewModel.alertTitle,
                decription: sharedViewModel.actionSheetMessage
            )
        }
        .navigationBarTitle(calculatorItemModel.title,displayMode: .inline)
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
    @ViewBuilder
    func SetUpUI(geomerty:GeometryProxy) -> some View {
        ZStack(alignment: .top){
            NavigationLink("", destination: Text(""), isActive: $navigateTo)
            VStack(){
                //
                ContentView(geomerty:geomerty)
                //.background(Color.red)
                    .frame(maxWidth: .infinity,alignment: .top)
                    .frame(minHeight: geomerty.size.height * 0.8)
                Spacer()
            }
            
            if showDialog {
                SampleDailog(showDialog: $showDialog, action: {
                    
                })
            }
        }
    }
    
    @ViewBuilder
    func ContentView(geomerty:GeometryProxy) -> some View {
        ZStack{
            VStack{
                TitleAndDescriptionView(
                    title: "Calculate your ideal loan amount and See the monthly interest",
                    description: "You can change the interest rate incase you have A relationship manger"
                )
                ScrollView(.vertical,showsIndicators: false){
                    VStack{
                        //
                        InputField()
                        //
                        ResultSection().padding(5)
                        
                    }
                }
                    .frame(minHeight: geomerty.size.height * 0.5)//, maxHeight: geomerty.size.height * 0.6)
                    //Spacer()
                    CustomButtonFilled(
                        action: {
                            
                        },
                        title: "CALCULATE",
                        bgColor: Color(hexString: CustomColors.lightBlue),
                        textColor: Color.white
                    )
                
              
            }.padding(.horizontal,10)
               
        }
    }
    
    @ViewBuilder
    func InputField() -> some View {
        VStack{
            FloatingTextFieldView(text: $loanAmount, label: "Loan Amount", placeHolder : "Enter Amount",  action: {} )
            FloatingTextFieldView(text: $loanAmount, label: "Repayment Period", placeHolder : "Eg.3 Months",  action: {} )
            FloatingTextFieldView(text: $loanAmount, label: "Interest Rate", placeHolder : "eg:13.5 %",  action: {} )
            
        }.padding(.vertical,10)
    }
    
    @ViewBuilder
    func ResultSection() -> some View {
        VStack{
            Image("equal_sign")
                .resizable()
                .frame(width: 55,height: 55)
            
            
            CustomTextRegular(text: "Your monthly repayment is", textColor: Color(hexString: CustomColors.black), fontSize: 12, textAlignment: .center)
            
            CustomTextBold(text: "KES 50,562.56", textColor: Color(hexString: CustomColors.darkBlue), fontSize: 18, textAlignment: .center)
            
            CustomTextRegular(text: "Total repayment is", textColor: Color(hexString: CustomColors.black), fontSize: 12, textAlignment: .center)
            
            CustomTextBold(text: "KES 1,635,255.46", textColor: Color(hexString: CustomColors.darkBlue), fontSize: 18, textAlignment: .center)
           
            
        }.padding(.vertical,10)
    }
    
}

/**
 BUSINESS LOGICS
 */

extension UnsecuredLoanCalculatorScreen{
    
    //MARK: Validate Fields
    func validateFields() -> Bool {
        
//        guard !loanAmount.isEmpty else {
//            sharedViewModel.showAlert(title: "", message: "Please read terms and condition and check the box")
//            return false
//        }
        
        
        // All validations passed
        return true
    }
    
}







