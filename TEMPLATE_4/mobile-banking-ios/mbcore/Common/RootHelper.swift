//
//  RootHelper.swift
//  AppCore
//
//  Created by  Daniel Kimani on 6/1/21.
//  Copyright © 2021 Eclectics Int. All rights reserved.
//

import Foundation
import UIKit

extension UIDevice {
    var isSimulator: Bool {
        #if targetEnvironment(simulator)
            // This is a Simulator not an idevice
            return true
        #else
            return TARGET_OS_SIMULATOR != 0
        #endif
    }
    
    
    var isJailBroken: Bool {
        get {
            //simulator device cant b rooted as they are just simulated enviroment, so we the check evaluate to true we set isJailBroken value to false
            if UIDevice.current.isSimulator { return false }
            if JailBrokenHelper.hasCydiaInstalled() { return true }
            if JailBrokenHelper.isSuspiciousAppandFilesExists() { return true }
            if JailBrokenHelper.systemForkCall() { return true }
            return JailBrokenHelper.canEditSystemFiles()
        }
    }
  public var isDebuggerAttached : Bool {
        var info = kinfo_proc()
        var mib: [Int32] = [CTL_KERN, KERN_PROC, KERN_PROC_PID, getpid()]
        var size = MemoryLayout<kinfo_proc>.stride
        /**
         *sysctl, is usded to retrieve information about the system, such as process information, system configuration, network settings, and more.here we use sysctl to retrieve process information to check if the app is being debugged by examining the P_TRACED flag in the process structure.
         */
        //sysctl(<#T##UnsafeMutablePointer<Int32>!#>, <#T##u_int#>, <#T##UnsafeMutableRawPointer!#>, <#T##UnsafeMutablePointer<Int>!#>, <#T##UnsafeMutableRawPointer!#>, <#T##Int#>)
        let junk = sysctl(&mib, u_int(mib.count), &info, &size, nil, 0) //sysctl(&mib, 4, &info, &size, nil, 0)
        if junk == -1 {
          perror("sysctl Attacker you are cursed")
            
          exit(0)
         }
        return (info.kp_proc.p_flag & P_TRACED) != 0
    }
}

private struct JailBrokenHelper {
    //check if cydia is installed (using URI Scheme)
    static func hasCydiaInstalled() -> Bool {
        return UIApplication.shared.canOpenURL(URL(string: "cydia://")!)
    }
    //Check if system contains suspicious files and apps (Cydia, FakeCarrier, Icy etc.) is installed
    static func isSuspiciousAppandFilesExists() -> Bool {
        for path in suspiciousAppsandFilesToCheck {
            if FileManager.default.fileExists(atPath: path) {
                return true
            }
        }
        return false
    }
    
    //Check if app can edit system files
    static func canEditSystemFiles() -> Bool {
        let jailBreakText = "Developer Insider are cursed"
        let jbFilePath = "/private/jailBreakTestText.txt"
        do {
            try jailBreakText.write(toFile: jbFilePath, atomically: true, encoding: .utf8)
            try FileManager.default.removeItem(atPath: jbFilePath)
            return true
        } catch {
            print("wait test eerror\(error)")
            return false
        }
    }
    // It is used to check if there is a child process run at kernel level
   static func systemForkCall() -> Bool{
        let pid = getpgrp()
       AppUtils.Timber(with: "PID is \(pid)")
        // process group ID less than zero typically indicates that the process has the ability to create child processes using the fork() system call.
       return pid < 0 ? true : false
    }
    
    //when a device is jailbroken, many files are created, so we check for such suspicious apps and files in the root directory
    static var suspiciousAppsandFilesToCheck: [String] {
        return ["/Applications/Cydia.app",
                "/Applications/blackra1n.app",
                "/Applications/FakeCarrier.app",
                "/Applications/Icy.app",
                "/Applications/IntelliScreen.app",
                "/Applications/MxTube.app",
                "/Applications/RockApp.app",
                "/Applications/SBSettings.app",
                "/Applications/Snoop-itConfig.app",
                "/Applications/WinterBoard.app",
                "/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
                "/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
                "/private/var/lib/apt",
                "/private/var/lib/apt/",
                "/private/var/lib/cydia",
                "/private/var/mobile/Library/SBSettings/Themes",
                "/private/var/stash",
                "/private/var/tmp/cydia.log",
                "/System/Library/LaunchDaemons/com.ikey.bbot.plist",
                "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
                "/usr/bin/sshd",
                "/usr/libexec/sftp-server",
                "/usr/sbin/sshd",
                "/etc/apt",
                "/bin/bash",
                "/Library/MobileSubstrate/MobileSubstrate.dylib",
                "/usr/libexec/cydia/",
                "/usr/sbin/frida-server",
                "/usr/bin/cycript",
                "/usr/local/bin/cycript",
                "/usr/lib/libcycript.dylib",
                "/bin/sh",
                "/usr/libexec/ssh-keysign",
                "/usr/bin/ssh",
                "/var/checkra1n.dmg",
        ]
    }
}
