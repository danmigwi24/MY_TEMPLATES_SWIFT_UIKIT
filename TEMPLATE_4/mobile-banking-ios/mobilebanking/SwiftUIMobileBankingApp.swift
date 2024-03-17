//
//  SwiftUIMobileBankingApp.swift
//  MobileBanking
//
//  Created by Daniel Kimani on 06/02/2024.
//

import SwiftUI
import MBCore
import UIKit
import Localize_Swift




///*
//@main
struct SwiftUIMobileBankingApp: App{
    
    //@UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    //
    @Environment(\.scenePhase) private var scenePhase //SIMILER TO SCENE DELEGATE IN UIKIT
    
    //
    @StateObject var sharedViewModel = SharedViewModel()
    @StateObject var sheetNavigationViewModel = SheetNavigationViewModel()
    
    //
    @State private var needToLogout =  false
    //
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationView{
                    SplashScreen()
                    /*
                    if needToLogout == true{
                       Text("1")
                    }else{
                        Text("2")
                    }
                     */
                    
                }
            }
            .background(Color.white)
            .frame(
                maxWidth: UIScreen.main.bounds.width,
                maxHeight: UIScreen.main.bounds.height
            )
            
            .onTapGesture {
                print("MAIN TOUCH")
                self.needToLogout = false
                appDelegate.resetIdleTimer()
            }
            .onAppear(){
                appDelegate.resetIdleTimer()
                getCurrentLanguage()
            }
            .preferredColorScheme(.light)
            .environmentObject(sheetNavigationViewModel)
            .environment(\.locale, Locale.init(identifier: getUserData(key: USERDEFAULTS.USER_LANGUAGE) ))
            .onChange(of: scenePhase) { newScenePhase in
                switch newScenePhase {
                case .active:
                    // Handle app becoming active
                    print("Handle app becoming active")
                    break
                case .inactive:
                    // Handle app going into background
                    print("Handle app going into background")
                    break
                case .background:
                    // Handle app going into background
                    print("Handle app going into background")
                    break
                @unknown default:
                    // Handle any future cases
                    print("Handle any future cases")
                    break
                }
            }
            .onOpenURL { url in
                if url.absoluteString.contains("test") {
                    // toggle state to navigate to today screen
                    print("Handle [url.absoluteString.contains(test)]")
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: .appTimeOut)) { _ in
                // Handle app timeout
                print("App Timeout")
                self.needToLogout = true
                //appDelegate.resetIdleTimer()
            }
        }
        
    }
    
    
    
}
//*/


struct NavView: View {
    var body: some View {
        GeometryReader { reader in
            NavigationView{
                //
                SplashScreen()
                //
                //HomeMainScreen()
            }.background(Color.white)
                .task {
                    
                }
                .onAppear(){
                    getCurrentLanguage()
                }
            
        }
        .frame(
            maxWidth: UIScreen.main.bounds.width,
            maxHeight: UIScreen.main.bounds.height
        )
    }
    
    
    
}




struct StatusBarStyleModifier: ViewModifier {
    var style: UIStatusBarStyle
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                let appearance = UINavigationBarAppearance()
                appearance.configureWithTransparentBackground()
                appearance.backgroundColor = .clear
                
                UINavigationBar.appearance().scrollEdgeAppearance = appearance
                UINavigationBar.appearance().standardAppearance = appearance
                UINavigationBar.appearance().compactAppearance = appearance
                
                UIApplication.shared.windows.first?.rootViewController?.setNeedsStatusBarAppearanceUpdate()
            }
    }
}



extension View {
    func statusBarStyle(_ style: UIStatusBarStyle) -> some View {
        self.modifier(StatusBarStyleModifier(style: style))
    }
}


