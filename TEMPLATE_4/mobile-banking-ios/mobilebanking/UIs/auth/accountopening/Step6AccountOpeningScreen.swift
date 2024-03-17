//
//  Step6AccountOpeningScreen.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 13/02/2024.
//

import Foundation
import SwiftUI
import MBCore

import CoreLocation



struct Step6AccountOpeningScreen_Previews: PreviewProvider {
    static var previews: some View {
        GetStartedLandingPageScreen()
    }
}


struct Step6AccountOpeningScreen: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.dismiss) private var dismiss
    //
    @State private var navigateTo:Bool = false
    //
    @State private var showDialog:Bool = false
    @State private var doYouWantDebitCard:Bool = true
    //
    @State private var isHomeDelivery:Bool = false
    @State private var isCollectFromBranch:Bool = true
    
    //DropdownItem
    @State private var listOfDropdownItemOption:[DropdownItem] = listOfBranchModel.map { $0.toDropDownItems() }
    @State private var selectedDropdownItemOption:DropdownItem = listOfBranchModel[0].toDropDownItems()
    //
    @State private var listOfCardBgOption:[String] = ["debit_card_1_bg","debit_card_2_bg","debit_card_3_bg","debit_card_4_bg"]
    @State private var selectedCardBgOption:String = "debit_card_1_bg"
    //
    //MARK: NEEDED FOR API
    @StateObject var sharedViewModel = SharedViewModel()
    @StateObject private var sheetNavigationViewModel = SheetNavigationViewModel()
    @ObservedObject var trackUserLocationManager = TrackUserLocationManager()
    //
    var body: some View {
        MainContent()
    }
    
    
}

/**
 *VIEW EXTEXTIONS*
 */
