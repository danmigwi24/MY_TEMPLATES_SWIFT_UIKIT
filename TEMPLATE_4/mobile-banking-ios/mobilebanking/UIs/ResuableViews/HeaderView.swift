//
//  HeaderView.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 07/02/2024.
//

import SwiftUI
import MBCore

struct HeaderView: View {
    let title:String
    let textColor:Color
    let imageIcon:String
    let isSystemImage:Bool
    let action:()->()
    
    var body: some View {
        ZStack(alignment: .topLeading){
            //Color(hexString: CustomColors.darkBlue)
            //                .edgesIgnoringSafeArea([.horizontal,.top])
            //
            VStack{
                HStack{
                    Button(action: action, label: {
                        if imageIcon != ""{
                            if isSystemImage {
                                Image(systemName: imageIcon)
                                    .resizable()
                                    .frame(width: 18,height: 15)
                                    .scaledToFit()
                                    .foregroundColor(textColor)
                            }else{
                                Image(imageIcon)
                                    .resizable()
                                    .frame(width: 18,height: 15)
                                    .scaledToFit()
                                    .foregroundColor(textColor)
                            }
                        }
                    })
                    
                    CustomTextSemiBold(
                        text: title,
                        textColor: textColor,
                        fontSize: 16,
                        textAlignment: TextAlignment.leading
                    ).vSpacingWithMaxWidth(.leading)
                    
                }
                .vSpacingWithMaxWidth(.leading)
                .padding(16)
                .background( Color(hexString: CustomColors.darkBlue))
                //.padding(.top,20)
                //.padding(.bottom,4)
                
            }
        }
        
    }
}




struct SheetHeaderView: View {
    let title:String
    let leadingTitle:String
    let trailingTitle:String
    let leadingAction:()->()
    let trailingAction:()->()
    
    var body: some View {
        ZStack(alignment: .topLeading){
            VStack{
                HStack{
                    Button(action: {
                        leadingAction()
                    }, label: {
                        HStack{
                            Image(systemName: "chevron.backward")
                                .foregroundColor(.black)
                            Text(leadingTitle)
                                .foregroundColor(Color.blue)
                        }
                    })
                    
                    CustomTextSemiBold(
                        text: title,
                        textColor: .black,
                        fontSize: 18,
                        textAlignment: TextAlignment.center
                    ).vSpacingWithMaxWidth(.center)
                    
                    Button(action: {
                        trailingAction()
                    }, label: {
                        Text(trailingTitle)
                            .foregroundColor(Color.blue)
                    })
                    
                }
                .vSpacingWithMaxWidth(.leading)
                .padding(16)
                
            }
            .background(.gray.opacity(0.1))
        }
        
    }
}

