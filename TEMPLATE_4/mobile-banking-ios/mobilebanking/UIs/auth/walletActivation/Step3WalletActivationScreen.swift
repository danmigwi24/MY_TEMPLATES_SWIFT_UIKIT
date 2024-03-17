//
//  Step3WalletActivationScreen.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 08/03/2024.
//

import Foundation
import SwiftUI
import MBCore

//
struct Step3WalletActivationScreen_Previews: PreviewProvider {
    static var previews: some View {
        Step3WalletActivationScreen()
    }
}

//
struct Step3WalletActivationScreen: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.dismiss) private var dismiss
    //
    @State private var navigateTo:Bool = false
    //
    @State private var showDialog:Bool = false
    //STEP 1
    @State private var firstName:String = ""
    @State private var middleName:String = ""
    @State private var lastName:String = ""
    @State private var idNumber:String = ""
    @State private var dob:String = ""
    @State private var gender:String = ""
    //STEP 2
    
    @State private var selectedCountry: CountryModel = COUNTRYPICKER[0]
    @State private var phoneNumber:String = "769219440"
    @State private var email:String = "dan@gmail.com"
    //
    @State private var imageFrontId: UIImage?
    @State private var imageBackId: UIImage?
    //
    @State private var imageSelfie: UIImage?
    //
    @State private var showIDImagePickerSheet: Bool = false
    @State private var showSelfieActionSheet: Bool = false
    @State private var showSelfieImagePickerSheet: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    //
    @State private var selectedDate = (Calendar.current.date(byAdding: .year,value: -10, to: Date()) ?? Date())//Date()
    //
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
extension Step3WalletActivationScreen {
    
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
        .navigationBarTitle("Identification",displayMode: .inline)
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
                    
                    if validateFields(){
                        
                        submitAction()
                        
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
            NavigationLink("", destination: DeviceVerificationScreen(whatIsVerified: 1), isActive: $navigateTo).opacity(0)
            VStack(){
                //
                ContentView(geometry:geometry)
                //.background(Color.red)
                    .frame(maxWidth: .infinity,alignment: .center)
                    .frame(minHeight: geometry.size.height * 0.8)
                
                //Spacer()
                
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
            //Form{
            
            VStack(spacing:0){
                
                AccountOpeningTitlesView(title:"You will have to capture your National ID or Passport", description: "By proceeding you will scan your ID or passport, try fitting It on to the frame within the camera to capture all details")
                
                HStack{
                    //MARK: IDs
                    Button(action: {
                        self.showIDImagePickerSheet.toggle()
                    }, label: {
                        CardWithOverLayView(title: "Take Front Id Image", image: imageFrontId) {
                            self.showIDImagePickerSheet.toggle()
                        }
                    })
                    .sheet(isPresented: $showIDImagePickerSheet) {
                        VStack{
                            
                            CustomTextBold(
                                text: "Front/Back ID",
                                textColor: Color(hexString: CustomColors.blue),
                                fontSize: 20,
                                textAlignment: .leading
                            ) .vSpacingWithMaxWidth(.leading)
                            Divider()
                            //
                            CustomTextBold(
                                text: "Front ID",
                                textColor: Color(hexString: CustomColors.blue),
                                fontSize: 18,
                                textAlignment: .leading
                            )
                            .vSpacingWithMaxWidth(.leading)
                            //
                            IDImagesSection(image: imageFrontId)
                            //
                            CustomTextBold(
                                text: "Back ID",
                                textColor: Color(hexString: CustomColors.blue),
                                fontSize: 18,
                                textAlignment: .leading
                            ).vSpacingWithMaxWidth(.leading)
                            //
                            IDImagesSection(image: imageBackId)
                            
                            Spacer()
                        }
                        .padding(20)
                    }
                    
                    //
                    Spacer()
                    //MARK: SELFIE
                    Button(action: {
                        self.showSelfieActionSheet.toggle()
                    }, label: {
                        CardWithOverLayView(title: "Tap to take a selfie", image: imageSelfie) {
                            self.showSelfieActionSheet.toggle()
                        }
                    })
                    .actionSheet(isPresented: $showSelfieActionSheet) {
                        ActionSheet(title: Text("Select Photo"), message: Text("Choose"), buttons: [
                            .default(Text("Photo Library")) {
                                self.showSelfieImagePickerSheet = true
                                self.sourceType = .photoLibrary
                            },
                            .default(Text("Camera")) {
                                self.showSelfieImagePickerSheet = true
                                self.sourceType = .camera
                            },
                            .cancel()
                        ])
                    }
                    .sheet(isPresented: $showSelfieImagePickerSheet) {
                        ImagePicker(
                            image: self.$imageSelfie,
                            isShown: self.$showSelfieImagePickerSheet,
                            sourceType: self.sourceType
                        )
                    }
                }.padding(.bottom,10)
                
                InputField()
                    .alert(isPresented: $sharedViewModel.showAlert){
                        CustomAlert(
                            isPresented: $sharedViewModel.showAlert,
                            title: "Info",
                            decription: sharedViewModel.alertMessage
                        )
                    }
                
                InputFieldWithForm()
                
            }
            .padding(10)
            
        }.frame(maxWidth: .infinity,alignment: .leading)
    }
    
