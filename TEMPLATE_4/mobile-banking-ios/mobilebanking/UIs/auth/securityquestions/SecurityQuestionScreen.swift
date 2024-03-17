//
//  SecurityQuestionScreen.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 19/02/2024.
//

import Foundation
import SwiftUI
import MBCore
import CoreLocation
import CustomHalfSheet
import SwiftUI
import SwiftUIDigitalSignature
import Localize_Swift

struct SecurityQuestionScreen_Previews: PreviewProvider {
    static var previews: some View {
        SecurityQuestionScreen()
    }
}


struct SecurityQuestionScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var navigateTo:Bool = false
    //
    @State private var showDialog:Bool = false
    @State private var isShowingHalfASheet = false
    //
    @State private var answerToQuestion1:String = ""
    @State private var answerToQuestion2:String = ""
    @State private var answerToQuestion3:String = ""
    //
    @State private var listOfDropdownItemOption:[DropdownItem] = listOfQuestionsDatum.map { $0.toDropDownItems()}

    @State private var selectedQuestion1:DropdownItem = listOfQuestionsDatum[0].toDropDownItems()
    @State private var selectedQuestion2:DropdownItem = listOfQuestionsDatum[0].toDropDownItems()
    @State private var selectedQuestion3:DropdownItem = listOfQuestionsDatum[0].toDropDownItems()
    //
    @State private var digitalSignature: UIImage? = nil
    //
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
extension SecurityQuestionScreen {
    
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
        .alert(isPresented: $sharedViewModel.showAlert){
            CustomAlert(
                isPresented: $sharedViewModel.showAlert,
                title: "Info",
                decription: sharedViewModel.alertMessage
            )
        }
        /*
        .actionSheet(isPresented: self.$sharedViewModel.showActionSheet) {
            CustomActionSheet(
                isPresented: $sharedViewModel.showActionSheet,
                title: "Info",
                decription: sharedViewModel.actionSheetMessage
            )
        }
        */
        .task {
            performGetQuestionsRequest()
        }
        .navigationBarTitle("Security Questions".localized(),displayMode: .inline)
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                ///*
                Button(action: {
                    // Action to perform when the "Next" button is tapped
                    if validateFields(){
                     //submitAction()
                        performSetQuestionsRequest()
                    }
                }, label: {
                    Text("Submit")
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
extension SecurityQuestionScreen {
    
    //MARK: SET UP UI
    @ViewBuilder
    func SetUpUI(geometry:GeometryProxy) -> some View {
        ZStack(alignment: .top){
            NavigationLink("", destination: LoginScreen(), isActive: $navigateTo).opacity(0)
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
        //ScrollView(.vertical,showsIndicators: false) {
            VStack(spacing:0){
                TitleAndDescriptionView(
                    title: "Give answers to the following questions",
                    description: "Answer the following questions with the answers you gave during registration",
                    descriptionColor: Color(hexString: CustomColors.darkBlue)
                )
                
                CustomDropDownFieldQuestion1()
                CustomDropDownFieldQuestion2()
                CustomDropDownFieldQuestion3()
                
                Spacer()
                //ButtonSection()
            }.padding(.horizontal,8)
                .frame(minHeight: geometry.size.height * 0.8)
       // } .frame(minHeight: geometry.size.height * 0.8)
    }
    
    //
    @ViewBuilder
    func CustomDropDownFieldQuestion1() -> some View {
        VStack{
            VStack{
                CustomDropDownWithPickerView(
                    listOfOptions: listOfDropdownItemOption,
                    selectedItem: $selectedQuestion1,
                    label: "Question 1",
                    placeHolder: ""
                ).onChange(of: selectedQuestion1) {  newValue in
                    print("selectedDropdownItem  \(selectedQuestion1.returnedModel)")
                }
                
            }.padding(.vertical,10)
            
            FloatingTextFieldView(text: $answerToQuestion1, label: "", placeHolder : "Give your answers here",  action: {} )
        }
        
    }
    
    @ViewBuilder
    func CustomDropDownFieldQuestion2() -> some View {
        VStack{
            VStack{
                CustomDropDownWithPickerView(
                    listOfOptions: listOfDropdownItemOption,
                    selectedItem: $selectedQuestion2,
                    label: "Question 2",
                    placeHolder: ""
                ).onChange(of: selectedQuestion2) {  newValue in
                    print("selectedDropdownItem  \(selectedQuestion2.returnedModel)")
                    
                    guard selectedQuestion2.returnedModel.id != selectedQuestion2.returnedModel.id else {
                        showCustomizedSwiftMessages(title: "Error", body:"Same question selected")
                        return
                    }
                }
                
            }.padding(.vertical,10)
            
            FloatingTextFieldView(text: $answerToQuestion2, label: "", placeHolder : "Give your answers here",  action: {} )
        }
        
    }
    
    //
    @ViewBuilder
    func CustomDropDownFieldQuestion3() -> some View {
        VStack{
            VStack{
                CustomDropDownWithPickerView(
                    listOfOptions: listOfDropdownItemOption,
                    selectedItem: $selectedQuestion3,
                    label: "Question 3",
                    placeHolder: ""
                ).onChange(of: selectedQuestion3) {  newValue in
                    print("selectedDropdownItem  \(selectedQuestion3.returnedModel)")
                }
                
            }.padding(.vertical,10)
            
            FloatingTextFieldView(text: $answerToQuestion3, label: "", placeHolder : "Give your answers here",  action: {} )
        }
        
    }

    
    //
    @ViewBuilder
    func ButtonSection() -> some View {
        VStack{
            CustomButtonFilled(
                action: {
                    self.navigateTo.toggle()
                },
                title: "GLOBAL.CONTINUE".localized(),
                bgColor: Color(hexString: CustomColors.blue),
                textColor: .white
            )
        }.vSpacingWithMaxWidth()
    }
    
}

extension SecurityQuestionScreen{
    
    //MARK: Validate Fields
    func validateFields() -> Bool {
       
        guard selectedQuestion1.returnedModel.id > 0 else {
            showCustomizedSwiftMessages(title: "Error", body:"Not question selected")
            return false
        }
        
        guard !answerToQuestion1.isEmpty else {
            showCustomizedSwiftMessages(title: "Error", body:"Answer Required")
            return false
        }
        guard !answerToQuestion2.isEmpty else {
            showCustomizedSwiftMessages(title: "Error", body:"Answer Required")
            return false
        }
        guard !answerToQuestion3.isEmpty else {
            showCustomizedSwiftMessages(title: "Error", body:"Answer Required")
            return false
        }
        
        if selectedQuestion1.returnedModel.id == selectedQuestion2.returnedModel.id && selectedQuestion1.returnedModel.id == selectedQuestion3.returnedModel.id  && selectedQuestion2.returnedModel.id == selectedQuestion3.returnedModel.id  {
            showCustomizedSwiftMessages(title: "Error", body:"Same question selected")
            return false
        }
       
        // All validations passed
        return true
    }
    
    private func submitAction(){
        sharedViewModel.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            sharedViewModel.isLoading = false
            self.navigateTo.toggle()
        }
    }
    
    
    //MARK: - GetQuestions Request
    private  func performGetQuestionsRequest(){
        let model = GetSecurityQuestionRequest()
        AppUtils.Timber(with: "API REQUEST \(model)")
        
        sharedViewModel.isLoading = true
        RequestManager.ApiInstance.getSecurityQuestions(requestBody: model) {status, message,responseModel in
            
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
                         let listOfQuizs =  response.data
                        listOfDropdownItemOption = listOfQuizs.map { $0.toDropDownItems()}
                    }else{
                        alertDialog(title: "Failed",message: response.message)
                        
                    }
                    
                    
                    
                }else{
                    alertDialog(title: "Failed",message: "\(message ?? "")")
                }
            }
            //
        }
    }
    
    //MARK: - GetQuestions Request
    private  func performSetQuestionsRequest(){
        var model:[AnsweredQuestion] = []
        let a1 = AnsweredQuestion(questionId: selectedQuestion1.returnedModel.id, answer: answerToQuestion1)
        let a2 = AnsweredQuestion(questionId: selectedQuestion2.returnedModel.id, answer: answerToQuestion2)
        let a3 = AnsweredQuestion(questionId: selectedQuestion3.returnedModel.id, answer: answerToQuestion3)
        model.append(a1)
        model.append(a2)
        model.append(a3)
        
        let payload = AnsweredQuestionsDto(data: model)
        
        AppUtils.Timber(with: "accountWalletActivation \(payload)")
        sharedViewModel.isLoading = true
        RequestManager.ApiInstance.setSecurityQuestions(requestBody: payload) {status, message,responseModel in
            
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
                        
                    }else{
                        alertDialog(title: "Failed",message: response.message)
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


