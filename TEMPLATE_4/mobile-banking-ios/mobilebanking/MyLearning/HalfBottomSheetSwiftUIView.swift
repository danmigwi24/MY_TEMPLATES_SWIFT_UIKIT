//
//  HalfBottomSheetSwiftUIView.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 09/02/2024.
//

import SwiftUI
import MBCore
import CustomHalfSheet

struct HalfBottomSheetSwiftUIView: View {
    @State private var isShowingHalfASheet = false
    @State private var amount = 0.0
    
    var body: some View {
        ZStack {
            Button("Show sheet") {
                isShowingHalfASheet.toggle()
            }
            
            HalfASheet(isPresented: $isShowingHalfASheet, title: "Rotation") {
                VStack(spacing: 20) {
                    Image(systemName: "leaf")
                        .font(.system(size: 80))
                        .foregroundColor(.blue)
                        .rotation3DEffect(Angle(degrees: amount), axis: (x: -1, y: -1, z: 0))
                    
                    Slider(value: $amount, in: 0...360)
                    
                    Text("Degrees: \(Int(amount))")
                        .italic()
                }
                .padding()
            }
            // Customise by editing these.
            .height(.proportional(0.40))
            .closeButtonColor(UIColor.white)
            .backgroundColor(.white)
            .contentInsets(EdgeInsets(top: 30, leading: 10, bottom: 30, trailing: 10))
        }
        .ignoresSafeArea()
    }
}
