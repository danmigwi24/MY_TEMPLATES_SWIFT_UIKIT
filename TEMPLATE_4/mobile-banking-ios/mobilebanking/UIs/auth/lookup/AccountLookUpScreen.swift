//
//  AccountLookUpScreen.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 08/02/2024.
//

import Foundation
import SwiftUI
import MBCore
import CustomTextField


struct AccountLookUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        AccountLookUpScreen()
    }
}


struct AccountLookUpScreen: View {
    //
    //
    @State private var selectedCountry: CountryModel = COUNTRYPICKER[0]
    @State private var phoneNumber:String = ""
    @State private var accountNumber:String = ""
    //
    @State private var listOfIdentificationOption:[String] = ["National ID","Passport"]
    @State private var selectedIdentificationOption:String = "National ID"
    @State private var idOrPassportNumber:String = ""
    //
    @State private var isTermsChecked:Bool = false
    //
    @State var errorPhoneNumber = false
    @State var errorIdNumber = false
    @State var errorAccountNumber = false
    //
    @State private var navigateToOpenAccount:Bool = false
    @State private var navigateToDeviceVerification:Bool = false
    @State private var navigateToLogin:Bool = false
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
extension AccountLookUpScreen {
    
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
        .navigationBarTitle("Account Look-up",displayMode: .inline)
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
                        self.prepareAccountLookUp()
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
            NavigationLink("", destination: DeviceVerificationScreen(whatIsVerified: 1), isActive: $navigateToDeviceVerification)
            NavigationLink("", destination: LoginScreen(), isActive: $navigateToLogin)
            
            VStack(){
                //
                ContentView(geometry: geometry)
                    .frame(maxWidth: .infinity,alignment: .center)
                    .frame(minHeight: geometry.size.height * 0.8)
            }
            
            if showDialog {
                OpenAccountDialog(show: $showDialog)
            }
        }
    }
    
    @ViewBuilder
    func ContentView(geometry:GeometryProxy) -> some View {
        ZStack{
            VStack{
                CustomTextBold(
                    text: "Hello! Welcome to Eclectics Mobile Banking app",
                    textColor: .black,
                    fontSize: 18,
                    textAlignment: TextAlignment.leading
                )
                .vSpacingWithMaxWidth(.leading)
                .onTapGesture {
                    navigateToLogin.toggle()
                }
                
                CustomTextRegular(
                    text: "Please provide your phone number so that we can fetch Your account details",
                    textColor: Color(hexString: CustomColors.blue),
                    fontSize: 16,
                    textAlignment: TextAlignment.leading
                )
                .vSpacingWithMaxWidth(.leading)
                .onTapGesture {
                    navigateToDeviceVerification.toggle()
                }
                //
                InputField()
                
                //
                Spacer()
                //
                TermsSection()
                //
               // ButtonSection()
               
                
                //
                //Spacer()
            }.padding(.horizontal,10)
                .padding(.bottom,30)
        }
    }
    
    @ViewBuilder
    func InputField() -> some View {
        VStack(spacing: 0){
            
            PhoneNumberFloatingTextFieldView(text: $phoneNumber, label: "Phone Number", placeHolder : "Eg. 712345678", selectedItem: $selectedCountry)
            
            DropDownField()
            
            FloatingTextFieldView(text: $accountNumber,label: "Account Number", placeHolder: "Eg. 01000012345678",action: {
            })
        }.padding(.vertical,10)
    }
    
    
    //
    @ViewBuilder
    func DropDownField() -> some View {
        VStack{
            CustomDropDownWithMenuView(label: "ID Type", placeHolder: "") {
                Menu(content: {
                    VStack{
                        ForEach(listOfIdentificationOption, id: \.self) { item in
                            Button(action: {
                                selectedIdentificationOption = item
                            }, label: {
                                Text(item)
                            })
                            
                        }
                    }
                }, label: {
                    HStack{
                        CustomTextBold(text: selectedIdentificationOption, textColor: .black, fontSize: 14, textAlignment: .leading)
                        Spacer()
                        Image(systemName: "arrowtriangle.down.fill")
                            .frame(width: 18,height: 15)
                            .scaledToFit()
                            .foregroundColor(.black)
                    }
                }).modifier(
                    MenuWidthModifier(width: 100)
                )
            }
            
            //
            FloatingTextFieldView(text: $idOrPassportNumber,label: selectedIdentificationOption, placeHolder: "Eg. 12345678",action: {
            })
            
        }.padding(.vertical,10)
        
    }
    
    
    //MARK: PrivacyPolicy SECTION
    @ViewBuilder
    func TermsSection() -> some View {
        VStack{
            HStack{
                Toggle(
                    isOn: $isTermsChecked,
                    label: {
                        Text("Check")
                            .fontWeight(.regular)
                    }
                )
                .toggleStyle(ToggleCheckboxStyles(isChecked: $isTermsChecked))
                .font(.title)
                
                HStack{
                    VStack {
                        Text("I agree to the")
                            .foregroundColor(Color(hexString: CustomColors.black))
                        + Text(" Terms & Conditions")
                            .foregroundColor(Color(hexString: CustomColors.blue))
                            .underline()
                        + Text(".")
                            .foregroundColor(Color.black)
                    }
                    
                    .font(.custom(CustomFontNames.NunitoSans_Regular, size: 14).weight(.regular))
                    
                }.hSpacing(.leading).padding(.vertical,10)
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            
        }
    }
    
    func ButtonSection() -> some View{
        VStack{
            CustomButtonFilled(
                action: {
                    if validateFields(){
                        //navigateToDeviceVerification.toggle()
                        
                        self.prepareAccountLookUp()
                    }
                },
                title: "CONTINUE",
                bgColor: Color(hexString: CustomColors.lightBlue),
                textColor: Color.white
            )
        }
    }
}


