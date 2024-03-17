//
//  Step3AccountOpeningScreen.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 12/02/2024.
//

import Foundation
import Foundation
import SwiftUI
import MBCore

import CustomHalfSheet
import SwiftUI
import SwiftUIDigitalSignature
import PencilKit



struct Step3AccountOpeningScreen_Previews: PreviewProvider {
    static var previews: some View {
        GetStartedLandingPageScreen()
    }
}


struct Step3AccountOpeningScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.dismiss) private var dismiss
    //
    @State private var navigateTo:Bool = false
    //
    @State private var showDialog:Bool = false
    @State private var isShowingHalfASheet = false
    
    //
    //@State private var selectedCountry: CountryModel = COUNTRYPICKER[0]
    //@State private var phoneNumber:String = ""
    @State private var taxPin:String = ""
    //@State private var email:String = ""
    
    //
    @State private var digitalSignature: UIImage? = nil
    
    //DropdownItem
    @State private var listOfNatureOfEmploymentOption:[DropdownItem] = listOfNatureOfEmploymentModel.map { $0.toDropDownItems() }
    
    @State private var selectedNatureOfEmploymentOption:DropdownItem = listOfNatureOfEmploymentModel[0].toDropDownItems()
    
    @State private var listOfDropdownItemOptionSalary:[DropdownItem] = listOfSalaryRangeModel.map { $0.toDropDownItems() }
    
    @State private var selectedDropdownItemOptionSalary:DropdownItem = listOfSalaryRangeModel[0].toDropDownItems()
    
    //MARK: NEEDED FOR API
    @StateObject var sharedViewModel = SharedViewModel()
    @StateObject private var sheetNavigationViewModel = SheetNavigationViewModel()
    //
    @ObservedObject var accountOpeningViewModel: AccountOpeningViewModel = AccountOpeningViewModel()
    //
    var body: some View {
        MainContent()
    }
    
    
}

/**
 *VIEW EXTEXTIONS*
 */
