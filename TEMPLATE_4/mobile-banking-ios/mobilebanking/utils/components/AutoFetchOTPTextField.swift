//
//  AutoFetchOTPTextField.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 14/03/2024.
//

import Foundation
import SwiftUI
import MBCore


struct AutoFetchOTPTextField: View {
    @Binding var otpText: String //= ""
    var hint: String = ""
    var numberofOtpFields: Int
    //
    @FocusState private var isKeyboardShowing:Bool
    var body: some View {
        VStack{
            Text(hint)
                .foregroundColor(Color.black)
                .font(.custom(CustomFontNames.NunitoSans_Regular, size: 16))
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing:0){
                //OTP Text Boxes
                //Change count based on your OYTP Text Size
                ForEach(0..<numberofOtpFields ,id: \.self){index in
                    OTPTextBox(index)
                }
                
                
            }
            .padding(.bottom,20)
            .padding(.top,10)
            .background(
                TextField("", text: $otpText.limit(6))
                    .frame(width: 1,height: 1)
                    .opacity(0.001)
                    .blendMode(.screen)
                    .focused($isKeyboardShowing)
                    .keyboardType(.numberPad)
                    .textContentType(.oneTimeCode)
                
                //
            )
            .contentShape(Rectangle())
            .onTapGesture {
                isKeyboardShowing.toggle()
            }
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
        .onAppear{
            isKeyboardShowing = true
        }
        .onChange(of: otpText) { newValue in
           
        }
    }
    
    
    //
    @ViewBuilder
    func OTPTextBox(_ index:Int) -> some View {
        ZStack{
            if otpText.count > index{
                let startIndex = otpText.startIndex
                let charIndex = otpText.index(startIndex,offsetBy: index)
                let charToString = String(otpText[charIndex])
                Text(charToString)
                    .foregroundColor(Color.black)
                    .font(.custom(CustomFontNames.NunitoSans_Regular, size: 16))
            }else{
                Text("")
            }
        }.frame(width: 45, height: 45)
            .background(
                RoundedRectangle(cornerRadius: 6).fill(.gray.opacity(0.2))
            ).frame(maxWidth: .infinity)
    }
}
