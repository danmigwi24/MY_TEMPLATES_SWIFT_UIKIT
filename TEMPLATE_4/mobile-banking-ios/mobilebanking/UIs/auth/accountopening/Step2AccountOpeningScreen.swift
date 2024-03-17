//
//  Step2AccountOpeningScreen.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 09/02/2024.
//

import Foundation
import SwiftUI
import MBCore

struct Step2AccountOpeningScreen: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.dismiss) private var dismiss
    //
    @State private var navigateTo:Bool = false
    //
    @State private var showDialog:Bool = false
    //
    @State private var errorPhoneNumber:Bool = false
    //
    @State private var firstName:String = ""
    @State private var middleName:String = "Kimani"
    @State private var lastName:String = "Kim"
    @State private var idNumber:String = "33986140"
    @State private var dob:String = "01/10/2001"
    @State private var gender:String = "F"
    //
    @State private var imageFrontId: UIImage?
    @State private var imageBackId: UIImage?
    //
    @State private var showFrontImagePickerActionSheet: Bool = false
    @State private var showBackImagePickerActionSheet: Bool = false
    @State private var showImagePickerFront: Bool = false
    @State private var showImagePickerBack: Bool = false
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
extension Step2AccountOpeningScreen {
    
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
        .navigationBarTitle("Enter Details Manualy",displayMode: .inline)
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
                    /*
                    if validateFieldsT(){
                        self.navigateTo.toggle()
                    }
                    */
                    
