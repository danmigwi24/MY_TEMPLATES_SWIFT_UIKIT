//
//  SummaryAccountOpeningScreen.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 14/02/2024.
//

import Foundation
import SwiftUI
import MBCore

import CoreLocation
import SwiftUI
import SwiftUIDigitalSignature

struct SummaryAccountOpeningScreen_Previews: PreviewProvider {
    static var previews: some View {
        GetStartedLandingPageScreen()
    }
}


struct SummaryAccountOpeningScreen: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.dismiss) private var dismiss
    //
    @State private var navigateTo:Bool = false
    //
    @State private var navigateToStep2:Bool = false
    @State private var navigateToStep3:Bool = false
    @State private var navigateToStep4:Bool = false
    @State private var navigateToStep5:Bool = false
    @State private var navigateToStep6:Bool = false
    //
    @State private var showDialog:Bool = false
    //
    //STEP 1
    @State private var fullName:String = "John Doe"
    // @State private var middleName:String = ""
    //@State private var lastName:String = ""
    @State private var idNumber:String = "336586997"
    @State private var dob:String = "12/20/1998"
    @State private var gender:String = "Male"
    @State private var selectedDate = (Calendar.current.date(byAdding: .year,value: -10, to: Date()) ?? Date())//Date()
    //
    //@State private var phoneNumber:String = ""
    @State private var taxPin:String = ""
    @State private var email:String = ""
    //@State private var natureOfEmployment:String = ""
    //@State private var salaryRange:String = ""
    @State private var digitalSignature: UIImage? = nil
    @State private var selectBranch:String = ""
    //
    // @State private var location:String = ""
    @State private var country:String = ""
    @State private var city:String = ""
    @State private var postalAddress:String = ""
    //
    @State private var selectedImages: [UIImage] = []
    @State private var mapImage: UIImage?
    //
    
    //MARK: NEEDED FOR API
    @StateObject var sharedViewModel = SharedViewModel()
    @EnvironmentObject var sheetNavigationViewModel: SheetNavigationViewModel
    
    //
    var body: some View {
        MainContent()
    }
    
    
}

/**
 *VIEW EXTEXTIONS*
 */
