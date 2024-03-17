//
//  LoadingView.swift
//  Croesus
//
//  Created by  Daniel Kimani on 05/02/2020.
//  Copyright © 2020 Triglobe Soft Solutions. All rights reserved.
//

import SwiftUI
import MBCore
import UIKit

struct ActivityIndicator: UIViewRepresentable {
    
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}


struct LoadingView<Content>: View where Content: View {
    
    @Binding var isShowing: Bool
    var content: () -> Content
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                
                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)
                
                VStack {
                    //
                    Text("Please Wait ..")
                        .foregroundColor(.white)
                    //
                    ActivityIndicator(isAnimating: .constant(true), style: .whiteLarge)
                        .foregroundColor(Color.white)
                }
                //.frame(width: geometry.size.width / 2, height: geometry.size.height / 5)
                .frame(width: 140, height: 140)
                .background(Color(.gray))
                .foregroundColor(Color.primary)
                .cornerRadius(20)
                .opacity(self.isShowing ? 1 : 0)
                
            }
        }
    }
    
}




struct CustomLoadingView<Content>: View where Content: View {
    
    @Binding var isShowing: Bool
    @Binding var loadingTitle: String
    var foregroundColor:Color
    //
    var content: () -> Content
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                
                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)
                
                VStack {
                    //
//                    Text("\(loadingTitle)")
//                        .padding()
//                        .foregroundColor(foregroundColor)
                    
                    CustomTextMedium(
                        text: "\(loadingTitle)",
                        textColor: foregroundColor,
                        fontSize: 14,
                        textAlignment: .center
                    ).vSpacingWithMaxWidth(.center)
                }
                //.frame(width: geometry.size.width / 2, height: geometry.size.height / 5)
                .frame(width: 300, height: 100)
                .background(Color(.gray).opacity(0.8))
                //.foregroundColor(Color.primary)
                .cornerRadius(20)
                .opacity(self.isShowing ? 1 : 0)
                
            }
        }
    }
    
}

