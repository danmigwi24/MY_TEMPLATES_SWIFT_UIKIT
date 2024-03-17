//
//  MinimumDepositScreen.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 20/02/2024.
//

import Foundation
import SwiftUI
import MBCore
import CoreLocation
import CustomHalfSheet
import SwiftUI
import SwiftUIDigitalSignature
import Localize_Swift
import Combine
import MapKit
import CodeScanner

struct MinimumDepositScreen_Previews: PreviewProvider {
    static var previews: some View {
        MinimumDepositScreen()
    }
}


struct MinimumDepositScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    //
    @State private var navigateToHome:Bool = false
    @State private var navigateTo:Bool = false
    //
    @State private var showDialog:Bool = false
    @State private var isShowingHalfASheet = false
    //
    @State private var amount: String = ""
    @State private var serviceProvider: String = ""
    @State private var phoneNumber: String = ""
    //
    let listOfDropdownItem = listOfSelectServiceProviderModel.map { $0.toDropDownItems() }
    @State  var selectedDropdownItem: DropdownItem = listOfSelectServiceProviderModel[0].toDropDownItems()
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
extension MinimumDepositScreen {
    
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
        .navigationBarTitle("Minimum Deposit".localized(),displayMode: .inline)
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(false)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                /*
                 Button(action: {
                 // Action to perform when the "Next" button is tapped
                 submitAction()
                 }, label: {
                 Text("Next")
                 .foregroundColor(Color.blue)
                 })
                 */
            }
        }
        
    }
    
    
}
/**
 *VIEW EXTEXTIONS*
 */
extension MinimumDepositScreen {
    
    //MARK: SET UP UI
    @ViewBuilder
    func SetUpUI(geometry:GeometryProxy) -> some View {
        ZStack(){
            NavigationLink("", destination:SecurityQuestionScreen(), isActive: $navigateTo).opacity(0)
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
            /*
            //MARK: HalfASheet
            HalfASheet(isPresented: $isShowingHalfASheet, title: "") {
                VStack() {
                    SheetSection(geometry: geometry)
                    Spacer()
                }
                .padding(5)
            }
            // Customise by editing these.
            .height(.proportional(0.50))
            .disableDragToDismiss
            .backgroundColor(.white)
            .contentInsets(EdgeInsets(top: 10, leading: 10, bottom: 20, trailing: 10))
            */
        }
    }
    
    @ViewBuilder
    func ContentView(geometry:GeometryProxy) -> some View {
        //ScrollView(.vertical,showsIndicators: false) {
        VStack(){
            CustomTextBold(
                text: "MinimumDepositScreen.title".localized(),
                textColor: Color.black,
                fontSize: 20,
                textAlignment: .leading).vSpacingWithMaxWidth(.leading)
            
            CustomTextRegular(
                text: "MinimumDepositScreen.description".localized(),
                textColor: Color(hexString: CustomColors.darkBlue),
                fontSize: 14,
                textAlignment: .leading).vSpacingWithMaxWidth(.leading)
            
            //
            LottieView(name: LottieFiles.BANK)
                .frame(maxWidth: .infinity)
                .frame(minHeight: geometry.size.height * 0.45,
                       maxHeight: geometry.size.height * 0.60)
                .padding(.horizontal,10)
            
            Spacer()
            ButtonSection(geometry: geometry)
        }.padding(.horizontal,8)
        //}
    }
    
    @ViewBuilder
    func ButtonSection(geometry:GeometryProxy) -> some View {
        VStack{
            Spacer()
            
            CustomButtonFilled(
                action: {
                    isShowingHalfASheet.toggle()
                },
                title: "MinimumDepositScreen.MAKEDEPOSIT".localized(),
                bgColor: Color(hexString: CustomColors.blue),
                textColor: Color(hexString: CustomColors.white)
            ).popover(isPresented: $isShowingHalfASheet) {
                VStack() {
                    SheetSection(geometry: geometry)
                    Spacer()
                }
                .padding()
            }
            
            CustomButtonStroke(
                action: {
                    self.navigateTo.toggle()
                },
                title: "GLOBAL.NOTNOW".localized(),
                bgColor: Color.clear,
                textColor: Color(hexString:CustomColors.lightBlue),
                strokeColor: Color(hexString:CustomColors.lightBlue),
                strokeWidth: 1
            )
            
        }
    }
    
    
    @ViewBuilder
    func  SheetSection(geometry:GeometryProxy) -> some View {
        VStack{
            //
            CustomTextBold(
                text: "MinimumDepositScreen.how_much_deposit".localized(),
                textColor: Color(hexString: CustomColors.darkBlue),
                fontSize: 20,
                textAlignment: .leading).vSpacingWithMaxWidth(.leading)
            
            FloatingTextFieldView(text: $amount, label: "Step2CreatePanicPinScreen.amount_label".localized(), placeHolder : "Step2CreatePanicPinScreen.amount_hint".localized(),  action: {} )
            
            //Select Service Provider
            CustomDropDownWithLeftIconPickerView(
                listOfOptions: listOfDropdownItem,
                selectedItem: $selectedDropdownItem,
                label: "Select Service Provider",
                placeHolder: "Mpesa"
            ).onChange(of: selectedDropdownItem) {  newValue in
                    print("selectedDropdownItem  \(selectedDropdownItem.returnedModel)")
                }
            //Phone Number
            FloatingTextFieldView(
                text: $serviceProvider,
                label: "Phone Number".localized(),
                placeHolder : "Eg. +254712345678".localized(),
                rightIcon: "",
                isSystemImageLeftIcon: false,
                action: {
                    
                }
            )
            
           
            
            CustomButtonFilled(
                action: {
                    submitAction()
                },
                title: "GLOBAL.CONTINUE".localized(),
                bgColor: Color(hexString: CustomColors.blue),
                textColor: Color(hexString: CustomColors.white)
            )
        }
    }
}

extension MinimumDepositScreen{
    
    //MARK: Validate Fields
    func validateFields() -> Bool {
        
//        guard !amount.isEmpty else {
//            showCustomizedSwiftMessages(title: "Error", body:"amount Required")
//            return false
//        }
        
        // All validations passed
        return true
    }
    
    private func submitAction(){
        if validateFields(){
            sharedViewModel.isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                sharedViewModel.isLoading = false
                //
                
                self.navigateToHome.toggle()
            }
        }
    }
}