/**
 BUSINESS LOGICS
 */
extension AccountLookUpScreen{
    
    //MARK: Validate Fields
    func validateFields() -> Bool {
        
        /**/
        guard isTermsChecked else {
            sharedViewModel.showAlert(title: "", message: "Please read terms and condition and check the box")
            return false
        }
         
        
        guard !phoneNumber.isEmpty else {
            sharedViewModel.showAlert(title: "", message: "Phone number required")
            return false
        }
        
        guard !idOrPassportNumber.isEmpty else {
            sharedViewModel.showAlert(title: "", message: "Identification required")
            return false
        }
        
        // All validations passed
        return true
    }
        
        private func prepareAccountLookUp(){
            //
            var payload = AccountLookupRequest()
            payload.deviceID = AppUtils().getDeviceID()
            payload.nationalID = self.idOrPassportNumber//"33956141"
            payload.phoneNumber = "\(selectedCountry.countryCallingCode)\(phoneNumber)" //"254798997948"
            
            self.performAccountLookUp(model: payload)
        }
      
        //MARK: - AccountLookUp
        private  func performAccountLookUp(model: AccountLookupRequest){
            AppUtils.Timber(with: "signin \(model)")
            sharedViewModel.isLoading = true
            RequestManager.ApiInstance.accountLookUp(requestBody: model) {status, message,accountLookUpResponse in
            
                DispatchQueue.main.async{
                    sharedViewModel.isLoading = false
                    if status {
                        guard let response = accountLookUpResponse else {
                            alertDialog(message: "\(message ?? "")")
                            return
                        }
                        
                        guard let status =  response.status else {
                            alertDialog(message: "\(message ?? "")")
                            return
                        }
                        
                        //00 -> Mobile Activation
                        //05-> Device verify
                        //06-> Login
                        //07-> Identification mismatch. You have 4 lookup counts left.
                        //10-> AccountLookup Failed -> Wallet creation
                        
                        if status == "00"{
                            alertDialog(message: "Mobile Activation")
                        }else if status == "05"{
                            alertDialog(message: "Device verification")
                            //navigateToDeviceVerification.toggle()
                        }else if status == "06"{
                            //alertDialog(message: "Login")
                            navigateToLogin.toggle()
                        }else if status == "10"{
                            alertDialog(message: "Wallet creation")
                        }else{
                            alertDialog(message: response.message)
                        }
                       
                        
                        
                    }else{
                        alertDialog(message: "\(message ?? "")")
                    }
                }
                //
            }
        }
        //
        private func alertDialog(message:String?){
            CustomAlertDailog(title: "Info", message: message ?? "Response could not be processed", primaryText: "Ok", primaryAction: {
                
            })
        }
    
}



struct MenuWidthModifier: ViewModifier {
    let width: CGFloat
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity,alignment: .leading)
    }
}
