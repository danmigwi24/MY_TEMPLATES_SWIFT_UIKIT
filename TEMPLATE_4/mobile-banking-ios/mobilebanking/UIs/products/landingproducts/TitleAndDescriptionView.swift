//
//  TitleAndDescriptionView.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 08/02/2024.
//

import SwiftUI
import MBCore

struct TitleAndDescriptionView: View {
    var title:String
    var description:String
    var titleColor:Color
    var descriptionColor:Color
    
    init(title: String, description: String, titleColor: Color = .black, descriptionColor: Color = Color(hexString: CustomColors.blue)) {
        self.title = title
        self.description = description
        self.titleColor = titleColor
        self.descriptionColor = descriptionColor
    }
    
    var body: some View {
        VStack{
            VStack(spacing:0){ //
                CustomTextBold(
                    text: title,
                    textColor: titleColor,
                    fontSize: 20,
                    textAlignment: TextAlignment.leading
                )
                .vSpacingWithMaxWidth(.leading)
                
                
                CustomTextRegular(
                    text: description,
                    textColor: descriptionColor ,
                    fontSize: 14,
                    textAlignment: TextAlignment.leading
                )
                .vSpacingWithMaxWidth(.leading)
                
            }
        }
    }
}