extension SummaryAccountOpeningScreen {
    
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
            onAppearConfig()
        }
        .alert(isPresented: $sharedViewModel.showAlert){
            CustomAlert(
                isPresented: $sharedViewModel.showAlert,
                title: "Info",
                decription: sharedViewModel.alertMessage
            )
        }
        .navigationBarTitle("Summary",displayMode: .inline)
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(true)
        /*
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
         */
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    if validateFields(){
                        submitAction()
                    }
                }, label: {
                    Text("Submit")
                        .foregroundColor(Color.blue)
                })
                //                .sheet(isPresented: $sheetNavigationViewModel.showAccountOpeningSheet){
                //                    NavigationView() {
                //                        //Step1AccountOpeningScreen()
                //                        DeviceVerificationScreen(whatIsVerified: 2)
                //                   }
                //                }
            }
        }
        
    }
    
    
    
    
    //MARK: SET UP UI
    @ViewBuilder
    func SetUpUI(geometry:GeometryProxy) -> some View {
        ZStack(){
            NavigationLink("", destination: Step2AccountOpeningScreen(), isActive: $navigateToStep2).opacity(0)
            NavigationLink("", destination: Step3AccountOpeningScreen(), isActive: $navigateToStep3).opacity(0)
            NavigationLink("", destination: Step4AccountOpeningScreen(), isActive: $navigateToStep4).opacity(0)
            NavigationLink("", destination: Step5AccountOpeningScreen(), isActive: $navigateToStep5).opacity(0)
            NavigationLink("", destination: Step6AccountOpeningScreen(), isActive: $navigateToStep6).opacity(0)
            //
            NavigationLink("", destination: DeviceVerificationScreen(whatIsVerified: 2),isActive: $navigateTo).opacity(0)
            
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
    
    @ViewBuilder
    func ContentView(geometry:GeometryProxy) -> some View {
        ScrollView(.vertical,showsIndicators: false) {
            VStack(spacing:0){
                AccountOpeningTitlesView(title:"Let’s get to know you a little bit more as our Customer", description: "Please provide the details below to have us get your personal Information")
                
                //
                InputField()
                PersonalDetailsInputField(geometry: geometry)
                ResidentialDetailsInputField(geometry: geometry)
                
                //ButtonSection().frame(alignment: .bottomLeading)
            }.padding(10)
        }
    }
    
    @ViewBuilder
    func SeparatorSection(title:String, action: @escaping ()->()) -> some View {
        HStack(spacing: 0){
            CustomTextBold(
                text: title,//"Identification",
                textColor: Color(hexString: CustomColors.darkBlue),
                fontSize: 16,
                textAlignment: .leading
            ).vSpacingWithMaxWidth(.leading)
            
            Spacer()
            Image("edit_pen")
                .resizable()
                .foregroundColor(Color(hexString: CustomColors.lightBlue))
                .frame(width: 24,height: 24)
                .scaledToFill()
                .onTapGesture {
                    action()
                }
        }
        //.padding(.horizontal,10)
        .padding(.vertical,15)
        .background(Color(hexString: CustomColors.white))
        
    }
    
    //
    @ViewBuilder
    func InputField() -> some View {
        VStack{
            SeparatorSection(title: "Identification", action: {navigateToStep2.toggle()})
            //
            FloatingTextFieldView(text: $fullName, label: "Full Name", placeHolder : "Eg. John",  action: {} )
            //FloatingTextFieldView(text: $middleName, label: "Middle Name", placeHolder : "Eg. John" ,  action: {})
            //FloatingTextFieldView(text: $lastName, label: "Last Name", placeHolder : "Eg. Carl" ,  action: {})
            FloatingTextFieldView(text: $idNumber, label: "ID Number", placeHolder : "Eg. 12345678" ,  action: {})
            HStack{
                FloatingTextFieldView(text: $dob, label: "Date of birth", placeHolder : "Eg. dd/mm/yyyy" ,  action: {})
                
                FloatingTextFieldView(text: $gender, label: "Gender", placeHolder : "Eg. 12345678" ,  action: {})
            }
            
        }.padding(.vertical,10)
        
    }
    
    //
    @ViewBuilder
    func PersonalDetailsInputField(geometry:GeometryProxy) -> some View {
        VStack{
            
            SeparatorSection(title: "Personal Details", action: {navigateToStep3.toggle()})
            
            //PhoneNumberFloatingTextFieldView(text: $phoneNumber, label: "Phone Number", placeHolder : "Eg. 0712345678", selectedItem: $selectedCountry )
            FloatingTextFieldView(text: $taxPin, label: "TAX PIN", placeHolder : "KRA Pin",  action: {} ).disabled(true)
            FloatingTextFieldView(text: $email, label: "Email Address", placeHolder : "Eg. Name@gmail.com" ,  action: {})
            //FloatingTextFieldView(text: $natureOfEmployment, label: "Nature Of Employment", placeHolder : "Eg. Salaried",  action: {} )
            //FloatingTextFieldView(text: $salaryRange, label: "Salary Range", placeHolder : "Eg. 0 - 50,000" ,  action: {})
            
            //
            FloatingTextFieldView(text: $postalAddress, label: "Select Branch", placeHolder : "Eg. Garden City Mall",  action: {} )
            //
            DigitalSignatureSection()
            //            CustomTextRegular(text: "Digital Signature", textColor: .black, fontSize: 16, textAlignment: .leading).vSpacingWithMaxWidth(.leading)
            //
            //            RoundedRectangle(cornerRadius: 10).stroke(Color.black,lineWidth: 1)
            //                .frame(minHeight: geometry.size.height * 0.1, maxHeight: 120)
            //                .frame(maxWidth: .infinity)
            
            
        }.padding(.vertical,10)
        
    }
    
    //
    @ViewBuilder
    func ResidentialDetailsInputField(geometry:GeometryProxy) -> some View {
        VStack{
            SeparatorSection(title: " Residential Details", action: {navigateToStep5.toggle()})
            
            //FloatingTextFieldView(text: $location, label: "Location", placeHolder : "Eg. Lavington",rightIcon: "pinlocation" ,isSystemImageRightIcon: false,  action: {})
            FloatingTextFieldView(text: $country, label: "Country", placeHolder : "Eg. Kenya",  action: {} )
            FloatingTextFieldView(text: $city, label: "City", placeHolder : "Eg. Nairobi",  action: {} )
            FloatingTextFieldView(text: $postalAddress, label: "Postal Address", placeHolder : "Eg. 0100-12345",  action: {} )
            
            
        }.padding(.vertical,10)
        
    }
    
    //
    @ViewBuilder
    func DigitalSignatureSection() -> some View {
        VStack{
            CustomTextRegular(text: "Digital Signature", textColor: .black, fontSize: 16, textAlignment: .leading).vSpacingWithMaxWidth(.leading).onTapGesture {
                
            }
            
            ///*
            if let image = digitalSignature {
                Image(uiImage: image)
                    .resizable()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black,lineWidth: 1))
                    .frame(height: 150)
                    .frame(minWidth: 200,maxWidth: UIScreen.main.bounds.width)
                    .scaledToFit()
                
            }else{
                Button(action: {
                }, label: {
                    RoundedRectangle(cornerRadius: 10).stroke(Color.black,lineWidth: 1)
                        .frame(height: 150)
                        .frame(maxWidth: .infinity)
                    
                })
                
            }
            //*/
        }
    }
    
    
    //
    @ViewBuilder
    func ButtonSection() -> some View {
        VStack{
            CustomButtonFilled(
                action: {
                    submitAction()
                    print("SUBMIT")
                },
                title: "SUBMIT",
                bgColor: Color(hexString:CustomColors.lightBlue),
                textColor: Color.white
            )
        }
    }
    
    
}



