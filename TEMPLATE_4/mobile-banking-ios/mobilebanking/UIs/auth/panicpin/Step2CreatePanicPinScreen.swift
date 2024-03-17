//
//  Step2CreatePanicPinScreen.swift
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

struct Step2CreatePanicPinScreen_Previews: PreviewProvider {
    static var previews: some View {
        Step2CreatePanicPinScreen()
    }
}


struct Step2CreatePanicPinScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var navigateToContinue:Bool = false
    @State private var navigateToNotNow:Bool = false
    //
    @State private var showDialog:Bool = false
    @State private var isShowingHalfASheet = false
    //
    @State private var digitalSignature: UIImage? = nil
    //
    @State private var setMaximumAmount: String = ""
    //
    @State private var listOfDropdownItemOption:[DropdownItem] = listOfUserAccountModel.map { $0.toDropDownItems() }
    @State private var selectedDropdownItemOption:DropdownItem = listOfUserAccountModel[0].toDropDownItems()
    //
    //MARK: NEEDED FOR API
    @StateObject var sharedViewModel = SharedViewModel()
    //private let danFramework =

    //
    var body: some View {
        MainContent()
    }
    
    
}

/**
 *VIEW EXTEXTIONS*
 */
extension Step2CreatePanicPinScreen {
    
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
        .navigationBarTitle("Step1CreatePanicPinScreen.header".localized(),displayMode: .inline)
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(false)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                ///*
                Button(action: {
                    // Action to perform when the "Next" button is tapped
                  submitAction()
                }, label: {
                    Text("Next")
                        .foregroundColor(Color.blue)
                })
                 //*/
            }
        }
        
    }
    
    
}
/**
 *VIEW EXTEXTIONS*
 */
extension Step2CreatePanicPinScreen {
    
    //MARK: SET UP UI
    @ViewBuilder
    func SetUpUI(geometry:GeometryProxy) -> some View {
        ZStack(){
            NavigationLink("", destination: Step3CreatePanicPinScreen(), isActive: $navigateToContinue).opacity(0)
            NavigationLink("", destination: LoginScreen(), isActive: $navigateToNotNow).opacity(0)
            VStack(){
                //
                ContentView(geometry:geometry)
                //.background(Color.red)
                    .padding(.horizontal,8)
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
            
            //MARK: HalfASheet
            HalfASheet(isPresented: $isShowingHalfASheet, title: "") {
                VStack(spacing: 0) {
                    CustomSpacer(height: 10)
                    SignatureView(availableTabs: [.image,.type],
                                  onSave: { image in
                        self.digitalSignature = image
                    }, onCancel: {
                        
                    })
                }
                .padding(5)
            }
            // Customise by editing these.
            .height(.proportional(0.70))
            //.closeButtonColor(UIColor.white)
            //.backgroundColor(.white)
            .contentInsets(EdgeInsets(top: 10, leading: 10, bottom: 20, trailing: 10))
            
        }
    }
    
    @ViewBuilder
    func ContentView(geometry:GeometryProxy) -> some View {
        ScrollView(.vertical,showsIndicators: false) {
            VStack(){
                CustomTextBold(
                    text: "Step2CreatePanicPinScreen.title".localized(),
                    textColor: Color.black,
                    fontSize: 20,
                    textAlignment: .leading).vSpacingWithMaxWidth(.leading)

                CustomTextRegular(
                    text: "Step2CreatePanicPinScreen.description".localized(),
                    textColor: Color.black.opacity(0.5),
                    fontSize: 14,
                    textAlignment: .leading).vSpacingWithMaxWidth(.leading)

                //
                LottieView(name: LottieFiles.CREATE_PANIC_PIN)
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: geometry.size.height * 0.25,
                           maxHeight: geometry.size.height * 0.40)
                    .padding(.horizontal,10)
                //
                InputFieldSection()
                //
                //Spacer(minLength: geometry.size.height * 0.05)
                //ButtonSection()
                
            }
        }
    }
    
    //
    @ViewBuilder
    func InputFieldSection() -> some View {
        VStack{
            CustomTextBold(
                text: "Step2CreatePanicPinScreen.text1".localized(),
                textColor: Color(hexString: CustomColors.darkBlue),
                fontSize: 14,
                textAlignment: .leading)
            .vSpacingWithMaxWidth(.leading)
            
            CustomTextRegular(
                text: "Step2CreatePanicPinScreen.text2".localized(),
                textColor: Color(hexString: CustomColors.gray),
                fontSize: 12,
                textAlignment: .leading)
            .vSpacingWithMaxWidth(.leading)
            
            //
            FloatingTextFieldView(text: $setMaximumAmount, label: "Step2CreatePanicPinScreen.amount_label".localized(), placeHolder : "Step2CreatePanicPinScreen.amount_hint".localized(),  action: {} )
            
            
            CustomDropDownWithPickerView(listOfOptions: listOfDropdownItemOption, selectedItem: $selectedDropdownItemOption, label: "Select Account", placeHolder: "Current Account- A/C #1234******6789")
                .onChange(of: selectedDropdownItemOption) {  newValue in
                    print("selectedDropdownItem  \(selectedDropdownItemOption.returnedModel)")
                }

        }
    }
    //
    @ViewBuilder
    func ButtonSection() -> some View {
        
        VStack{
            CustomButtonFilled(
                action: {
                    self.navigateToContinue.toggle()
                },
                title: "GLOBAL.CONTINUE".localized(),
                bgColor: Color(hexString:CustomColors.lightBlue),
                textColor: Color.white
            )
            
            CustomButtonStroke(
                action: {
                    self.navigateToNotNow.toggle()
                },
                title: "GLOBAL.NOTNOW".localized(),
                bgColor: Color.clear,
                textColor: Color(hexString:CustomColors.blue),
                strokeColor: Color(hexString:CustomColors.blue),
                strokeWidth: 1
            )
            //
            CustomSpacer(height: 10)
        }
    }
    
}


extension Step2CreatePanicPinScreen{
    
    //MARK: Validate Fields
    func validateFields() -> Bool {
        
//        guard !setMaximumAmount.isEmpty else {
//            showCustomizedSwiftMessages(title: "Error", body:"Amount required")
//            return false
//        }
        
        // All validations passed
        return true
    }
    
    private func submitAction(){
        if validateFields(){
            sharedViewModel.isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                sharedViewModel.isLoading = false
                self.navigateToContinue.toggle()
            }
        }
    }
}


