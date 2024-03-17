//
//  UIKitMobileBankingApp.swift
//  Postbank
//
//  Created by LenoxBrown on 20/06/2022.
//

import Foundation
import UIKit
import AdSupport
/**Every iOS app has exactly one instance of UIApplication, which is responsible for handling and routing user event to the good objects.
 * *
 *UIApplication - acts as the bridge between the app and the operating system*
 *it providies essential functionalities for managing app lifecycles, handling user interactions, and coordinating app-wide behavior.
 *This is the old way  where we define main.swift file manually, but on new xcode versions, we have appdelegate annotated with @main and it generates  main.swift file under the hood.
 */
class UIKitMobileBankingApp: UIApplication{
    var idleTimer: Timer?
    var Environment:AppEnvironment?{
        didSet{
        }
    }
    
    override init() {
        Environment = AppConfig.Current?.Environment
        super.init()
    }
    
    override func sendEvent(_ event: UIEvent) {
        ///Calling the parent method at first will dispatch the event that we intercept back to the system.
        ///Then we check the event is a touch screen event, and if so reset the timer.
        super.sendEvent(event)
        if event.allTouches?.first(where: { $0.phase == .began }) != nil {
            print("------------------ sendEvent ----------------------")
            resetIdleTimer()
        }
    }
    
    override func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey : Any] = [:], completionHandler completion: ((Bool) -> Void)? = nil) {
        AppUtils.Log(from:self,with:"Accessing \(String(describing: url.host))")
        super.open(url, options: options, completionHandler: completion)
    }
    func resetIdleTimer() {
        /// resent the timer because there was user interaction
        idleTimer?.invalidate()
        idleTimer = Timer.scheduledTimer(timeInterval: 2 * 60, target: self, selector: #selector(notifyIdleTiemout), userInfo: nil, repeats: false)
    }
    // Broadcast (Post or Send) 🚀 data
    @objc func notifyIdleTiemout(){
        
        // if the timer reaches the limit as defined in timeoutInSeconds, post this notification
        NotificationCenter.default.post(name: .appTimeOut, object: nil)
    }
}
