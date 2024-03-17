//
//  GetStartedLandingPageScreen.swift
//  MobileBanking
//
//  Created by Daniel Kimani on 06/02/2024.
//

import SwiftUI
import MBCore
import Localize_Swift
import Combine

struct GetStartedLandingPageScreen_Previews: PreviewProvider {
    static var previews: some View {
        GetStartedLandingPageScreen()
    }
}

struct GetStartedLandingPageScreen: View {
    //
    @State private var navigateToLogin:Bool = false
    @State private var navigateToWelcome:Bool = false
    //
    @State var languageModelOption: LanguageModel = LANGUAGEPICKER[0]
    
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
extension GetStartedLandingPageScreen {
    //MARK: SET UP UI
    @ViewBuilder
    func MainContent() -> some View {
        VStack{
            GeometryReader { geometry in
                //
                LoadingView(isShowing: self.$sharedViewModel.isLoading) {
                    SetUpUI(geometry:geometry)
                     
                    //.frame(maxWidth: .infinity,maxHeight: .infinity)
                        .frame(width: geometry.size.width,height: geometry.size.height)
                    //
                }
            }
        }
        .onAppear {
            UIApplication.shared.statusBarStyle = .darkContent
            Logger("onAppear")
            getCurrentLanguage()
        
        }
        ///*
        .onChange(of: languageModelOption, perform: { newValue in
            Logger("onChange")
            getCurrentLanguage()
        })
        .onReceive(Just(languageModelOption)) { newValue in
            Logger("onReceive")
            getCurrentLanguage()
         }
         //*/
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
    
    
    
    //MARK: SET UP UI
    @ViewBuilder
    func SetUpUI(geometry:GeometryProxy) -> some View {
        ZStack(alignment: .top){
            //
            NavigationLink("", destination: LoginScreen(), isActive: $navigateToLogin).opacity(0)
            NavigationLink("", destination: WelcomeAccountSelectionScreen(), isActive: $navigateToWelcome).opacity(0)
          
            VStack(spacing: 0){
                //Language Change
                ChangeLanguageView(languageModelOption: $languageModelOption).frame(alignment: .trailing)
                
                VStack{
                    //Logo
                    Image("mb_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width:120,height: 120)
                    
                    
                    
                    //
                    //Rectangle().fill(.clear).frame(maxHeight: geometry.size.height * 0.3)
                    Spacer()
                    
                    CustomTextSemiBold(
                        text: "GetStartedLandingPageScreen.title".localized(),
                        textColor: Color.white,
                        fontSize:22,
                        textAlignment: TextAlignment.leading
                    ).frame(maxWidth: .infinity, alignment: .leading)
                    
                    CustomButtonFilled(
                        action: {
                            withAnimation{
                                if getUserDataBool(key: USERDEFAULTS.IS_FIRST_TIME_INSTALL) {
                                    self.navigateToWelcome.toggle()
                                }else{
                                    self.navigateToLogin.toggle()
                                }
                            }
                        },
                        title: getUserDataBool(key: USERDEFAULTS.IS_FIRST_TIME_INSTALL) ? "GetStartedLandingPageScreen.getstarted".localized() : "GetStartedLandingPageScreen.login".localized(),
                        bgColor: Color(hexString: CustomColors.blue),
                        textColor:Color(hexString: CustomColors.white)
                    )
                    
                    VStack{
                        HStack(alignment: VerticalAlignment.center){
                            //
                            NavigationLink(destination: OurProductScreen()) {
                                LandingItems(image: "our_products", title: "GetStartedLandingPageScreen.our_product".localized()) {}
                            }
                            //
                            NavigationLink(destination: ForexAndStockScreen()) {
                                LandingItems(image: "ForexStocks", title: "GetStartedLandingPageScreen.forex".localized()) {}
                            }
                            //
                            NavigationLink(destination: SupportScreen()) {
                                LandingItems(image: "Support", title: "GetStartedLandingPageScreen.support".localized()) {}
                            }
                        }
                        //
                        HStack(alignment: VerticalAlignment.center){
                            //
                            NavigationLink(destination: TypesofAccountsScreen()) {
                                LandingItems(image: "OpenAccount", title: "GetStartedLandingPageScreen.open_account".localized()) {}
                            }
                            //
                            NavigationLink(destination: AboutUsScreen()) {
                                LandingItems(image: "AboutUs", title: "GetStartedLandingPageScreen.about_us".localized()) {}
                            }
                            
                            //
                            NavigationLink(destination: CalculatorScreen()) {
                                LandingItems(image: "Calculator", title: "GetStartedLandingPageScreen.calculator".localized()) {}
                            }
                        }.vSpacingWithMaxWidth()
                    }
                    
                } .padding(.vertical,30)
                    .padding(.horizontal,10)
            }
           
        }.background(
            Image("getstarted")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity,maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
        )
        
        .frame(minWidth: geometry.size.width,minHeight: geometry.size.height)
        
    }
    
    @ViewBuilder
    func LandingItems(image:String,title:String,action: ()->())->some View{
        VStack{
            
            VStack{
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24,height: 24)
                
                CustomTextMedium(
                    text: title,
                    textColor: Color.white,
                    fontSize:14,
                    textAlignment: TextAlignment.center
                )
            }.padding(5)
            RoundedRectangle(cornerRadius: 20)
            //Capsule()
                .fill(Color(hexString: CustomColors.orange))
                .frame(maxWidth: .infinity)
                .frame(height: 6)
        }
        .background(BlurView().opacity(0.4).cornerRadius(4))

    }
    
}
