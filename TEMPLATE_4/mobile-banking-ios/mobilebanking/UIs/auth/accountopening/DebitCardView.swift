//
//  DebitCardView.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 12/02/2024.
//

import SwiftUI
import MBCore

struct DebitCardView: View {
    
   @Binding var imageBg:String
    let cardType:String
    let cardOwnerLogo:String
    let cardNumber:String
    let cardTypeImage:String
    let cardHolderName:String
    let cardExpirlyDate:String
    let geometry:GeometryProxy
    
    var body: some View {
            ZStack{
                Image(imageBg)
                    .resizable()
                    .frame(minWidth: geometry.size.width * 0.9 ,maxWidth: geometry.size.width)
                    //.scaledToFit()
                
                VStack{
                    HStack{
                        CustomTextBold(text: cardType, textColor: .white, fontSize: 18, textAlignment: .leading)
                        Spacer()
                        Image(cardOwnerLogo)
                            .resizable()
                            .frame(width: geometry.size.width * 0.28,height: geometry.size.height * 0.05)
                            //.scaledToFill()
                    }.vSpacingWithMaxWidth(.topLeading)
                    
                    Text(cardNumber).font(.custom(CustomFontNames.NunitoSans_Bold, size: 26).weight(.bold)).foregroundColor(.white).vSpacingWithMaxWidth(.center)
                        .lineLimit(1)
                    
                    HStack{
                        Spacer()
                        Image(cardTypeImage)
                            .resizable()
                            .frame(width: geometry.size.width * 0.3,height: geometry.size.height * 0.1)
                            .scaledToFit()
                            .clipped()
                    }.vSpacingWithMaxWidth(.trailing)
                    HStack{
                        CustomTextBold(text: cardHolderName, textColor: .white, fontSize: 18, textAlignment: .leading)
                        Spacer()
                        CustomTextBold(text: cardExpirlyDate, textColor: .white, fontSize: 18, textAlignment: .leading)
                        
                    }.vSpacingWithMaxWidth(.bottomLeading)
                    
                }.padding(5)
            }
            .frame(minWidth: geometry.size.width * 0.8 ,maxWidth: geometry.size.width)
    }
}


