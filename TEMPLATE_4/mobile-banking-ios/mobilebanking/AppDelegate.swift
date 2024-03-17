//
//  AppDelegate.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 13/02/2024.
//

//
//  Copyright (c) 2016 Google Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import UIKit
import SwiftUI
import TrustKit
import MBCore
import UserNotifications
import Localize_Swift
import IQKeyboardManagerSwift
//

//@UIApplicationMain
//@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"
    var idleTimer: Timer?
    //
    func application(_ application: UIApplication,didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //
        
        print("\nAppDelegate [ didFinishLaunchingWithOptions ]\n")
        
        print("DeviceInfo().description : \(DeviceInfo().description)")
        //
        setUpWindow()
        //
        initLocalization()
        initTrustKit()
        initIQKeyboardManager()
        initNotificationRequestAuthorization(launchOptions: launchOptions)
        initIdleToLogoutUser()
        
        return true
    }
    
    //
    func setUpWindow(){
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .blue
        self.window?.makeKeyAndVisible()
        //self.window?.rootViewController = UINavigationController(rootViewController: ViewController())
        self.window?.rootViewController = ViewController()
       // window?.rootViewController = UIHostingController(rootView:NavView())
    }
    
    //
    func applicationWillTerminate(_ application: UIApplication) {
        print("AppDelegate [ applicationWillTerminate ]")
    }
    //
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("AppDelegate [ applicationDidEnterBackground ]")
    }
    //
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("AppDelegate [APP ENTERD FOREGROUND]")
        
    }
    //METHODS FROM POSTBANK APP
    //
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        AppUtils.Log(from: self, with: "Accessing \(String(describing: url.host))")
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        print("UIApplication.willResignActiveNotification")
        resetIdleTimer()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("UIApplication.didBecomeActiveNotification")
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
   
    
}


extension AppDelegate {
    //MARK: METHODS USED
    
    //
    func  initLocalization(){
        let currentLang = getUserData(key: USERDEFAULTS.USER_LANGUAGE)
        Localize.setCurrentLanguage(currentLang)
        print("---------------------- CURRENT APP LANGUAGE IS ------------------- \(currentLang)")
        //
    }
    //
    func  initTrustKit(){
        //
        guard let url = URL(string: AppConfig.Current?.Environment?.rootURL ?? "")?.host else{
            return
        }
        
        let trustKitConfig = [
            kTSKSwizzleNetworkDelegates: false,
            kTSKPinnedDomains: [
                url: [
                    kTSKIncludeSubdomains : true,
                    kTSKPublicKeyHashes: [
                        "8FYY7NiY/QxikVfQwB6AUFDgttQhSEHU4IXjl7L9WGw=",
                        "RQeZkB42znUfsDIIFWIRiYEcKl7nHwNFwWCrnMMJbVc=",
                        "r/mIkG3eEpVdm+u/ko/cwxzOMo1bk4TyHIlByibiA5E=",
                        "SKCv3ENQHfd6/ndg8gL4JMFyhWeLyVbVkZL+ARr81jo="
                    ],]]] as [String : Any]
        
        TrustKit.initSharedInstance(withConfiguration: trustKitConfig)
    }
    //
    func  initIQKeyboardManager(){
        IQKeyboardManager.shared.enable = true
        //IQKeyboardManager.shared.toolbarConfiguration.barTintColor = UIColor(Color(hexString: CustomColors.lightGray))//UIColor(named: "white")
        //IQKeyboardManager.shared.toolbarConfiguration.tintColor = .white
        //IQKeyboardManager.shared.toolbarConfiguration.placeholderConfiguration.showPlaceholder = false
        
    }
    //
    func  initNotificationRequestAuthorization(launchOptions: [UIApplication.LaunchOptionsKey: Any]?){
        let center = UNUserNotificationCenter.current()
        let notifIdentifier = "cbkonnect.notifications"
        center.requestAuthorization(options: [.carPlay, .alert, .sound, .badge]) { (granted, error) in
            // Enable or disable features based on authorization.
            if granted {
                //init
                let callNow = UNNotificationAction(identifier: "view", title: "View", options: [])
                let clear = UNNotificationAction(identifier: "clear", title: "Clear", options: [])
                //
                let category : UNNotificationCategory = UNNotificationCategory.init(identifier: notifIdentifier, actions: [callNow, clear], intentIdentifiers: [], options: [])
                //
                center.setNotificationCategories([category])
                //
            }else{
                //Denied.
            }
        }
        //
        if launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] != nil {
            // Do what you want to happen when a remote notification is tapped.
            
            Logger( "APP LAUNCHED FROM REMOTE NOTIFICATION...")
            
            let remoteNotif = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] as? NSDictionary
            
