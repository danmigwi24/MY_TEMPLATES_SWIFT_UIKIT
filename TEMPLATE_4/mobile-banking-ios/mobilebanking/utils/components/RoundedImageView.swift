//
//  RoundedImageView.swift
//  maishafiti-uikit
//
//  Created by Daniel Kimani on 28/09/2023.
//

import SwiftUI
import MBCore

struct RoundedImageView: View {
    var image:String
    var imageTint:Color
    var diameter:CGFloat
    //var height:Int
    var circleDiameter:CGFloat
    //var circleHeight:Int
    var circleBg:Color
    
    var body: some View {
        VStack {
            ZStack(){
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(imageTint)
                    .frame(width: diameter,height: diameter)
                    //.padding(5)
                
            }.frame(width: circleDiameter, height: circleDiameter)
                .background(
                    Circle()
                        .fill(circleBg)
                )
        }
    }
}
