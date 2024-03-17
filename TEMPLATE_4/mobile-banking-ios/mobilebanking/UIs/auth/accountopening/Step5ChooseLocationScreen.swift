//
//  Step5ChooseLocationScreen.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 13/02/2024.
//
import Foundation
import SwiftUI
import MBCore

import CoreLocation
import CustomHalfSheet


struct Step5ChooseLocationScreenScreen_Previews: PreviewProvider {
    static var previews: some View {
        Step5ChooseLocationScreen()
    }
}


struct Step5ChooseLocationScreen: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var navigateTo:Bool = false
    //
    @State private var showDialog:Bool = false
    //
    @State private var searchText: String = ""
    
    @State private var isShowingHalfASheet = false
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
extension Step5ChooseLocationScreen {
    
    //MARK: SET UP UI
    @ViewBuilder
    func MainContent() -> some View {
        VStack(spacing: 0){
            GeometryReader { geometry in
                //
                LoadingView(isShowing: self.$sharedViewModel.isLoading) {
                    SetUpUI(geometry: geometry)
                        .frame(width: geometry.size.width,height: geometry.size.height)
                         
                    
                    //
                }
                
            }
            
        }.background(Color.white)
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
        .navigationBarTitle("Choose Location",displayMode: .inline)
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
                    // Action to perform when the "Next" button is tapped
                    self.navigateTo.toggle()
                }, label: {
                    Text("save")
                        .foregroundColor(Color.blue)
                })
            }
        }
        
    }
    
}


/**
 *VIEW EXTEXTIONS*
 */
extension Step5ChooseLocationScreen {
    
    
    //MARK: SET UP UI
    @ViewBuilder
    func SetUpUI(geometry:GeometryProxy) -> some View {
        ZStack(){
            NavigationLink("", destination: Step5AccountOpeningScreen(), isActive: $navigateTo).opacity(0)
            VStack(spacing: 0){
                //HeaderSection(geometry: geometry)//.frame(minHeight: geometry.size.height * 0.2)
                //
               
                //
                ContentView(geometry: geometry)
                    .frame(maxWidth: .infinity,alignment: .center)
                //.frame(height: UIScreen.main.bounds.height * 0.8)
                    .frame(minHeight: geometry.size.height )
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
                    HStack{
                        CustomTextSemiBold(
                            text: "Place the pin on the street address of your premises",
                            textColor: Color(hexString: CustomColors.darkBlue),
                            fontSize: 14,
                            textAlignment: TextAlignment.leading
                        ).vSpacingWithMaxWidth(.leading)
                        Spacer()
                        Button(action: {
                            isShowingHalfASheet.toggle()
                        }, label: {
                            Image(systemName: "xmark")
                                .foregroundColor(Color(hexString: CustomColors.darkBlue))
                        })
                    }.vSpacingWithMaxWidth(.leading)
                    
                    CustomTextRegular(
                        text: "If the location is not correct move on the map to place It on the correct building",
                        textColor: Color(hexString: CustomColors.darkBlue),
                        fontSize: 12,
                        textAlignment: TextAlignment.leading
                    ).vSpacingWithMaxWidth(.leading)
                    
                }
                .padding(5)
            }
            // Customise by editing these.
            .height(.proportional(0.20))
            .closeButtonColor(UIColor.white)
            .backgroundColor(.white)
            .contentInsets(EdgeInsets(top: 5, leading: 10, bottom: 20, trailing: 10))
            
        }
    }
    
    @ViewBuilder
    func HeaderSection(geometry:GeometryProxy) -> some View {
        ZStack(){
            VStack(spacing: 0){
                HStack{
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "arrow.backward")
                            .resizable()
                            .frame(width: 18,height: 15)
                            .scaledToFit()
                            .foregroundColor(.white)
                        
                        
                    })
                    
                    CustomTextSemiBold(
                        text: "Choose Location",
                        textColor: .white,
                        fontSize: 16,
                        textAlignment: TextAlignment.leading
                    ).vSpacingWithMaxWidth(.leading)
                    
                    Button(action: {
                        isShowingHalfASheet.toggle()
                    }, label: {
                        CustomTextSemiBold(
                            text: "Save",
                            textColor: .white,
                            fontSize: 16,
                            textAlignment: TextAlignment.trailing
                        ).vSpacingWithMaxWidth(.trailing)
                    })
                }
                .vSpacingWithMaxWidth(.leading)
                //
                SearchSection(geometry: geometry)
            }.padding(16)
        }.background( Color(hexString: CustomColors.darkBlue))
    }
    
    
    //MARK: SEARCH
    @ViewBuilder
    func SearchSection(geometry:GeometryProxy) -> some View {
        VStack {
            HStack {
                Button(action: {}) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color(hexString:CustomColors.black))
                            .font(.headline)
                        
                        TextField("Search street, town etc", text: $searchText)
                            .foregroundColor(Color(hexString: CustomColors.black))
                            .font(.custom(CustomFontNames.NunitoSans_Bold, size: 16).weight(.bold))
                            .hSpacing(.leading)
                            .multilineTextAlignment(.leading)
                    }
                }
                .padding(.vertical, 15)
                .padding(.horizontal, 5)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(hexString:CustomColors.white))
                )
            }
        }
    }
    
    @ViewBuilder
    func ContentView(geometry:GeometryProxy) -> some View {
        ZStack(alignment: .topLeading){
            SearchSection(geometry: geometry).padding(16)
                .zIndex(1)
            MapSection(geometry: geometry)
                .frame(maxWidth: .infinity,maxHeight: .infinity)
                //.offset(y: -20)
                .edgesIgnoringSafeArea(.bottom)
        }
        
    }
    
    //MARK: MapSection
    @ViewBuilder
    func MapSection(geometry:GeometryProxy) -> some View {
        VStack(spacing: 0){
            if let userLocation = trackUserLocationManager.location {
                MapViewSingleLocationCoordinate(
                    coordinate: CLLocationCoordinate2D(
                        latitude: userLocation.coordinate.latitude,
                        longitude: userLocation.coordinate.longitude
                    )
                ).frame(maxWidth: .infinity,maxHeight: .infinity)
                    .onAppear{
                        //location = userLocation.description
                    }
                
            } else {
                MapViewSingleLocationCoordinate(
                    coordinate:CLLocationCoordinate2D())
                .frame(maxWidth: .infinity,maxHeight: .infinity)
                
            }
        }
    }
    
}




