//
//  Step5AccountOpeningScreen.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 12/02/2024.
//

import Foundation
import SwiftUI
import MBCore

import CoreLocation



struct Step5AccountOpeningScreen_Previews: PreviewProvider {
    static var previews: some View {
        GetStartedLandingPageScreen()
    }
}


struct Step5AccountOpeningScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.dismiss) private var dismiss
    //
    @State private var navigateTo:Bool = false
    @State private var navigateToLocation:Bool = false
    //
    @State private var showDialog:Bool = false
    
    //
    //DropdownItem
    @State private var listOfDropdownItemOption:[DropdownItem] = COUNTRYPICKER.map { $0.toDropDownItems() }
    @State private var selectedDropdownItemOption:DropdownItem = COUNTRYPICKER[0].toDropDownItems()
    //DropdownItem ->
    @State private var listOfDropdownItemOptionBranch:[DropdownItem] = listOfBranchModel.map { $0.toDropDownItems() }
    @State private var selectedDropdownItemOptionBranch:DropdownItem = listOfBranchModel[0].toDropDownItems()
    //
    @State private var location:String = ""
    @State private var city:String = ""
    @State private var postalAddress:String = ""
    //
    //MARK: NEEDED FOR API
    @StateObject var sharedViewModel = SharedViewModel()
    @StateObject private var sheetNavigationViewModel = SheetNavigationViewModel()
    
  
    //
    @ObservedObject var trackUserLocationManager = TrackUserLocationManager()
    //
    var body: some View {
        MainContent()
    }
    
    
}

/**
 *VIEW EXTEXTIONS*
 */
extension Step5AccountOpeningScreen {
    
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
        .navigationBarTitle("Residence Details",displayMode: .inline)
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
            NavigationLink("", destination: Step6AccountOpeningScreen(), isActive: $navigateTo).opacity(0)
            NavigationLink("", destination: Step5ChooseLocationScreen(), isActive: $navigateToLocation).opacity(0)
            VStack(spacing: 0){
                //
                ContentView(geometry: geometry)
                //.background(Color.red)
                    .frame(maxWidth: .infinity,alignment: .center)
                    .frame(height: UIScreen.main.bounds.height * 0.8)
                    .padding(.bottom,30)
                Spacer()
                
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
                AccountOpeningTitlesView(title:"Let’s get to know you a little bit more as our Customer", description: "Please provide the details below to have us get your personal Information").padding(10)
                
                MapSection(geometry: geometry)
                InputField().padding(10)
                Spacer()
                //ButtonSection().padding(10)
                
            }
        }
    }
    
    
    //MARK: MapSection
    @ViewBuilder
    func MapSection(geometry:GeometryProxy) -> some View {
        VStack{
            if let userLocation = trackUserLocationManager.location {
                MapViewSingleLocationCoordinate(
                    coordinate: CLLocationCoordinate2D(
                        latitude: userLocation.coordinate.latitude,
                        longitude: userLocation.coordinate.longitude
                    )
                ).frame(height: geometry.size.height * 0.25)
                    .onAppear{
                        location = userLocation.description
                    }
                
            } else {
                MapViewSingleLocationCoordinate(
                    coordinate:CLLocationCoordinate2D())
                .frame(height: geometry.size.height * 0.25)
                
            }
        }
    }
    
    //
    @ViewBuilder
    func InputField() -> some View {
        VStack{
            FloatingTextFieldView(text: $location, label: "Location", placeHolder : "Eg. Lavington",rightIcon: "pinlocation" ,isSystemImageRightIcon: false,  action: {navigateToLocation.toggle()})
            CustomDropDownWithPickerView(listOfOptions: listOfDropdownItemOption, selectedItem: $selectedDropdownItemOption, label: "Country", placeHolder : "Eg. Kenya")
                .onChange(of: selectedDropdownItemOption) {  newValue in
                    print("selectedDropdownItem  \(selectedDropdownItemOption.returnedModel)")
                }
            FloatingTextFieldView(text: $city, label: "City", placeHolder : "Eg. Nairobi",  action: {} )
            FloatingTextFieldView(text: $postalAddress, label: "Postal Address", placeHolder : "Eg. 0100-12345",  action: {} )
            
            CustomDropDownWithPickerView(listOfOptions: listOfDropdownItemOptionBranch, selectedItem: $selectedDropdownItemOptionBranch, label: "Select Branch", placeHolder : "Eg. Garden City Mall")
                .onChange(of: selectedDropdownItemOption) {  newValue in
                    print("selectedDropdownItem  \(selectedDropdownItemOption.returnedModel)")
                }
        }.padding(.vertical,10)
        
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

/**
  BUSINESS LOGICS
  */
 extension Step5AccountOpeningScreen{
     
     //MARK: Validate Fields
     func validateFields() -> Bool {
         
//         guard !city.isEmpty else {
//             showCustomizedSwiftMessages(title: "Error", body:"City Required")
//             return false
//         }
         
         // All validations passed
         return true
     }
     
 }