    //
    @ViewBuilder
    func InputField() -> some View {
        VStack{
            VStack{
                FloatingTextFieldView(text: $firstName, label: "First Name", placeHolder : "Eg. John",  action: {} )
                FloatingTextFieldView(text: $middleName, label: "Middle Name", placeHolder : "Eg. John" ,  action: {})
                FloatingTextFieldView(text: $lastName, label: "Last Name", placeHolder : "Eg. Carl" ,  action: {})
                FloatingTextFieldView(text: $idNumber, label: "ID Number", placeHolder : "Eg. 12345678" ,  action: {})
            }//.disabled(true)
            
            //
            HStack(spacing:0){
                CustomDatePickerTextFieldView(selectedDate: $selectedDate, dob: $dob)
                    .vSpacingWithMaxWidth(.leading)
                Spacer()
                GenderSelectionView(gender: $gender)
                    .vSpacingWithMaxWidth(.leading)
                
            }//.disabled(true)
            //
            VStack{
                //
                PhoneNumberFloatingTextFieldView(text: $phoneNumber, label: "Phone Number", placeHolder : "Eg. 712345678", selectedItem: $selectedCountry)
                //
                FloatingTextFieldView(text: $email, label: "Email Address", placeHolder : "Eg. Name@gmail.com" ,  action: {})
            }
            
        }.padding(.vertical,10)
        
        
    }
    
    //
    @ViewBuilder
    func InputFieldWithForm() -> some View {
        //        Section(header: Text("")){
        Form{
            ///*
            VStack{
                CustomSpacer(height: 20)
                TextField("First Name",text: $firstName).padding(.vertical,10)
                Divider()
                TextField("Middle Name" ,text: $middleName).padding(.vertical,10)
                Divider()
                TextField("Last Name",text: $lastName).padding(.vertical,10)
                Divider()
                TextField("ID Number",text: $idNumber).padding(.vertical,10)
                Divider()
            }
            .disableAutocorrection(true)
            // .textFieldStyle(.roundedBorder)
            //*/
        }
        
    }
    
