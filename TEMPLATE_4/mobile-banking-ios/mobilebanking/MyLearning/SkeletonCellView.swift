//
//  SkeletonCellView.swift
//  MobileBanking
//
//  Created by Daniel Kimani on 07/02/2024.
//

import SwiftUI
import MBCore




struct SkeletonCellViewScreen: View {
    var body: some View {
        VStack(spacing: 50) {
            SkeletonCellView()
            SkeletonCellView()
            SkeletonCellView()
            SkeletonCellView()
        }
        .blinking(duration: 0.75)
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
    }
}

struct SkeletonCellView: View {
    let primaryColor = Color(.init(gray: 0.9, alpha: 1.0))
    let secondaryColor  = Color(.init(gray: 0.8, alpha: 1.0))
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            secondaryColor
                .frame(width: 116, height: 116)

            VStack(alignment: .leading, spacing: 6) {
                secondaryColor
                    .frame(height: 20)
                
                primaryColor
                    .frame(height: 20)
                
                primaryColor
                    .frame(width: 94, height: 15)
            }
        }
    }
}


struct BlinkViewModifier: ViewModifier {
    let duration: Double
    @State private var blinking: Bool = false
    func body(content: Content) -> some View {
        content
            .opacity(blinking ? 0.3 : 1)
            .animation(.easeInOut(duration: duration).repeatForever(), value: blinking)
            .onAppear {
                // Animation will only start when blinking value changes
                blinking.toggle()
            }
    }
}

extension View {
    func blinking(duration: Double = 1) -> some View {
        modifier(BlinkViewModifier(duration: duration))
    }
}
