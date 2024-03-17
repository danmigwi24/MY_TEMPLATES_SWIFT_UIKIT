//
//  ScreenShotCaptureView.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 29/02/2024.
//

import Foundation
import SwiftUI
import MBCore


struct ScreenShotCaptureView: View {
    @State var index = 0

    var images = ["PersonalCurrentAccount", "OurCardProducts1", "PersonalCurrentAccount", "OurCardProducts1"]

    var body: some View {
        
        VStack(spacing: 20) {
            ///*
            
            PagingView(index: $index.animation(), title: "Data", maxIndex: images.count - 1) {
                ForEach(self.images, id: \.self) { imageName in
                    VStack{
                        Image(imageName)
                            .resizable()
                            //.scaledToFill()
                            //.frame(width: 100)
                    }.padding(10)
                }
            }
            //.aspectRatio(4/3, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 15))

            PagingView(index: $index.animation(), title: "Data 2", maxIndex: images.count - 1) {
                ForEach(self.images, id: \.self) { imageName in
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                }
            }
            //.aspectRatio(3/4, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            //*/
            Stepper("Index: \(index)", value: $index.animation(.easeInOut), in: 0...images.count-1)
                .font(Font.body.monospacedDigit())
        }
        .padding()
    }
}