extension SummaryAccountOpeningScreen{
    
    private func onAppearConfig(){
        if let imageData = UserDefaults.standard.data(forKey: USERDEFAULTS.SIGNING_IMAGE) {
            if let loadedImage = UIImage(data: imageData) {
                // Use loadedImage as your UIImage
                digitalSignature = loadedImage
            }else{
                print("Failed to load USERDEFAULTS.SIGNING_IMAGE")
            }
        }
    }
    
    private func submitAction(){
        sharedViewModel.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            sharedViewModel.isLoading = false
            //
            navigateTo.toggle()
            //sheetNavigationViewModel.showAccountOpeningSheet = false
            //
            saveUserDataBool(key: USERDEFAULTS.HAS_FINISHED_ACCOUNT_OPENING, data: true)
            //
            
        }
    }
    
    
    func postRequest() {
        
        let request = AccountOpeningRequest()
        
        RequestManager.ApiInstance.postAccountOpeningRequestWithImages(
            requestBody: request,
            selectedImages: selectedImages ?? nil,
            mapImage:  mapImage ?? nil
        ) {  success, message in
            if success {
                dialogAlert(title: "", message: "Success")
            }else{
                dialogAlert(title: "", message: message)
            }
        }
        
    }
    
    
    //MARK: Validate Fields
    func validateFields() -> Bool {
        
        /*
         guard !fullName.isEmpty else {
         showCustomizedSwiftMessages(title: "Error", body:"FullName required")
         return false
         }
         */
        
        // All validations passed
        return true
    }
    
    private func dialogAlert(title:String?,message:String?){
        CustomAlertDailogWithCancelAndConfirm(
            title: title ??  "",
            message: message ?? "We cannot reach the MobileBanking service. \nPlease try again later..",
            secondaryTitle: "Cancel",
            primaryText: "Try Again",
            secondaryAction: {
                
            },
            primaryAction: {
                
            })
    }
    
}
