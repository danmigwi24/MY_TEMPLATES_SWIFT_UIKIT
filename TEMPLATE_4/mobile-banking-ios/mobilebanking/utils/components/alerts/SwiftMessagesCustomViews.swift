//
//  SwiftMessagesCustomViews.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 14/03/2024.
//

import Foundation
import SwiftUI
import MBCore
import UIKit
import SwiftMessages


//
@MainActor
func showCustomizedSwiftMessages(title:String,body:String,isError:Bool = true,dismissAfter:TimeInterval = 2){
    var config = SwiftMessages.defaultConfig
    var msgView = MessageView.viewFromNib(layout: .cardView)
    //
    msgView.configureTheme( isError ? .error : .success)
    msgView.configureContent(title: title, body: body)
    //
    msgView.button?.isHidden = false
    msgView.button?.setTitle("Dismiss", for: .normal)
    msgView.buttonTapHandler = { _ in SwiftMessages.hide(animated: true) }
    //
    config.preferredStatusBarStyle = .lightContent
    //
    config.duration = .seconds(seconds: dismissAfter)
    SwiftMessages.show(config: config,view: msgView)
}
//*/

@MainActor
func showSuccessSwiftMessages(title:String,body:String,isError:Bool = true,dismissAfter:TimeInterval = 2){
    var config = SwiftMessages.defaultConfig
    var msgView = MessageView.viewFromNib(layout: .cardView)
    //
    msgView.configureTheme( isError ? .error : .success)
    msgView.configureContent(title: title, body: body)
    //
    msgView.button?.isHidden = false
    msgView.button?.setTitle("Dismiss", for: .normal)
    msgView.buttonTapHandler = { _ in SwiftMessages.hide(animated: true) }
    //
    config.preferredStatusBarStyle = .lightContent
    //
    config.duration = .seconds(seconds: dismissAfter)
    SwiftMessages.show(config: config,view: msgView)
}
