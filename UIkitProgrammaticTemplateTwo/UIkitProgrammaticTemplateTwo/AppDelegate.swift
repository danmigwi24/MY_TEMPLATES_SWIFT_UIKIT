//
//  AppDelegate.swift
//  UIkitProgrammaticTemplateTwo
//
//  Created by Daniel Kimani on 17/03/2024.
//

import UIKit

//@main
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("\nAppDelegate [ didFinishLaunchingWithOptions ]\n")
        setUpWindow()
        return true
    }

    //
    func setUpWindow(){
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .blue
        self.window?.makeKeyAndVisible()
        //self.window?.rootViewController = UINavigationController(rootViewController: ViewController())
        self.window?.rootViewController = MainViewController()
    }


}

