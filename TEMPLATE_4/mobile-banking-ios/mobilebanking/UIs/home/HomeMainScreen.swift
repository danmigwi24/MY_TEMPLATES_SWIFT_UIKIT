//
//  HomeMainScreen.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 08/02/2024.
//

import Foundation
import SwiftUI
import MBCore
import CoreLocation
import CustomHalfSheet
import SwiftUI
import SwiftUIDigitalSignature
import Localize_Swift
import Combine
import MapKit
import CodeScanner
import Kingfisher
import URLImage



struct HomeMainScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var navigateTo:Bool = false
    //
    @State private var showDialog:Bool = false
    //
    @State private var isServicesSelected = true
    @State private var isViewBalance = false
    //
    @State private var offset: CGFloat = 0
    //
    //MARK: NEEDED FOR API
    @StateObject var sharedViewModel = SharedViewModel()
    
    //
    var body: some View {
        //
        VStack{
            MainContent()
        }
        
    }
    
    
}

/**
 *VIEW EXTEXTIONS*
 */
extension HomeMainScreen {
    
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
            saveUserDataBool(key: USERDEFAULTS.IS_FIRST_TIME_INSTALL, data: false)
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
        .navigationBarTitle("Home".localized())
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
    }
    
    
}
/**
 *VIEW EXTEXTIONS*
 */
extension HomeMainScreen {
    
    //MARK: SET UP UI
    @ViewBuilder
    func SetUpUI(geometry:GeometryProxy) -> some View {
        ZStack(alignment: .top){
            NavigationLink("", destination: SplashScreen(), isActive: $navigateTo).opacity(0)
            VStack(spacing: 10){
                //
                ContentView(geometry:geometry)
                //.background(Color.red)
                    .frame(maxWidth: .infinity,alignment: .center)
                    .frame(minHeight: geometry.size.height)
                
                
            }
            
            
            /*
             *DIALOG VISIBILITY
             */
            if showDialog {
                CustomSwiftUIDialog(showDialog: $showDialog) {
                    SampleDailog(showDialog: $showDialog){
                        
                    }
                }
            }
            
        }
    }
    
