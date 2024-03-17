//
//  ToggleCheckboxStyles.swift
//  maishafiti-uikit
//
//  Created by Eclectics on 23/08/2023.
//

import Foundation

import SwiftUI
import MBCore


struct ToggleCheckboxStyles : ToggleStyle {
    
    @Binding var isChecked: Bool
    
    func makeBody(configuration:Configuration) -> some View {
        Button{
            configuration.isOn.toggle()
        }label: {
            Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 15,height: 15)
                .foregroundColor(Color(hexString:CustomColors.darkBlue))
               // .symbolVariant(configuration.isOn ? .fill : .none)
        }
        //.tint(.blue)
    }
}
