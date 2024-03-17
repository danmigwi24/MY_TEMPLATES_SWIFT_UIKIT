//
//  LocateUsScreen.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 16/02/2024.
//


import Foundation
import SwiftUI
import MBCore
import MapKit
import CoreLocation
import CustomHalfSheet


struct LocateUsScreen_Previews: PreviewProvider {
    static var previews: some View {
        LocateUsScreen()
    }
}


struct LocateUsScreen: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var navigateTo:Bool = false
    //
    @State private var showDialog:Bool = false
    //
    @State private var searchText: String = ""
    @State private var isShowingHalfASheet = true
    //
    //MARK: NEEDED FOR API
    @StateObject var sharedViewModel = SharedViewModel()
    @ObservedObject var trackUserLocationManager = TrackUserLocationManager()
    
  
    //
    var body: some View {
        MainContent()
    }
    
    
}

/**
 *VIEW EXTEXTIONS*
 */
extension LocateUsScreen {
    
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
        .navigationBarItems(
            leading: Button(action: {
                //backAction()
            }, label: {
                VStack{
                    //ADD your Header
                }
            })
        )
        .navigationBarTitle("",displayMode: .inline)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
    }
    
}
/**
 *VIEW EXTEXTIONS*
 */
extension LocateUsScreen {
    
    
    //MARK: SET UP UI
    @ViewBuilder
    func SetUpUI(geometry:GeometryProxy) -> some View {
        ZStack(){
            NavigationLink("", destination: LocateUsScreen(), isActive: $navigateTo).opacity(0)
            VStack(spacing: 0){
                HeaderSection(geometry: geometry)//.frame(minHeight: geometry.size.height * 0.2)
                //
                ContentView(geometry: geometry)
                    .frame(maxWidth: .infinity,alignment: .center)
                //.frame(height: UIScreen.main.bounds.height * 0.8)
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
                    HStack{
                        CustomTextSemiBold(
                            text: "Warwick center",
                            textColor: Color(hexString: CustomColors.darkBlue),
                            fontSize: 14,
                            textAlignment: TextAlignment.leading
                        ).vSpacingWithMaxWidth(.leading)
                        Spacer()
                        /*
                        Button(action: {
                            isShowingHalfASheet.toggle()
                        }, label: {
                            Image(systemName: "xmark")
                                .foregroundColor(Color(hexString: CustomColors.darkBlue))
                        })
                         */
                    }.vSpacingWithMaxWidth(.leading)
                    
                    CustomTextRegular(
                        text: "Warwick center",
                        textColor: Color(hexString: CustomColors.darkBlue),
                        fontSize: 12,
                        textAlignment: TextAlignment.leading
                    ).vSpacingWithMaxWidth(.leading)
                    //
                    CustomTextBold(
                        text: "4.2KM",
                        textColor: Color(hexString: CustomColors.blue),
                        fontSize: 12,
                        textAlignment: TextAlignment.leading
                    ).vSpacingWithMaxWidth(.leading)
                    
                    ButtonSection()
                }
                .padding(5)
            }
            // Customise by editing these.
            .height(.proportional(0.30))
            //.closeButtonColor(UIColor.white)
            .backgroundColor(.white)
            .contentInsets(EdgeInsets(top: 5, leading: 10, bottom: 20, trailing: 10))
            
        }
    }
    
    @ViewBuilder
    func HeaderSection(geometry:GeometryProxy) -> some View {
        ZStack(){
            VStack(spacing: 2){
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
                        text: "Locate Us",
                        textColor: .white,
                        fontSize: 16,
                        textAlignment: TextAlignment.leading
                    ).vSpacingWithMaxWidth(.leading)
                    
                    Button(action: {
                        isShowingHalfASheet.toggle()
                    }, label: {
                        CustomTextSemiBold(
                            text: "",
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
                //Button(action: {}) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color(hexString:CustomColors.black))
                        .font(.headline)
                    
                    TextField("Search branch,ATM", text: $searchText)
                        .foregroundColor(Color(hexString: CustomColors.black))
                        .font(.custom(CustomFontNames.NunitoSans_Bold, size: 16).weight(.bold))
                        .hSpacing(.leading)
                        .multilineTextAlignment(.leading)
                    
                    Menu(content: {
                        Button("Branch") {
                            // Action for Option 1
                            print("Branch")
                        }
                        Button("ATM’s") {
                            // Action for Option 2
                            print("ATM’s")
                        }
                    }, label: {
                        Image(systemName: "arrowtriangle.down")
                            .foregroundColor(Color(hexString:CustomColors.black))
                            .font(.headline)
                    })
                    
                }
                //}
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
        VStack(spacing:0){
            //MapSection(geometry: geometry)
            MapSectionDataed(geometry: geometry)
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
    
    //MARK: MAIN SECTION
    @ViewBuilder
    func MapSectionDataed(geometry:GeometryProxy) -> some View {
        //ScrollView(.vertical, showsIndicators: false){
        VStack(spacing: 0){
                if let userLocation = trackUserLocationManager.location {
                    let region = MKCoordinateRegion(
                        center:  CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude),
                        span:  MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
                    )
                    
                    LocateUsMapView(
                        region: region,
                        userLocation: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude),
                        lineCoordinatesNames: listOfLocateUs
                    )
                    
                } else{
                    let region = MKCoordinateRegion(
                        center:  CLLocationCoordinate2D(latitude: -1.282406660482146, longitude: 36.815689146920086),
                        span:  MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
                    )
                    
                    LocateUsMapView(
                        region: region,
                        userLocation: CLLocationCoordinate2D(latitude: -1.282406660482146, longitude: 36.815689146920086),
                        lineCoordinatesNames: listOfLocateUs
                    )
                }
            }
        //}
    }
    
    //
    @ViewBuilder
    func ButtonSection() -> some View {
        HStack{
            CustomButtonStroke(
                action: {
                    openMapForPlace(latitude: listOfLocateUs[0].latitude ?? 0.0, longitude: listOfLocateUs[0].latitude ?? 0.00, plabeName: listOfLocateUs[0].name)
                },
                title: "GET DIRECTIONS",
                bgColor: .white,
                textColor: Color(hexString: CustomColors.lightBlue),
                strokeColor: Color(hexString: CustomColors.lightBlue),
                strokeWidth: 2
            )
            
            CustomButtonFilled(
                action: {
                    openCall("\(listOfLocateUs[0].telephone ?? "")")
                },
                title: "CALL BRANCH",
                bgColor: Color(hexString: CustomColors.blue),
                textColor: .white
            ).vSpacingWithMaxWidth()
        }
    }
    
    
}




