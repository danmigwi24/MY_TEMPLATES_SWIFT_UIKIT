//
//  main.swift
//  Postbank
//
//  Created by LenoxBrown on 20/06/2022.
//

import UIKit
/*
 * When the app is launched, the UIApplication is created and then when everything is ready, the delegate UIApplicationDelegate is called, thanks to its delegate method application(didFinishLaunchingWithOptions:) allowing us to perform custom setup
 
 *entry point for launching an iOS app and starting its main event loop. It is called from the main.swift file, which serves as the app's entry point.
 **/
UIApplicationMain(CommandLine.argc,CommandLine.unsafeArgv, NSStringFromClass(UIKitMobileBankingApp.self), NSStringFromClass(AppDelegate.self))