                    if validateFields(){
                        savePersonalDetailsModel()
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
            NavigationLink("", destination: Step2SelfieAccountOpeningScreen(), isActive: $navigateTo).opacity(0)
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
                
                AccountOpeningTitlesView(title:"Enter Your National Identification Details Here", description: "Capture your national Id photos and details before proceeding !")
                
                HStack{
                    //
                    Button(action: {
                        self.showFrontImagePickerActionSheet.toggle()
                    }, label: {
                        
                        CardWithOverLayView(title: "Take Front Id Image", image: imageFrontId) {
                            self.showFrontImagePickerActionSheet.toggle()
                        }
                    })
                    .actionSheet(isPresented: $showFrontImagePickerActionSheet) {
                        ActionSheet(title: Text("Select Photo"), message: Text("Choose"), buttons: [
                            .default(Text("Photo Library")) {
                                self.showImagePickerFront = true
                                self.sourceType = .photoLibrary
                            },
                            .default(Text("Camera")) {
                                self.showImagePickerFront = true
                                self.sourceType = .camera
                            },
                            .cancel()
                        ])
                    }
                    .sheet(isPresented: $showImagePickerFront) {
                        ImagePicker(
                            image: self.$imageFrontId,
                            isShown: self.$showImagePickerFront,
                            sourceType: self.sourceType
                        )
                    }
                    //
                    Spacer()
                    Button(action: {
                        self.showBackImagePickerActionSheet.toggle()
                    }, label: {
                        CardWithOverLayView(title: "Take Back Id Image", image: imageBackId) {
                            self.showBackImagePickerActionSheet.toggle()
                        }
                    })
                    .actionSheet(isPresented: $showBackImagePickerActionSheet) {
                        ActionSheet(title: Text("Select Photo"), message: Text("Choose"), buttons: [
                            .default(Text("Photo Library")) {
                                self.showImagePickerBack = true
                                self.sourceType = .photoLibrary
                            },
                            .default(Text("Camera")) {
                                self.showImagePickerBack = true
                                self.sourceType = .camera
                            },
                            .cancel()
                        ])
                    }
                    .sheet(isPresented: $showImagePickerBack) {
                        ImagePicker(
                            image: self.$imageBackId,
                            isShown: self.$showImagePickerBack,
                            sourceType: self.sourceType
                        )
                    }
                }.padding(.bottom,10)
                
               InputField()
                //InputFieldWithEGT()
                
            }
            .padding(10)
            
        }.frame(maxWidth: .infinity,alignment: .leading)
    }
    
    //
    @ViewBuilder
    func InputField() -> some View {
        VStack{
            
            FloatingTextFieldView(text: $firstName, label: "First Name", placeHolder : "Eg. John",  action: {} )
            FloatingTextFieldView(text: $middleName, label: "Middle Name", placeHolder : "Eg. John" ,  action: {})
            FloatingTextFieldView(text: $lastName, label: "Last Name", placeHolder : "Eg. Carl" ,  action: {})
            FloatingTextFieldView(text: $idNumber, label: "ID Number", placeHolder : "Eg. 12345678" ,  action: {})
            //
            HStack(spacing:0){
                CustomDatePickerTextFieldView(selectedDate: $selectedDate, dob: $dob)
                    .vSpacingWithMaxWidth(.leading)
                Spacer()
                GenderSelectionView(gender: $gender)
                    .vSpacingWithMaxWidth(.leading)
                
            }
            
        }.padding(.vertical,10)
            .alert(isPresented: $sharedViewModel.showAlert){
                CustomAlert(
                    isPresented: $sharedViewModel.showAlert,
                    title: "Info",
                    decription: sharedViewModel.alertMessage
                )
            }
        
    }
   
    @ViewBuilder
    func ButtonSection() -> some View {
        VStack{
            Button(action: {
                
            }, label: {
                CustomTextSemiBold(text: "Re-scan ID", textColor: Color(hexString: CustomColors.blue), fontSize: 14, textAlignment: .leading)
                
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
extension Step2AccountOpeningScreen{
    
    private func onAppearConfig(){
        populateUserDataIfisEditing()
    }
    
    private func populateUserDataIfisEditing(){
        guard let personalDetails = accountOpeningViewModel.findDataByID(id: 1) else{
            print("Failed to load user with 1")
            return
        }
        //
        print("Step2AccountOpeningScreen => USER DATA \(personalDetails)")
        //
        if getUserDataBool(key: USERDEFAULTS.IS_EDITING_USER_DATA){
            
            self.firstName =  personalDetails.firstName ?? ""
            self.lastName =  personalDetails.lastName ?? ""
            self.middleName =  personalDetails.middleName ?? ""
            self.idNumber =  personalDetails.idNumber ?? ""
            self.gender =  personalDetails.gender ?? ""
        }
    }
    
    private func savePersonalDetailsModel() {
        let personalData = PersonalDetailsModel()
        personalData.firstName = self.firstName
        personalData.lastName = self.lastName
        personalData.middleName = self.middleName
        personalData.idNumber = self.idNumber
        personalData.gender = self.gender
        personalData.dob = self.dob
        
        accountOpeningViewModel.addPersonalDetails(item: personalData)
        //
        self.saveUserIDPhotos()
        //Navigation
        self.navigateTo.toggle()
    }
    
    
    private func saveUserIDPhotos(){
        if let imageData = self.imageFrontId?.jpegData(compressionQuality: 1.0) {
            UserDefaults.standard.set(imageData, forKey: USERDEFAULTS.ID_FRONT_IMAGE)
        }
        
        if let imageData = self.imageBackId?.jpegData(compressionQuality: 1.0) {
            UserDefaults.standard.set(imageData, forKey: USERDEFAULTS.ID_BACK_IMAGE)
        }
    }
    
    
    //MARK: Validate Fields
    func validateFields() -> Bool {
        
        guard !firstName.isEmpty else {
            //sharedViewModel.showAlert(message: "Firstname required")
            errorPhoneNumber.toggle()
            showCustomizedSwiftMessages(title: "Error", body:  "Firstname required")
            return false
        }
        
        guard !middleName.isEmpty else {
            //sharedViewModel.showAlert(message: "Middle required")
            showCustomizedSwiftMessages(title: "Error", body:  "Middle required")
            return false
        }
        
        guard !lastName.isEmpty else {
            //sharedViewModel.showAlert(message: "Lastname required")
            showCustomizedSwiftMessages(title: "Error", body:  "Lastname required")
            return false
        }
        
        guard !idNumber.isEmpty else {
            //sharedViewModel.showAlert(message: "ID number required")
            showCustomizedSwiftMessages(title: "Error", body:  "ID number required")
            return false
        }
        
        guard !gender.isEmpty else {
            //sharedViewModel.showAlert(message: "Date of birth required")
            showCustomizedSwiftMessages(title: "Error", body:  "Date of birth required")
            return false
        }
        
        guard !dob.isEmpty else {
           // showCustomizedSwiftMessages(title: "Error", body:"Date of birth required")
            showCustomizedSwiftMessages(title: "Error", body: "Date of birth required")
            return false
        }
        
        guard (imageFrontId != nil) else {
            showCustomizedSwiftMessages(title: "Error", body: "Front id image required")
            return false
        }
        
        guard (imageBackId != nil) else {
            showCustomizedSwiftMessages(title: "Error", body: "Back id image required")
            return false
        }
        
        // All validations passed
        return true
    }
    
    
    func validateFieldsT() -> Bool {
        return true
    }
    
}


/**
 CARD
 */
struct CardWithOverLayView : View {
    var title : String
    // var image : String
    var image: UIImage?
    var action : () -> ()
    
    var body: some View{
        Button(action: action) {
            VStack {
                //Image( "\(image)")
                if let image = image  {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 60,height: 55)
                        .scaledToFit()
                        .padding(20)
                        .vSpacingWithMaxWidth()
                }else{
                    Image("add-photo")
                        .resizable()
                        .frame(width: 60,height: 55)
                        .scaledToFit()
                        .padding(20)
                        .vSpacingWithMaxWidth()
                }
                
                Text("\(title)")
                    .font(.custom(CustomFontNames.NunitoSans_Regular, size: 14))
                    .foregroundColor(Color(hexString: CustomColors.darkBlue))
                    .lineLimit(2)
                    .vSpacingWithMaxWidth()
            }
            .frame(maxWidth: .infinity,maxHeight :200)
            .padding(.vertical,12)
            .padding(.horizontal,12)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white.opacity(0.1))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.1), lineWidth: 1)
            )
        }
    }
}

