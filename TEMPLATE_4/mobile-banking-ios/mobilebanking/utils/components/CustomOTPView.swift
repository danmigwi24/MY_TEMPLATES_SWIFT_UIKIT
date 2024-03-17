//
//  CustomOTPView.swift
//  maishafiti-uikit
//
//  Created by Dan Migwi on 2023/9/23.
//

import SwiftUI
import MBCore


struct CustomOTPView: View {
    @Binding var otpText: String
    var hint: String
    var numberofOtpFields: Int
    //
    @State private var isKeyboardShowing = false
    
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
                .onChange(of: otpText) { newValue in
                    if newValue.count >= 6 {
                        isKeyboardShowing = false
                    }else{
                        isKeyboardShowing = true
                    }
                }
                
            }.padding(.bottom,20)
                .padding(.top,10)
                .background(
                    //TextField("", text: $otpText.limit(6))
                    UIKitTextField(text: $otpText.limit(numberofOtpFields), isFocused: $isKeyboardShowing)
                        .frame(width: 1,height: 1)
                        .opacity(0.001)
                        .blendMode(.screen)
                        .keyboardType(.numberPad)
                        .textContentType(.oneTimeCode)
                    //.focused($isKeyboardShowing)
                )
                .contentShape(Rectangle())
                .onTapGesture {
                    isKeyboardShowing.toggle()
                }
        }
    }
    
    
    
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
                //RoundedRectangle(cornerRadius: 6,style: .continuous).stroke(.gray,lineWidth: 0.5)
                /*
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color(hexString: CustomColors.blue), lineWidth: 1)
                    )
                */
            ).frame(maxWidth: .infinity)
    }
}


extension Binding where Value == String {
    func limit(_ length: Int) -> Self {
        if self.wrappedValue.count > length {
            DispatchQueue.main.async {
                self.wrappedValue =  String(self.wrappedValue.prefix(length))
            }
        }
        return self
    }
}






struct UIKitTextField: UIViewRepresentable {
    @Binding var text: String
    @Binding var isFocused: Bool

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.keyboardType = .numberPad 
        textField.textContentType = .oneTimeCode
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        if isFocused {
            uiView.becomeFirstResponder()
        } else {
            uiView.resignFirstResponder()
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, isFocused: $isFocused)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        @Binding var isFocused: Bool

        init(text: Binding<String>, isFocused: Binding<Bool>) {
            _text = text
            _isFocused = isFocused
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }

        func textFieldDidEndEditing(_ textField: UITextField) {
            DispatchQueue.main.async {
                self.isFocused = false
            }
            
        }
    }
}
