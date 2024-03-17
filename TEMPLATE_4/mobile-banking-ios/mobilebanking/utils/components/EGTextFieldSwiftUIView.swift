//
//  EGTextFieldSwiftUIView.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 11/03/2024.
//

import SwiftUI
import CustomTextField

struct EGTextFieldSwiftUIView: View {
    //
    @State private var userInput:String = ""
    @State private var hasError:Bool = false
    var label : String? = nil
    var placeHolder : String? = nil
    //
    @State var errorText = "*Required"
    
    var body: some View {
        VStack{
            EGTextField(text: $userInput)
                //.setTitleText("First Name")
                .setTitleColor(.black)
                .setTitleFont(.body)
                .setPlaceHolderText("placeHolder")
                .setPlaceHolderTextColor(Color.gray)
                .setError(errorText: $errorText, error: $hasError)
            
        }
    }
}

#Preview {
    EGTextFieldSwiftUIView()
}
