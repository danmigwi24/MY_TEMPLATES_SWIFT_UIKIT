//
//  SplashScreen.swift
//  MobileBanking
//
//  Created by Daniel Kimani on 07/02/2024.
//

import Foundation
import SwiftUI
import MBCore



struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}


struct SplashScreen: View {
    
    //MARK: NEEDED FOR API
    @StateObject var sharedViewModel = SharedViewModel()
    //
    @State private var navigateToGetStarted:Bool = false
    @State private var navigateToOnbooarding:Bool = false
    //
    
    var body: some View {
        MainContent()
    }
}

/**
 *VIEW EXTEXTIONS*
 */
extension SplashScreen {
    
    //MARK: SET UP UI
    @ViewBuilder
    func MainContent() -> some View {
        ZStack{
            Color(hexString: CustomColors.white).edgesIgnoringSafeArea(.all)
            VStack{
                GeometryReader { geometry in
                    //
                    //LoadingView(isShowing: self.$sharedViewModel.isLoading) {
                        SetUpUI()
                        .frame(maxWidth: geometry.size.width,maxHeight: geometry.size.height)
                    //}
                }.frame(maxWidth: .infinity,maxHeight: .infinity)
            }
        }
        .onAppear {
            
        }
        .task {
            onAppearConfig()
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
    
    
    //MARK: SET UP UI
    @ViewBuilder
    func SetUpUI() -> some View {
        ZStack{
            //
            NavigationLink("", destination: OnboardingScreen(), isActive: $navigateToOnbooarding).opacity(0)
            NavigationLink("", destination: GetStartedLandingPageScreen(), isActive: $navigateToGetStarted).opacity(0)
            //
            //NavigationLink("", destination: SecurityQuestionScreen(), isActive: $navigateToGetStarted).opacity(0)
            //
            VStack(alignment: HorizontalAlignment.center,spacing: 0){
                Spacer()
                Image("mb_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width:200,height: 150,alignment: .center)
                    .onTapGesture {
                        navigateToOnbooarding.toggle()
                    }
                
                Spacer()
                if sharedViewModel.isLoading{
                    HStack{
                        ProgressView()
                        Text("Please wait ...")
                    }.padding(20)
                }else{
                    HStack{
                        Text("")
                    }.padding(20)
                }
            }
        }
    }
    
}


extension SplashScreen{
    
    
    private func onAppearConfig(){
        //normalSplashNoHandShake()
        //
        //makeHandshakeRSA()
        checkRuntime()
    }
    
    private func normalSplashNoHandShake(){
        sharedViewModel.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            print("Delayed action executed!")
            sharedViewModel.isLoading = false
            saveUserData(key: USERDEFAULTS.USER_NAME, data: "Dan")
            //
            navigationConfig()
        }
        
    }
    
    private func checkRuntime(){
        RequestManager.ApiInstance.checkRuntime { (secure, msg) in
            DispatchQueue.main.async {
                print("Secure is=====\(secure)")
                if secure {
                    self.makeHandshakeRSA()
                }else{
                    self.notifyServiceError(msg)
                }
            }
        }
    }
    
    //
    private func makeHandshakeRSA(){
        /*
         {"sessionId":"a51e425c-3b2a-487c-940c-79f4845cad31","content":{"deviceId":"e0c3e10e-4e0f-4983-926b-c653450e914b","version":"1","timestamp":"2024-02-27"}}
         */
        
        //
        var payload = HandshakeRequest()
        //
        var content = HandshakeContent()
        content.version =  AppUtils().getAppVersion()
        content.deviceID = AppUtils().getDeviceID()
        content.timestamp = getCurrentTimestamp()
        //
        payload.sessionID = AppUtils().geneneratedSessionID()
        payload.content = content
        
        sharedViewModel.isLoading = true
        RequestManager.ApiInstance.makeHandshake(requestBody: payload){(status, message) in
            DispatchQueue.main.async {
                sharedViewModel.isLoading = false
                if status {
                    self.navigationConfig()
                }else{
                    self.notifyServiceError(message)
                    AppUtils.Timber(with: message ?? "")
                }
            }
        }
        
    }
    
 
    private func notifyServiceError(_ msg:String?){
        /*
         CustomAlertDailog(title: "", message: "We cannot reach the MobileBanking service. \nPlease try again later..", primaryText: "Try Again", primaryAction: {
         
         })
         */
        CustomAlertDailogWithCancelAndConfirm(
            title: "",
            message: "We cannot reach the MobileBanking service. \nPlease try again later..",
            secondaryTitle: "Cancel",
            primaryText: "Try Again",
            secondaryAction: {
                
            },
            primaryAction: {
                self.makeHandshakeRSA()
            })
    }
    
    
    private func navigationConfig(){
        if getUserDataBool(key: USERDEFAULTS.HAS_SEEN_ONBOARDING){
            navigateToGetStarted = true
            print("navigateToGetStarted = true")
        }else{
            navigateToOnbooarding = true
            print("navigateToOnbooarding = true")
        }
    }
    
    
    
}