    @ViewBuilder
    func ContentView(geometry:GeometryProxy) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 8) {
                AccountSection(geometry: geometry)
                
                SwitchSection(geometry: geometry)
                
                if isServicesSelected {
                    ServiceSection(geometry: geometry)
                }else{
                    OtherProductSection(geometry: geometry)
                }
            }
            .padding(.horizontal, 5)
            .padding(.top, geometry.size.height * 0.1)
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 5)
        .frame(maxWidth: .infinity)
        .overlay(
            HeaderSection(geometry: geometry)
                .background(.white),alignment: .top
        )
        
        
        
    }
    
    @ViewBuilder
    func HeaderSection(geometry:GeometryProxy) -> some View {
        VStack{
            StickyHeaderView()
                .edgesIgnoringSafeArea([.top])
        }
        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
        .offset(y: min(0, -offset))
        .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
            self.offset = value
        }
        .frame(maxHeight: geometry.size.height * 0.1)
    }
    
    
    
    func StickyHeaderView() -> some View{
        VStack{
            HStack(spacing:5){
                Image("mb_logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 70,height: 50)
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                
                
                Spacer()
                
                VStack{
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 44,height: 44)
                        .clipShape(Circle())
                        .foregroundColor(Color.gray)
                        .background {
                            
                        }
                }.background(Circle().fill(Color(hexString:CustomColors.gray).opacity(0.1)))
                
            }.padding(.horizontal,5).padding(.vertical,10)
        }
    }
    
    func AccountSection(geometry:GeometryProxy) -> some View{
        
        ///*
        //MARK: HEADER VIEW
        return  ZStack{
            VStack{
                AccountSectionItems(geometry: geometry)
            }.background(
                Image("bal_bg")
                    .resizable()
                    .frame(width: geometry.size.width)
                //.frame(height: height)
            )
            
            
        }
        //.frame(height: height)
        //.frame(maxWidth: geometry.size.width * 0.99)
    }
    
    func AccountSectionItems(geometry:GeometryProxy) -> some View {
        VStack{
            
            CustomTextSemiBold(
                text: "My Account",
                textColor: .white,
                fontSize: 18,
                textAlignment: .leading)
            .vSpacingWithMaxWidth(.leading)
            //
            ZStack{
                HStack(spacing:0){
                    //
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(hexString: CustomColors.orange)).frame(width: 5,height: 40,alignment: .center)
                    //
                    VStack{
                        //TOP
                        let maskedAcc = formatCreditCardNumber("1234123412341234")
                        HStack{
                            Image("home_icon")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 24,height: 24)
                            CustomTextSemiBold(
                                text: "Wallet Account - \(maskedAcc)",
                                textColor: Color(hexString: CustomColors.darkBlue),
                                fontSize: 16,
                                textAlignment: .leading)
                            .vSpacingWithMaxWidth(.leading)
                            
                        }
                        
                        //BALANCES
                        BalanceSection(geometry: geometry)
                        
                        //BUTTONS
                        BalanceButtonSection(geometry: geometry)
                        
                    }
                    .padding(10)
                }
                .background(
                    HStack{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.white)
                            .frame(maxWidth: .infinity)
                    }
                    //
                    //.frame(minHeight: geometry.size.height * 0.3,maxHeight: geometry.size.height * 0.35)
                )
            }
            
            CustomTextBold(
                text: "Hello \(getUserData(key:USERDEFAULTS.USER_NAME)), what would you like to do?",
                textColor: .white,
                fontSize: 18,
                textAlignment: .leading)
            .vSpacingWithMaxWidth(.leading)
            
        }.padding(.vertical,5)
    }
    //
    @ViewBuilder
    func BalanceSection(geometry:GeometryProxy) -> some View {
        VStack{
            if isViewBalance {
                VStack{
                    /*
                     let maskedAcc = formatCreditCardNumber("1234123412341234")
                     CustomTextSemiBold(
                     text: "Account No: \(maskedAcc) - KES",
                     textColor: Color(hexString: CustomColors.darkBlue),
                     fontSize: 16,
                     textAlignment: .leading)
                     .vSpacingWithMaxWidth(.leading)
                     */
                    
                    HStack{
                        
                        
                        VStack{
                            CustomTextSemiBold(
                                text: "Actual Balance",
                                textColor: Color(hexString: CustomColors.darkBlue),
                                fontSize: 16,
                                textAlignment: .center)
                            .vSpacingWithMaxWidth(.center)
                            
                            CustomTextSemiBold(
                                text: removeDecimalPlaceToWholeNumber(100000),
                                textColor: Color(hexString: CustomColors.darkBlue),
                                fontSize: 16,
                                textAlignment: .center)
                            .vSpacingWithMaxWidth(.center)
                        }
                        Spacer()
                        VStack{
                            CustomTextSemiBold(
                                text: "Available Balance",
                                textColor: Color(hexString: CustomColors.darkBlue),
                                fontSize: 16,
                                textAlignment: .center)
                            .vSpacingWithMaxWidth(.center)
                            
                            CustomTextSemiBold(
                                text: removeDecimalPlaceToWholeNumber(100000),
                                textColor: Color(hexString: CustomColors.darkBlue),
                                fontSize: 16,
                                textAlignment: .center)
                            .vSpacingWithMaxWidth(.center)
                        }
                    }
                }
            }
            else{
                BlurView()
                    .frame(maxWidth: .infinity)
                    .frame(height: 30)
            }
        }
    }
    
    //
    @ViewBuilder
    func BalanceButtonSection(geometry:GeometryProxy) -> some View{
        HStack{
            CustomButtonStroke(
                action: {
                    self.isViewBalance.toggle()
                },
                title: "View Balance",
                bgColor: Color.clear,
                textColor: Color(hexString: CustomColors.darkBlue),
                strokeColor: Color(hexString: CustomColors.darkBlue),
                strokeWidth: 1,
                paddingVertical: 4,
                cornerRadius: 20
            )
            Spacer()
            CustomButtonStroke(
                action: {},
                title: "Mini Statement",
                bgColor: Color.clear,
                textColor: Color(hexString: CustomColors.darkBlue),
                strokeColor: Color(hexString: CustomColors.darkBlue),
                strokeWidth: 1,
                paddingVertical: 4,
                cornerRadius: 20
            )
        }
        
    }
    @ViewBuilder
    func SwitchSection(geometry:GeometryProxy) -> some View {
        VStack{
            
            HStack{
                //
                CustomButtonFilled(action: {
                    isServicesSelected = true
                }, title: "Services", bgColor: isServicesSelected ? .white : .clear, textColor: .black,paddingVertical: 6)
                //
                Spacer()
                //
                CustomButtonFilled(action: {
                    isServicesSelected = false
                }, title: "Other Products", bgColor: isServicesSelected ? .clear : .white, textColor: .black,paddingVertical: 6
                )
            }
            .cornerRadius(10)
            .padding(5)
            .vSpacingWithMaxWidth()
            
        }
        .background(Color(hexString: CustomColors.lightGray))
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    func ServiceSection(geometry:GeometryProxy) -> some View {
        VStack{
            //
            HStack{
                AdsSectionView(geometry: geometry)
                    .frame(maxWidth:.infinity)
                
                Spacer()
                
                ServiceVStackedView(geometry: geometry,listOfSevices: LIST_SERVICES,isColomn: false)
            }
            //
            ServiceVStackedView(geometry: geometry,listOfSevices: LIST_SERVICES,isColomn: true)
        }
    }
    
    @ViewBuilder
    func OtherProductSection(geometry:GeometryProxy) -> some View {
        VStack{
            //
            HStack{
                AdsSectionView(geometry: geometry)
                    .frame(maxWidth:.infinity)
                
                Spacer()
                
                ServiceVStackedView(geometry: geometry,listOfSevices: LIST_OTHER_SERVICES,isColomn: false)
            }
            //
            ServiceVStackedView(geometry: geometry,listOfSevices: LIST_OTHER_SERVICES,isColomn: true)
        }
    }
}