    //
    @ViewBuilder
    func IDImagesSection(image: UIImage?) -> some View {
        VStack{
            if let image = image  {
                Image(uiImage: image)
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .frame(height: 155)
                    .scaledToFit()
                    .vSpacingWithMaxWidth()
            }else{
                Image("add-photo")
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .frame(height: 155)
                    .scaledToFit()
                    .vSpacingWithMaxWidth()
            }
        }
    }
    //
    @ViewBuilder
    func ButtonSection() -> some View {
        VStack{
            Button(action: {
                
            }, label: {
                CustomTextBold(
                    text: "Re-scan ID",
                    textColor: Color(hexString: CustomColors.blue),
                    fontSize: 14,
                    textAlignment: .leading
                )
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
//
extension Step3WalletActivationScreen{
    
    private func onAppearConfig(){
        populateUserDataIfisEditing()
        populateUserIDImages()
    }
    //
    private func populateUserIDImages(){
        if let imageData = UserDefaults.standard.data(forKey: USERDEFAULTS.ID_FRONT_IMAGE) {
            if let loadedImage = UIImage(data: imageData) {
                // Use loadedImage as your UIImage
                self.imageFrontId = loadedImage
            }
        }
        
        if let imageData = UserDefaults.standard.data(forKey: USERDEFAULTS.ID_BACK_IMAGE) {
            if let loadedImage = UIImage(data: imageData) {
                // Use loadedImage as your UIImage
                self.imageBackId = loadedImage
            }
        }
    }
    //
    private func populateUserDataIfisEditing(){
        guard let personalDetails = accountOpeningViewModel.findDataByID(id: 1) else{
            print("Failed to load user with 1")
            return
        }
        //
        print("[Step3WalletActivationScreen ]USER DATA \(personalDetails)")
        //
        //if getUserDataBool(key: USERDEFAULTS.IS_EDITING_USER_DATA){
        
        self.firstName =  personalDetails.firstName ?? ""
        self.lastName =  personalDetails.lastName ?? ""
        self.middleName =  personalDetails.middleName ?? ""
        self.idNumber =  personalDetails.idNumber ?? ""
        self.gender =  personalDetails.gender ?? ""
        self.dob =  personalDetails.dob ?? ""
        //}
        
        dob = formatDateFromyyyyMMddTHHmmssToyyyyMMdd(self.dob) ?? ""
        
        //
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let convertedDate = dateFormatter.date(from: dob) {
            self.selectedDate = convertedDate
        }
        //
    }
    //
    private func savePersonalDetailsModel() {
        let personalData = PersonalDetailsModel()
        personalData.firstName = self.firstName
        personalData.lastName = self.lastName
        personalData.middleName = self.middleName
        personalData.idNumber = self.idNumber
        personalData.gender = self.gender
        personalData.dob = self.dob
        //
        personalData.phoneNumber = "\(self.selectedCountry.countryCallingCode)\(self.phoneNumber)"
        personalData.emailAddress = self.email
        
        accountOpeningViewModel.addPersonalDetails(item: personalData)
        //
        saveUserSelfiePhoto()
        
        saveUserData(key: USERDEFAULTS.USER_PHONENUMBER, data: "\(self.selectedCountry.countryCallingCode)\(self.phoneNumber)")
        
    }
    
    //
    private func saveUserSelfiePhoto(){
        if let imageData = self.imageFrontId?.jpegData(compressionQuality: 1.0) {
            UserDefaults.standard.set(imageData, forKey: USERDEFAULTS.SELFIE_IMAGE)
        }
    }
    
    private func submitAction(){
        savePersonalDetailsModel()
        prepareRequest()
    }
    
    private func submitActionMock(){
        sharedViewModel.isLoading = true
        savePersonalDetailsModel()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            sharedViewModel.isLoading = false
            //Navigation
            self.navigateTo.toggle()
            
        }
    }
    
    //MARK: Validate Fields
    func validateFields() -> Bool {
        
        guard !firstName.isEmpty else {
            showCustomizedSwiftMessages(title: "Error", body:"Firstname required")
            return false
        }
        
        guard !middleName.isEmpty else {
            showCustomizedSwiftMessages(title: "Error", body:"Middle required")
            return false
        }
        
        guard !lastName.isEmpty else {
            showCustomizedSwiftMessages(title: "Error", body:"Lastname required")
            return false
        }
        
        guard !idNumber.isEmpty else {
            showCustomizedSwiftMessages(title: "Error", body:"ID number required")
            return false
        }
        
        guard !gender.isEmpty else {
            showCustomizedSwiftMessages(title: "Error", body:"Gender required")
            return false
        }
        
        guard !dob.isEmpty else {
            showCustomizedSwiftMessages(title: "Error", body:"Date of birth required")
            return false
        }
        
        guard !phoneNumber.isEmpty else {
            showCustomizedSwiftMessages(title: "Error", body:"Phone number required")
            return false
        }
        
        guard isValidEmail(email: email) else {
            showCustomizedSwiftMessages(title: "Error", body:"Email required")
            return false
        }
        
        guard (imageSelfie != nil) else {
            showCustomizedSwiftMessages(title: "Error", body: "Selfie image required")
            return false
        }
        
        // All validations passed
        return true
    }
    
    
    
    
    private func prepareRequest(){
        //
        var payload = AccountWalletActivationRequest()
        payload.name = "\(self.firstName) \(self.middleName) \(self.lastName)"
        payload.phoneNumber = "\(selectedCountry.countryCallingCode)\(phoneNumber)" //"254798997948"
        payload.email = "\(self.email)"
        payload.identification = "\(self.idNumber)"
        payload.identificationType = "National Id"
        payload.language = "English"//"\(getUserData(key: USERDEFAULTS.USER_LANGUAGE))"
        payload.geoLocation = ""
        payload.userAgent = DEFAULT_CHANNEL_DETAILS.userAgent
        payload.channel = DEFAULT_CHANNEL_DETAILS.channel
        payload.userAgentVersion = DEFAULT_CHANNEL_DETAILS.userAgentVersion
        payload.nationalID = "\(self.idNumber)"
        //
       // payload.deviceId = DEFAULT_CHANNEL_DETAILS.deviceID
        payload.dob = "\(self.dob)"
        payload.gender = "\(self.gender)"
        
        
        self.performRequest(model: payload)
    }
    
    //MARK: - AccountLookUp
    private  func performRequest(model: AccountWalletActivationRequest){
        AppUtils.Timber(with: "accountWalletActivation \(model)")
        sharedViewModel.isLoading = true
        RequestManager.ApiInstance.accountWalletActivation(requestBody: model) {status, message,responseModel in
            
            DispatchQueue.main.async{
                sharedViewModel.isLoading = false
                
                if status {
                    guard let response = responseModel else {
                        alertDialog(title:"Failed",message: "\(message ?? "")")
                        return
                    }
                    
                    guard let status =  response.status else {
                        alertDialog(title:"Failed",message: "\(message ?? "")")
                        return
                    }
                    
                    //00 -> Mobile Activation
                    //05-> Device verify
                    //06-> Login
                    //07-> Identification mismatch. You have 4 lookup counts left.
                    //10-> AccountLookup Failed -> Wallet creation
                    
                    if status == "00"{
                        self.navigateTo.toggle()
                        saveUserDataBool(key: USERDEFAULTS.IS_FIRST_TIME_INSTALL, data: false)
                    }else{
                        alertDialog(title: "Failed",message: response.message)
                        //self.navigateTo.toggle()
                    }
                    
                    
                    
                }else{
                    alertDialog(title: "Failed",message: "\(message ?? "")")
                }
            }
            //
        }
    }
    //
    private func alertDialog(title:String,message:String?){
        //sharedViewModel.showAlert(message: message ?? "Response could not be processed")
        
        showCustomizedSwiftMessages(title: title, body: message ?? "Response could not be processed",isError: true,dismissAfter: 2000000)
    }
}
