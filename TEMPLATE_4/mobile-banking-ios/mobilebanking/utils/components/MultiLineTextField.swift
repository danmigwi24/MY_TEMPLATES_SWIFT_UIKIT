//
//  MultiLineTextField.swift
//  maishafiti-uikit
//
//  Created by Daniel Kimani on 31/10/2023.
//

import Foundation


import SwiftUI
import MBCore
import UIKit

struct MultiLineTextFieldView: View {
    @State private var text = ""

    var body: some View {
        VStack {
            Text("Enter your text:")
            
            MultiLineTextField(text: $text)
                .frame(height: 200)
                .border(Color.gray)
                .padding()
            
            Text("You entered: \(text)")
        }
    }
}

struct MultiLineTextField: UIViewRepresentable {
    @Binding var text: String

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.layer.borderWidth = 1 
        textView.layer.cornerRadius = 10 // Add corner radius here
        textView.layer.masksToBounds = true
        textView.layer.borderColor = UIColor.gray.cgColor
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: MultiLineTextField

        init(_ parent: MultiLineTextField) {
            self.parent = parent
        }

        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if text == "\n" {
                textView.resignFirstResponder()
                return false
            }
            return true
        }
    }
}








