//
//  RadioBoxSection.swift
//  maishafiti-uikit
//
//  Created by Daniel Kimani on 06/11/2023.
//

import Foundation
import SwiftUI
import MBCore

//struct RadioBoxSection: View {
struct RadioBoxSection: View {
    //
    @State  var  title:String
    @Binding  var  isChecked:Bool
    @State  var  action: () -> ()
    //@State var
    //
    var body: some View {
        VStack {
            HStack(){
                Button(action: action,
                       label: {
                    if isChecked{
                        Image(systemName:"checkmark.circle.fill" )
                            .resizable()
                            .frame(width: 24, height: 24)
                            .clipShape(Circle())
                            .foregroundColor(Color(red: 0.67, green: 0.79, blue: 0.04))
                    }else{
                        Circle()
                            .fill(Color.gray.opacity(0.5))
                            .frame(width: 24, height: 24)
                    }
                })
                
                Text(title)
                    .font(Font.custom("Inter", size: 15))
                    .foregroundColor(Color.black)
                    .hSpacing(.leading)
                
            }
        }
    }
}


struct CheckBoxSection: View {
    //
    @State  var title:String
   
    //@State  var action: () -> ()
    
    @Binding var isChecked:Bool //= false
    //@State var
    //
    var body: some View {
        VStack {
            HStack(){
                if isChecked{
                    Image(systemName:"checkmark.square" )
                        .resizable()
                        .frame(width: 24, height: 24)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .foregroundColor(Color(red: 0.67, green: 0.79, blue: 0.04))
                }else{
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(hexString: CustomColors.gray), lineWidth: 0.5)
                        .frame(width: 24, height: 24)
                }
                
                
                Text(title)
                    .font(Font.custom("Inter", size: 15))
                    .foregroundColor(Color.black)
                    .hSpacing(.leading)
            }
        }.padding(5)


    }
}

/*
 @ViewBuilder
 func SelectionPicker(title:String, isChecked:Bool, action: @escaping(() -> ()))->some View {
 HStack(){
 Button(action: action,
 label: {
 if isChecked{
 Image(systemName:"checkmark.circle.fill" )
 .resizable()
 .frame(width: 24, height: 24)
 .clipShape(Circle())
 .foregroundColor(Color(red: 0.67, green: 0.79, blue: 0.04))
 }else{
 Circle()
 .fill(Color.gray.opacity(0.5))
 .frame(width: 24, height: 24)
 }
 
 })
 
 Text(title)
 .font(Font.custom("Inter", size: 15))
 .foregroundColor(Color.black)
 .hSpacing(.leading)
 
 }
 }
 
 
 @ViewBuilder
 func SelectionPicker(title:String, isChecked:Bool, action: @escaping(() -> ()))->some View {
 HStack(){
 Button(action: action,
 label: {
 if isChecked{
 Image(systemName:"checkmark.circle.fill" )
 .resizable()
 .frame(width: 24, height: 24)
 .clipShape(Circle())
 .foregroundColor(Color(red: 0.67, green: 0.79, blue: 0.04))
 }else{
 Circle()
 .fill(Color.gray.opacity(0.5))
 .frame(width: 24, height: 24)
 }
 
 })
 
 Text(title)
 .font(Font.custom("Inter", size: 15))
 .foregroundColor(Color.black)
 .hSpacing(.leading)
 
 }
 }
 */



struct MultipleSelectionRow: View {
    var item: String
    @Binding var isSelected: Bool

    var body: some View {
        HStack {
            Toggle(isOn: $isSelected) {
                Text(item)
            }.padding(.horizontal,10)
            
//            if isSelected{
//                Image(systemName:"checkmark.square" )
//                    .resizable()
//                    .frame(width: 24, height: 24)
//                    .clipShape(RoundedRectangle(cornerRadius: 5))
//                    .foregroundColor(Color(red: 0.67, green: 0.79, blue: 0.04))
//            }else{
//                RoundedRectangle(cornerRadius: 5)
//                    .stroke(Color(hexString: CustomColors.gray), lineWidth: 0.5)
//                    .frame(width: 24, height: 24)
//            }
        }
//        .onTapGesture {
//            isSelected.toggle()
//        }
    }
}
