//
//  CustomAlertDialogs.swift
//  maishafiti-uikit
//
//  Created by Daniel Kimani on 05/10/2023.
//

import Foundation
import SwiftUI
import MBCore



public func CustomAlertDailog(
    title:String,
    message:String,
    primaryText:String,
    primaryAction: @escaping ()->()
){
    
    let  alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    
    alert.addAction(.init(title: primaryText, style: .default,handler: {_ in
        primaryAction()
    }))
    //MARK: PRESENTING DIALOG
    rootController().present(alert,animated: true,completion: nil)
}

public func CustomAlertDailogWithTextField(
    title:String,
    message:String,
    hint:String,
    primaryText:String,
    secondaryTitle:String,
    primaryAction: @escaping (String)->(),
    secondaryAction: @escaping ()->()
){
    let  alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addTextField{ field in
        field.placeholder = hint
    }
    alert.addAction(.init(title: secondaryTitle, style: .cancel,handler: {_ in
        secondaryAction()
    }))
    
    alert.addAction(.init(title: primaryText, style: .default,handler: {_ in
        if let text = alert.textFields?[0].text{
            primaryAction(text)
        }else {
            primaryAction("")
        }
    }))
    
    //MARK: PRESENTING DIALOG
    rootController().present(alert,animated: true,completion: nil)
}


public func CustomAlertDailogWithCancelAndConfirm(
    title:String,
    message:String,
    secondaryTitle:String,
    primaryText:String,
    secondaryAction: @escaping ()->(),
    primaryAction: @escaping ()->()
){
    let  alert = UIAlertController(title: title, message: "\n\(message)\n", preferredStyle: .alert)
    
    alert.addAction(.init(title: secondaryTitle, style: .default,handler: {_ in
        secondaryAction()
    }))
    
    alert.addAction(.init(title: primaryText, style: .default,handler: {_ in
        primaryAction()
    }))
    
    //MARK: PRESENTING DIALOG
    rootController().present(alert,animated: true,completion: nil)
}


public func rootController() -> UIViewController {
    guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
        return .init()
    }
    
    guard let root = screen.windows.first?.rootViewController else {
        return .init()
    }
    
    return root
}




