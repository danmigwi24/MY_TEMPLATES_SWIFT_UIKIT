//
//  CustomButtonStroke.swift
//  maishafiti-uikit
//
//  Created by Eclectics on 23/08/2023.
//

import SwiftUI
import MBCore


struct CustomTextRegular: View {
    let text: String
    let textColor: Color //= .black
    let fontSize: CGFloat //= 14
    let textAlignment:  TextAlignment //= .center
    let fontType:  String = CustomFontNames.NunitoSans_Regular
    
    var body: some View {
        Text(text)
            .font(.custom(fontType, size: fontSize).weight(.regular))
            .multilineTextAlignment(textAlignment)
            .foregroundColor(textColor)
            .animation(Animation.interpolatingSpring(stiffness: 40, damping: 8))
            .padding(.vertical, 4)
        
            //.padding(.horizontal, 8)
    }
}

struct CustomTextMedium: View {
    let text: String
    let textColor: Color //= .black
    let fontSize: CGFloat //= 14
    let textAlignment:  TextAlignment //= .center
    let fontType:  String = CustomFontNames.NunitoSans_Regular
    
    var body: some View {
        Text(text)
            .font(.custom(fontType, size: fontSize).weight(.medium))
            .multilineTextAlignment(textAlignment)
            .foregroundColor(textColor)
            .animation(Animation.interpolatingSpring(stiffness: 40, damping: 8))
            .padding(.vertical, 4)
            //.padding(.horizontal, 8)
    }
}



struct CustomTextSemiBold: View {
    let text: String
    let textColor: Color // = .black
    let fontSize: CGFloat //= 16
    let textAlignment:  TextAlignment //= .center
    let fontType:  String = CustomFontNames.NunitoSans_SemiBold
    
    var body: some View {
        Text(text)
            .font(.custom(fontType, size: fontSize).weight(.semibold))
            .multilineTextAlignment(textAlignment)
            .foregroundColor(textColor)
            .animation(Animation.interpolatingSpring(stiffness: 40, damping: 8))
            .padding(.vertical, 4)
            //.padding(.horizontal, 8)
    }
}


struct CustomTextBold: View {
    let text: String
    let textColor: Color //= .black
    let fontSize: CGFloat //= 20
    let textAlignment:  TextAlignment //= .center
    let fontType:  String = CustomFontNames.NunitoSans_Bold
    
    var body: some View {
        Text(text)
            .font(.custom(fontType, size: fontSize).weight(.bold))
            .multilineTextAlignment(textAlignment)
            .foregroundColor(textColor)
            .animation(Animation.interpolatingSpring(stiffness: 40, damping: 8))
            .padding(.vertical, 4)
            //.padding(.horizontal, 4)
    }
}


struct RoundedStrikeTextView: View {
    let text :String
    let textColor:Color = .blue
    let strockColor:Color = .blue
    let frameSize:CGFloat = 40
    var body: some View {
           Text("\(text)")
            .font(.custom(CustomFontNames.NunitoSans_Regular, size: 18))
               .foregroundColor(textColor)
               .frame(alignment: .center)
               .overlay(
                   RoundedRectangle(cornerRadius: 20)
                       .stroke(lineWidth: 2)
                       .foregroundColor(strockColor)
                       .frame(width: frameSize,height: frameSize)
               )
       }
}

struct RoundedStrikeTextView_Previews: PreviewProvider {
    static var previews: some View {
        RoundedStrikeTextView(text: "AK")
    }
}


