//
//  CustomButtonFilled.swift
//  maishafiti-uikit
//
//  Created by Eclectics on 23/08/2023.
//

import SwiftUI
import MBCore

struct CustomButtonFilled: View {
    let action: () -> ()
    let title: String
    let bgColor:Color
    let textColor:Color
    let paddingVertical:CGFloat
    let cornerRadius: CGFloat
    
    init(action: @escaping () -> Void, title: String, bgColor: Color, textColor: Color,paddingVertical:CGFloat = 18,cornerRadius: CGFloat = 10) {
        self.action = action
        self.title = title
        self.bgColor = bgColor
        self.textColor = textColor
        self.paddingVertical = paddingVertical
        self.cornerRadius = cornerRadius
    }
    
    var body: some View {
        
        Button(
            action:action
            ,label: {
                Text(title)
                    //.font(.custom(FontNames.Rubik, size: 14))
                    .font(
                    Font.custom("Rubik", size: 16)
                    .weight(.medium)
                    )
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(textColor)
                    .padding(.vertical,paddingVertical)
                    .background(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(bgColor)
                    )
            }
        )
    }
}

struct CustomButtonStroke: View {
    let action: () -> Void
    let title: String
    let bgColor: Color
    let textColor: Color
    let strokeColor: Color // Add stroke color
    let strokeWidth: CGFloat // Add stroke width
    let paddingVertical:CGFloat
    let cornerRadius: CGFloat
    
    init(action: @escaping () -> Void, title: String, bgColor: Color, textColor: Color, strokeColor: Color, strokeWidth: CGFloat, paddingVertical:CGFloat = 18,cornerRadius: CGFloat = 10) {
        self.action = action
        self.title = title
        self.bgColor = bgColor
        self.textColor = textColor
        self.strokeColor = strokeColor
        self.strokeWidth = strokeWidth
        self.paddingVertical = paddingVertical
        self.cornerRadius = cornerRadius
    }
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.custom(CustomFontNames.NunitoSans_Regular, size: 16))
                .foregroundColor(textColor)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.vertical,paddingVertical)
                .background(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(bgColor)
                        .overlay(
                            //Capsule()
                            RoundedRectangle(cornerRadius: cornerRadius)
                                .stroke(strokeColor, lineWidth: strokeWidth)
                        )
                )
        }
    }
}



struct GradirntButton : View {
    var title : String
    var icon : String
    var action : () -> ()
    var body: some View {
        Button(action: action, label: {
            HStack(spacing: 15){
                Text(title)
                Image(systemName: icon)
            }
            //.fontWeight(.bold)
            .foregroundColor(.white)
            .padding(.vertical,12)
            .padding(.horizontal,12)
            .background(
                RoundedRectangle(cornerRadius: 20).fill(
                    .linearGradient(colors: [.blue,.blue, .blue], startPoint: .top, endPoint: .bottom)
                    //in: .capsule
                )
            )
        })
    }
}

struct LocationButton : View {
    var title : String
    var icon : String
    var action : () -> ()
    
    var body: some View{
        Button(action: action) {
            HStack {
                Text("\(title)")
                    .font(.headline)
                    .foregroundColor(.white)
                    .hSpacing(.leading)
                
                //Image(systemName: "location")
                Image(systemName: "\(icon)")
                    .font(.title)
                    .foregroundColor(.blue)
                    .hSpacing(.trailing)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical,12)
            .padding(.horizontal,12)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.1))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.blue, lineWidth: 1)
            )
        }
    }
}

struct RoundedButtonWithStrokeAndLeadingIcon: View {
    var title : String
    var icon : String
    var action : () -> ()
    
    var body: some View {
        Button(action: action) {
            HStack(alignment: .center,spacing: 10) {
                Image(icon) // Replace with your Google icon image name
                    .resizable()
                    .frame(width: 20, height: 20) // Adjust the size as needed
                    .foregroundColor(.black) // Adjust the color as needed
                
                Text(title)
                    .font(.headline)
                    .foregroundColor(.black)
                
            }
            .padding()
            .frame(maxWidth: .infinity,alignment: .center)
        }
        .background(Color.white)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray, lineWidth: 1)
        )
        //.padding()
    }
}

