//
//  LocationTextFieldView.swift
//  maishafiti-uikit
//
//  Created by Eclectics on 04/09/2023.
//

import SwiftUI
import MBCore

struct LocationTextFieldView: View {
    
    @Binding var text : String
    //@Binding var isTextFieldEnabled: Bool
    
    var hint : String
    var labelText : String
    var action:() -> ()
   
    
    var body: some View {
        LocationSection()
    }
}


extension LocationTextFieldView {
    @ViewBuilder
    func LocationSection() -> some View{
        VStack {
            Text("Derivery location")
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.custom(CustomFontNames.NunitoSans_Regular, size: 16))
                .foregroundColor(Color.gray)
                .padding(.top, 4)
                .padding(.leading, 10)
                .padding(.trailing, 10)
            
            Button(action: action) {
                VStack{
                    HStack{
                        Text("Eg: CBD, Nairobi") // Show selected date in button text
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .foregroundColor(.black)
                        
//                        TextField(hint,text: $text)
//                            .multilineTextAlignment(.leading)
//                            //.disabled(isTextFieldEnabled)
//                            .padding(.top, 4)
//                            .padding(.leading, 10)
//                            .padding(.trailing, 10)
                     
                        
                        Image(systemName: "location")
                            .font(.callout)
                            .foregroundColor(.blue)
                            .padding(.trailing,10)
                            .frame(width: 40,alignment: .trailing)
                            .hSpacing(.trailing)
                        
                    }
                    
                    ZStack(alignment: .leading){
                        Rectangle()
                            .fill(.blue)
                    }.padding(.horizontal,9)
                    .frame(height: 2)
                    
                }.background(
                    Color
                        .gray.opacity(0.2)
                        .opacity(0.3)
                        .cornerRadius(6)
                        
                )
            }
           
        }
    }
}