            if remoteNotif != nil {
                let itemName = remoteNotif?["aps"] as! String
                Logger("Custom: \(itemName)")
            }
        }else if launchOptions?[UIApplication.LaunchOptionsKey.localNotification]  != nil {
            //
            Logger( "APP LAUNCHED FROM LOCAL NOTIFICATION...")
            //
        }else{
            Logger( "APP LAUNCHED NORMALLY...")
        }
        //
        if let opts = launchOptions{
            for k in opts{
                Logger( "Found Key '\(k.key)', value = '\(k.value)'")
            }
        }
        //
    }
    
    func initIdleToLogoutUser(){
        //MARK: IDLE TIMEOUT
        /**This is the notification registration process for receiving. (Register you NotificationCenter Observer) more about Notifications:
         *https://medium.com/@nimjea/notificationcenter-in-swift-104b31f59772
         *addObserver(self, — This is for the class where we are going to observer notification.
         * selector: #selector(attemptLogout) — function you call when the notification occurs.
         * name: NSNotification.Name(“AppNotifications.APP_IDLE_TIMEOUT”) — This is the Notification key 🔑 and this should be unique for any new Notification register(post) method. For calling(receiver) the same method this should be the same. This key 🔑 only can call this same method which we have registered as a key 🔑 and lock 🔐..*/
        NotificationCenter.default.addObserver(self, selector: #selector(attemptLogout), name: .appTimeOut, object: nil)
    }
    
    //
    func resetIdleTimerGood() {
        idleTimer?.invalidate()
        idleTimer = Timer.scheduledTimer(withTimeInterval: 2 * 60, repeats: false) { _ in
            NotificationCenter.default.post(name: .appTimeOut, object: nil)
        }
    }
    
    
    func resetIdleTimer() {
        print("RESTARTED THE TIMER")
        idleTimer?.invalidate()
        idleTimer = Timer.scheduledTimer(withTimeInterval: 2 * 10, repeats: false) { [weak self] _ in
            print("STOP TIMER")
            self?.notifyIdleTimeout()
        }
    }
    
    @objc func notifyIdleTimeout() {
        NotificationCenter.default.post(name: .appTimeOut, object: nil)
    }
    
    
    @objc func attemptLogout(){
        //MARK: - this key has something and user has logged in
        if let k = getUserDataBool(key: USERDEFAULTS.KEY_LOGIN_COMPLETE) as? Bool, k {
            if let trackIdle = getUserDataBool(key: USERDEFAULTS.KEY_TRACK_IDLELING) as? Bool{
                if(trackIdle){
                   // let landingStoryBoard = UIStoryboard(name: "Landing", bundle: nil)
                   //let loginVc = landingStoryBoard.instantiateViewController(identifier: "LoginNavContoller")
                   //(UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginVc)
                    AppUtils.Log(from:self,with:"AppDelegate :: Logout User")
                }else{
                    print("YOU CAN IDLEEEEEE")
                }
            }
        }
    }
}



extension Notification.Name {
    static var appTimeOut: Notification.Name {
        return .init(rawValue: "NSNotification.App.AppTimeout")
        
    }
    static var appCheckRuntime: Notification.Name {
        return .init(rawValue: "NSNotification.App.CheckRuntime")
        
    }
    static let didReceiveData = Notification.Name("didReceiveData")
}