extension Step3AccountOpeningScreen {
    
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
        .navigationBarTitle("Personal Details",displayMode: .inline)
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
        }    }
    
    
    
    
    //MARK: SET UP UI
    @ViewBuilder
    func SetUpUI(geometry:GeometryProxy) -> some View {
        ZStack(){
            NavigationLink("", destination: Step4AccountOpeningScreen(), isActive: $navigateTo).opacity(0)
            VStack(){
                //
                ContentView(geometry: geometry)
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
             SheetForDigitalSignatureSection()
             }
             // Customise by editing these.
             .height(.proportional(0.70))
             //.closeButtonColor(UIColor.white)
             //.backgroundColor(.white)
             .disableDragToDismiss
             .contentInsets(EdgeInsets(top: 10, leading: 10, bottom: 20, trailing: 10))
             */
        }
    }
    
    @ViewBuilder
    func ContentView(geometry:GeometryProxy) -> some View {
        ScrollView(.vertical,showsIndicators: false) {
            VStack(spacing:0){
                
                AccountOpeningTitlesView(title:"Let’s get to know you a little bit more as our Customer", description: "Please provide the details below to have us get your personal Information")
                
                
                InputField()
                Spacer().background(Color.red)
                //ButtonSection()
                
            }.padding(10)
        }
    }
    
    //
    @ViewBuilder
    func InputField() -> some View {
        VStack{
            //
            //PhoneNumberFloatingTextFieldView(text: $phoneNumber, label: "Phone Number", placeHolder : "Eg. 712345678", selectedItem: $selectedCountry)
            //
            FloatingTextFieldView(text: $taxPin, label: "TAX PIN", placeHolder : "KRA Pin",  action: {} )
            //FloatingTextFieldView(text: $email, label: "Email Address", placeHolder : "Eg. Name@gmail.com" ,  action: {})
            CustomDropDownWithPickerView(listOfOptions: listOfNatureOfEmploymentOption, selectedItem: $selectedNatureOfEmploymentOption, label: "Nature Of Employment", placeHolder : "Eg. Salaried")
                .onChange(of: selectedNatureOfEmploymentOption) {  newValue in
                    print("selectedDropdownItem  \(selectedNatureOfEmploymentOption.returnedModel)")
                }
            CustomDropDownWithPickerView(listOfOptions: listOfDropdownItemOptionSalary, selectedItem: $selectedDropdownItemOptionSalary, label: "Salary Range", placeHolder : "Eg. 0 - 50,000" )
                .onChange(of: selectedDropdownItemOptionSalary) {  newValue in
                    print("selectedDropdownItem  \(selectedDropdownItemOptionSalary.returnedModel)")
                }
            
            DigitalSignatureSection()
                .fullScreenCover(isPresented: $isShowingHalfASheet) {
                    SheetForDigitalSignatureSection()
                }
            
            
            
            
            
        }.padding(.vertical,10)
        
    }
    
    @ViewBuilder
    func DigitalSignatureSection() -> some View {
        VStack{
            CustomTextRegular(text: "Digital Signature", textColor: .black, fontSize: 16, textAlignment: .leading).vSpacingWithMaxWidth(.leading).onTapGesture {
                isShowingHalfASheet.toggle()
            }
            
            ///*
            if let image = digitalSignature {
                Image(uiImage: image)
                    .resizable()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black,lineWidth: 1))
                    .frame(height: 150)
                    .frame(minWidth: 200,maxWidth: UIScreen.main.bounds.width)
                    .scaledToFit()
                    .onTapGesture {
                        isShowingHalfASheet.toggle()
                    }
            }else{
                Button(action: {
                    isShowingHalfASheet.toggle()
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
    func SheetForDigitalSignatureSection() -> some View {
        VStack(spacing: 0) {
            HStack{
                CustomTextBold(
                    text: "Digital Signature",
                    textColor: Color(hexString: CustomColors.darkBlue),
                    fontSize: 16,
                    textAlignment: .leading
                )
                Spacer()
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 30,height: 30)
                    .scaledToFit()
                    .foregroundColor(Color(hexString: CustomColors.darkBlue))
                    .onTapGesture {
                        self.isShowingHalfASheet.toggle()
                    }
                
            }
            .padding()
            CustomSpacer(height: 10)
            SignatureView(
                availableTabs: [.draw, .image, .type],
                onSave: { image in
                    self.digitalSignature = image
                    self.isShowingHalfASheet.toggle()
                    //
                    // Save the image with annotations
                    if let imageWithAnnotationsData = image.jpegData(compressionQuality: 1.0) {
                        UserDefaults.standard.set(imageWithAnnotationsData, forKey: USERDEFAULTS.SIGNING_IMAGE)
                        Logger("IMAGE CAPTURED",showLog: false)
                    }else{
                        Logger("IMAGE NOT CAPTURED",showLog: false)
                    }
                },
                onCancel: {
                    
                })
        }
    }
    func ButtonSection() -> some View {
        VStack{
            Button(action: {
                
            }, label: {
                HStack{
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(Color(hexString: CustomColors.darkBlue))
                        .font(.custom(CustomFontNames.NunitoSans_SemiBold, size: 16).weight(.semibold))
                    
                    CustomTextBold(
                        text: "Upload signature image",
                        textColor: Color(hexString: CustomColors.blue),
                        fontSize: 14,
                        textAlignment: .leading
                    )
                    
                }
            }).vSpacingWithMaxWidth(.leading)
            
            CustomSpacer(height: 20)
            
            
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




extension Step3AccountOpeningScreen{
    
    private func onAppearConfig(){
        populateUserDataIfisEditing()
    }
    
    private func populateUserDataIfisEditing(){
        guard let personalDetails = accountOpeningViewModel.findDataByID(id: 1) else{
            print("Failed to load user with 1")
            return
        }
        
        print("USER DATA \(personalDetails)")
        
        if getUserDataBool(key: USERDEFAULTS.IS_EDITING_USER_DATA){
            //
            self.taxPin = personalDetails.kraPin ?? ""
            //
            
        }
        
    }
    
    private func savePersonalDetailsModel() {
        guard let personalDetails = accountOpeningViewModel.findDataByID(id: 1) else{
            print("Failed to load user with 1")
            return
        }
        
        let personalData = PersonalDetailsModel()
        personalData.firstName = personalDetails.firstName
        personalData.lastName = personalDetails.lastName
        personalData.middleName = personalDetails.middleName
        personalData.idNumber = personalDetails.idNumber
        personalData.gender = personalDetails.gender
        personalData.phoneNumber = personalDetails.phoneNumber
        personalData.emailAddress = personalDetails.emailAddress
        //
        personalData.kraPin = self.taxPin
        personalData.employmentType = self.selectedNatureOfEmploymentOption.returnedModel.title
        personalData.employment = self.selectedDropdownItemOptionSalary.returnedModel.title
        //
        accountOpeningViewModel.addPersonalDetails(item: personalData)
        //Navigation
        self.navigateTo.toggle()
    }
    
    
    //MARK: Validate Fields
    func validateFields() -> Bool {
        
        //        guard !phoneNumber.isEmpty else {
        //            showCustomizedSwiftMessages(title: "Error", body:"Phone number required")
        //            return false
        //        }
        
        // All validations passed
        return true
    }
    
}