extension Step6AccountOpeningScreen {
    
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
            
            
            if trackUserLocationManager.location == nil {
                trackUserLocationManager.startUpdatingLocation()
            }else{
                trackUserLocationManager.requestLocation()
            }
        }
        .alert(isPresented: $sharedViewModel.showAlert){
            CustomAlert(
                isPresented: $sharedViewModel.showAlert,
                title: "Info",
                decription: sharedViewModel.alertMessage
            )
        }
        .navigationBarTitle("Debit Card",displayMode: .inline)
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
            NavigationLink("", destination: SummaryAccountOpeningScreen(), isActive: $navigateTo).opacity(0)
            VStack(spacing: 0){
                //
                ContentView(geometry: geometry)
                //.background(Color.red)
                    .frame(maxWidth: .infinity,alignment: .center)
                    .frame(minHeight: geometry.size.height * 0.8)
                
                // Spacer()
                
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
        ZStack(alignment: .topLeading){
            ScrollView(.vertical,showsIndicators: false) {
                VStack(spacing:5){
                    AccountOpeningTitlesView(title:"Let’s get to know you a little bit more as our Customer", description: "Please provide the details below to have us get your personal Information")
                    
                    WouldYouLikeADebitCardSection()
                    if doYouWantDebitCard {
                        
                        DebitCardView(imageBg: $selectedCardBgOption, cardType: "Debit Card", cardOwnerLogo: "mb_logo_card", cardNumber: "0000 0000 0000 0000 0000", cardTypeImage: "visalogo", cardHolderName: "Daniel Kimani", cardExpirlyDate: "00/00",geometry: geometry)
                            .vSpacingWithMaxWidth(.leading)
                        
                        
                        SelectCardDesignSection()
                        
                        HStack(spacing:5){
                            HomeDeliverySection()
                            
                            CollectFromBranchSection()
                        }
                        
                        CustomDropDownWithPickerView(listOfOptions: listOfDropdownItemOption, selectedItem: $selectedDropdownItemOption, label: "Branch", placeHolder: "")
                            .onChange(of: selectedDropdownItemOption) {  newValue in
                                print("selectedDropdownItem  \(selectedDropdownItemOption.returnedModel)")
                            }
                        
                        InfoDesignSection()
                    }
                    else{
                        Rectangle().fill(.clear).frame(minHeight: geometry.size.height * 0.55)
                        //Spacer()
                    }
                    
                    
                    //                    Spacer()
                    //                    ButtonSection()
                    
                }
                .padding(10)
                .frame(minHeight: geometry.size.height * 0.8)
            }
        }
    }
    
    
    
    
    //
    @ViewBuilder
    func WouldYouLikeADebitCardSection() -> some View {
        VStack{
            CustomTextBold(text: "Would You Like A Debit Card?" , textColor: .black, fontSize: 20, textAlignment: .leading).vSpacingWithMaxWidth(.leading)
            
            Toggle(isOn: $doYouWantDebitCard) {
                CustomTextBold(text: doYouWantDebitCard ? "Yes" : "No" , textColor: .black, fontSize: 14, textAlignment: .leading)
            }.toggleStyle(.switch)
                .tint(.blue)
            
            /*
             CustomDropDownWithMenuView(label: "Would You Like A Debit Card?", placeHolder: "") {
             Menu(content: {
             VStack{
             ForEach(listOfOption, id: \.self) { item in
             Button(action: {
             selectedItemOption = item
             }, label: {
             Text(item)
             })
             }
             }
             }, label: {
             HStack{
             CustomTextBold(text: selectedItemOption, textColor: .black, fontSize: 14, textAlignment: .leading)
             Spacer()
             }
             })
             }
             */
        }.padding(.vertical,10)
        
    }
    
    //
    @ViewBuilder
    func SelectCardDesignSection() -> some View {
        VStack{
            CustomTextBold(text: "Select card design", textColor: .black, fontSize: 14, textAlignment: .leading).vSpacingWithMaxWidth(.leading)
            ScrollView(.horizontal,showsIndicators: false){
                HStack{
                    ForEach(listOfCardBgOption,id: \.self){item in
                        ZStack{
                            if selectedCardBgOption == item {
                                Button(action: {
                                    selectedCardBgOption = item
                                }, label: {
                                    ZStack{
                                        Image(item)
                                            .resizable()
                                            .frame(width: 60,height: 60)
                                            .scaledToFill()
                                            .clipShape(Circle())
                                        
                                        Image(systemName: "checkmark")
                                            .foregroundColor(Color(hexString: CustomColors.blue))
                                            .clipShape(Circle())
                                            .frame(width: 60,height: 60)
                                            .background(BlurView())
                                            .clipShape(Circle())
                                        
                                    }
                                })
                            }else{
                                Button(action: {
                                    selectedCardBgOption = item
                                }, label: {
                                    Image(item)
                                        .resizable()
                                        .frame(width: 60,height: 60)
                                        .scaledToFill()
                                        .clipShape(Circle())
                                })
                            }
                        }
                    }
                    
                }.vSpacingWithMaxWidth(.leading)
            }
        }
        
    }
    
    //
    @ViewBuilder
    func HomeDeliverySection() -> some View {
        HStack{
            Image(systemName: isHomeDelivery ? "record.circle" : "circle")
                .resizable()
                .foregroundColor(isHomeDelivery ? Color(hexString: CustomColors.white): Color(hexString: CustomColors.gray))
                .frame(width: 20,height: 20)
                .scaledToFill()
            
            CustomTextBold(
                text: "Home Delivery",
                textColor: isHomeDelivery ? Color(hexString: CustomColors.white): Color(hexString: CustomColors.gray),
                fontSize: 14,
                textAlignment: .leading).vSpacingWithMaxWidth(.leading)
            
        }
        .padding(.horizontal,10)
        .padding(.vertical,15)
        .background(isHomeDelivery ? Color(hexString: CustomColors.darkBlue): Color(hexString: CustomColors.lightGray))
        .cornerRadius(5)
        .onTapGesture {
            isHomeDelivery = true
            isCollectFromBranch = false
        }
    }
    //
    @ViewBuilder
    func CollectFromBranchSection() -> some View {
        HStack{
            Image(systemName: isCollectFromBranch ? "record.circle" : "circle")
                .resizable()
                .foregroundColor(isCollectFromBranch ? Color(hexString: CustomColors.white): Color(hexString: CustomColors.gray))
                .frame(width: 20,height: 20)
                .scaledToFill()
            
            CustomTextBold(
                text: "Collect from branch",
                textColor: isCollectFromBranch ? Color(hexString: CustomColors.white): Color(hexString: CustomColors.gray),
                fontSize: 14,
                textAlignment: .leading
            ).vSpacingWithMaxWidth(.leading)
            
        }
        .padding(.horizontal,10)
        .padding(.vertical,15)
        .background(isCollectFromBranch ? Color(hexString: CustomColors.darkBlue): Color(hexString: CustomColors.lightGray))
        .cornerRadius(5)
        .onTapGesture {
            isHomeDelivery = false
            isCollectFromBranch = true
        }
    }
    
    //
    @ViewBuilder
    func InfoDesignSection() -> some View {
        HStack{
            Image("icon_debit_card_info")
                .resizable()
                .clipShape(Circle())
                .foregroundColor(Color(hexString: CustomColors.darkBlue))
                .frame(width: 30,height: 30)
                .clipShape(Circle())
                .scaledToFill()
            
            CustomTextBold(
                text: "We will deliver your debit card to the branch you Selected in the residential details",
                textColor: Color(hexString: CustomColors.gray),
                fontSize: 14,
                textAlignment: .leading
            ).vSpacingWithMaxWidth(.leading)
            
        }
        .padding(.horizontal,10)
        .padding(.vertical,15)
        .background(Color(hexString: CustomColors.lightGray))
        
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








extension Step6AccountOpeningScreen{
    
    //MARK: Validate Fields
    func validateFields() -> Bool {
        
//        guard !selectedDropdownItemOption.returnedModel.title.isEmpty else {
//            showCustomizedSwiftMessages(title: "Error", body:"Branch Required")
//            return false
//        }
        
        // All validations passed
        return true
    }
    
}
