//
//  CustomAlert.swift
//  maishafiti-uikit
//
//  Created by Eclectics on 03/09/2023.
//

import Foundation


import SwiftUI
import MBCore

public func CustomAlert(isPresented: Binding<Bool>, title:String, decription:String) -> Alert {
    //return
    Alert(title: Text(title),
          message: Text(decription),
          dismissButton: .default(Text("Ok")))
    
}


public func CustomActionSheet(isPresented: Binding<Bool>, title:String, decription:String) -> ActionSheet {
    return ActionSheet(
        title: Text(title).font(.title),
        message: Text(decription).font(.body),
        buttons: [
            .default(
                Text("Ok").bold(),
                action: {
                    isPresented.wrappedValue = false
                }
            )
        ]
    )
}