struct AdsSectionView:View {
    //
    @State private var selectedTabAdsIndex = 0
    
    var geometry:GeometryProxy
    //
    @State var timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    
    var body: some View {
        AdsSectionFromAPI(geometry: geometry)
    }
    
    //
    @ViewBuilder
    private func AdsSectionFromAPI(geometry:GeometryProxy) -> some View {
        VStack{
            
           
            let listOfBannerDatum = listOfHomeAdsModel //
            
            if listOfBannerDatum.count != 0 {
                HStack {
                    TabView(selection: $selectedTabAdsIndex) {
                        ForEach(listOfBannerDatum, id: \.self) { item in
                            CardViewFromAPI(geometry: geometry, bannerDatum: item)
                        }
                    }
                    .padding(0)
                    .frame(minHeight: geometry.size.height * 0.2)
                    .tabViewStyle(.page)
                    .indexViewStyle(.page(backgroundDisplayMode: .automatic))
                    .onReceive(timer) { _ in
                        withAnimation {
                            // Increment the selected tab index to auto-scroll
                            selectedTabAdsIndex = (selectedTabAdsIndex + 1) % listOfHomeAdsModel.count
                            
                            Logger("TIMER FOR ADS : \(selectedTabAdsIndex)")
                        }
                    }
                }
            }else{
                CardViewFromAPI(geometry: geometry, bannerDatum: listOfHomeAdsModel[0])
            }
        }
        
    }
    
    //
    @ViewBuilder
    private func CardViewFromAPI(geometry:GeometryProxy,bannerDatum:HomeAdsModel?) -> some View {
        VStack {
            let url = URL(string: bannerDatum?.link ?? "https://picsum.photos/id/237/200/300")!
            /*
             RemoteURLImage(imageUrl: bannerDatum?.imageURL)
             */
            KFImage(url)
                .placeholder{
                    VStack{
                        Image("mb_logo")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity,maxHeight: .infinity)
                    }
                }
                .loadDiskFileSynchronously()
                .cacheMemoryOnly()
                .onProgress { receivedSize, totalSize in
                    Logger("KFImage DATA = \(totalSize)")
                }
                .onSuccess { result in
                    print("KFImage Task done for: \(result.source.url?.absoluteString ?? "")")
                }
                .onFailure { error in
                    print("KFImage Job failed: \(error.localizedDescription)")
                }
                .resizable()
            //.scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .frame(maxWidth: .infinity,maxHeight: .infinity)
                .cornerRadius(20)
            
        }
        .onTapGesture {
            guard let link  = bannerDatum?.link else {return}
            Logger("LINK DATA = \(link)")
            openURLInBroswer(link)
        }
        .cornerRadius(20)
        //.frame(maxWidth: geometry.size.width * 0.4)
        
    }
    
    //
}

//
struct ServiceVStackedView:View {
    let geometry:GeometryProxy
    let listOfSevices:[ServiceModel]
    let isColomn:Bool

    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack{
            ServiceSection(geometry: geometry)
        }
    }
    
    
    @ViewBuilder
    func ServiceSection(geometry:GeometryProxy)->some View{
        if isColomn{
            let newListOfSevices = listOfSevices.dropFirst(2)
            
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(newListOfSevices,id: \.self) { item in
                    ServiceItem(geometry: geometry,item: item)
                }
            }
        }else{
            VStack(spacing: 10){
                ForEach(0..<2,id: \.self) { index in
                    ServiceItem(geometry: geometry,item: listOfSevices[index])
                }
            }
        }
        
    }
    
    @ViewBuilder
    func ServiceItem(geometry:GeometryProxy,item:ServiceModel)->some View{
        Button(action: {
            
        }, label: {
            VStack{
                HStack{
                    //
                    VStack(spacing: 10){
                        Image("home_icon")
                            .resizable()
                            //.aspectRatio(contentMode: .fit)
                            .padding(8)
                            .frame(width: 38,height: 38,alignment: .center)
                            .foregroundColor(Color.blue)
                            
                    }.background(
                        Circle().fill(Color(hexString:CustomColors.gray).opacity(0.5))
                    )
    
                    //
                    CustomTextSemiBold(
                        text: "\(item.title)",
                        textColor: Color(hexString: CustomColors.black),
                        fontSize: 16,
                        textAlignment: .center)
                    .vSpacingWithMaxWidth(.center)
                    //
                    
                }
                .padding(.horizontal,16)
                .padding(.vertical,20)
            }
            .cornerRadius(10)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.white)
                            .shadow(color: Color(hexString: CustomColors.lightGray), radius: 10,x: 5,y: 5)
                        //.stroke(.gray, lineWidth: 1)
                    )
            )
            
        })
    }
}

#Preview {
    GeometryReader{geometry in
        AdsSectionView(geometry: geometry)
    }.frame(maxWidth: .infinity,maxHeight: .infinity)
}
