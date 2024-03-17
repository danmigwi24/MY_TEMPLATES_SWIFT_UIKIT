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
        self.window = UIWindow(frame: UIScreen.main.bounds)
        //self.window?.backgroundColor = .systemBackground
        self.window?.backgroundColor = .blue//UIColor(named: "backgroundColor")
        self.window?.makeKeyAndVisible()
        //self.window?.rootViewController = UINavigationController(rootViewController: ViewController())
        self.window?.rootViewController = ViewController()
        return true
    }

 


}

