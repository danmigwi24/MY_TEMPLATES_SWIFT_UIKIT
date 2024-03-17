//
//  CustomProgressViewUIView.swift
//  Deliverance IOS App
//
//  Created by Eclectics on 03/07/2023.
//

import SwiftUI
import MBCore

//struct CustomProgressViewUIView: View {
//    var body: some View {
//        VStack{
//            Spacer()
//            ProgressView("Loading...")
//                .progressViewStyle(CircularProgressViewStyle())
//                .frame(alignment: .center)
//            Spacer()
//        }
//    }
//}


struct CustomProgressViewUIView: View {
    var body: some View {
        VStack {
            Spacer()
            
            customCircularProgressView()
                .frame(width: 50, height: 50)
            Text("Loading...")
            
            Spacer()
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray.opacity(0.3))
    }
    
    
    
    @ViewBuilder
    private func customCircularProgressView() -> some View {
        if #available(iOS 14.0, *) {
            VStack{
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle()).vSpacingMaxHeight()
            }
        } else {
            // Fallback for iOS versions earlier than 14.0
            VStack{
                ZStack {
                    Circle()
                        .stroke(Color.blue, lineWidth: 4)
                        .opacity(0.3)
                    
                    Circle()
                        .trim(from: 0, to: 0.7) // Set your progress value here
                        .stroke(Color.blue, lineWidth: 4)
                        .rotationEffect(.degrees(-90))
                }.vSpacingMaxHeight()
            }
        }
    }
    
    
    @ViewBuilder
    private func CustomLoadingView() -> some View{
  
            GeometryReader { geometry in
               ZStack(alignment: .center) {

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
                    .opacity(1 )

                }
            }
        
    }
    
    
    
    
    
}

struct CustomProgressViewUIView_Previews: PreviewProvider {
    static var previews: some View {
        CustomProgressViewUIView()
    }
}





