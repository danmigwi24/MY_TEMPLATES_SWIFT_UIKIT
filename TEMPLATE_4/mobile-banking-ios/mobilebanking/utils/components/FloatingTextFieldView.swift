//
//  FloatingTextFieldView.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 09/02/2024.
//

import Foundation
import SwiftUI
import MBCore


struct FloatingTextFieldView : View {
    @Binding var text : String
    var label : String? = nil
    var placeHolder : String? = nil
    var leftIcon : String? = nil
    var rightIcon : String? = nil
    var isSystemImageLeftIcon : Bool? = nil
    var isSystemImageRightIcon : Bool? = nil
    var action:()->()
    

    
    @State private var isEditing = false
    @State private var edges = EdgeInsets(top: 0, leading:15, bottom: 55, trailing: 0)
    //@State private var edges = EdgeInsets(top: 0, leading:45, bottom: 0, trailing: 0)
    
    
    private enum Field : Int, Hashable {
        case fieldName
    }
    
    @FocusState private var focusField : Field?
    
    var body: some View {
        ZStack(alignment : .leading) {
            HStack {
                VStack{
                    if(leftIcon != nil){
                        if isSystemImageLeftIcon ?? false{
                            Image(systemName: leftIcon ?? "")
                                .foregroundColor(Color.secondary)
                        }else{
                            Image(leftIcon ?? "")
                                .resizable()
                                .frame(width: 15,height: 15)
                                .scaledToFit()
                                .foregroundColor(Color(hexString: CustomColors.darkBlue))
                            
                        }
                    }
                }.onTapGesture {
                    action()
                }
            
                TextField(placeHolder ?? "", text: $text) { status in
                    DispatchQueue.main.async {
                        isEditing = status
                        if isEditing {
                            //edges = EdgeInsets(top: 0, leading:15, bottom: 60, trailing: 0)
                        }
                        else {
                            //edges = EdgeInsets(top: 0, leading:45, bottom: 0, trailing: 0)
                        }
                    }
                }
                .focused($focusField, equals: .fieldName)
                .autocorrectionDisabled()
                VStack{
                    if(rightIcon != nil){
                        if isSystemImageRightIcon ?? false{
                            Image(systemName: rightIcon ?? "")
                                .foregroundColor(Color.secondary)
                        }else{
                            Image(rightIcon ?? "")
                                .resizable()
                                .frame(width: 15,height: 15)
                                .scaledToFit()
                                .foregroundColor(Color(hexString: CustomColors.darkBlue))
                            
                        }
                    }
                }.onTapGesture {
                    action()
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 5)
                .stroke(Color.black))
            
            Text(label ?? "")
                .font(.custom(CustomFontNames.NunitoSans_Regular, size: 12))
                .background(Color(UIColor.systemBackground))
                .foregroundColor(Color.black)
                .padding(edges)
                .animation(Animation.easeInOut(duration: 0.4), value: edges)
                .onTapGesture {
                    self.focusField = .fieldName
                }
            
        }
    }
}
