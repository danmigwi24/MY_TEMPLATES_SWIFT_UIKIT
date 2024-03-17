//
//  StickyHeadeContentView.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 22/02/2024.
//

import Foundation
import SwiftUI
import MBCore

/*
 
 
 */
struct StickyHeadeContentView: View {
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Thank you")
                /*
                ForEach(0..<50) { index in
                    Text("Row \(index)")
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                }
                 */
            }
            .padding(.top, 50)
            .frame(maxWidth: .infinity)
            .padding()
        }
        .overlay(
            StickyHeaderView(title: "Sticky Header")
                .frame(height: 50) // Set the height of your sticky header
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .opacity(0.9)
        , alignment: .top)
        .frame(maxWidth: .infinity)
    }
}

struct StickyHeaderView: View {
    var title:String
    @State private var offset: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            Text(title)
                .foregroundColor(.white)
                .padding()
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
                .background(Color(hexString: CustomColors.darkBlue))
                .offset(y: min(0, -offset))
                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                    self.offset = value
                }
        }
        .frame(height: 50) // Set the height of your sticky header
    }
}

// Preference key to track scroll offset
struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

// View modifier to update scroll offset preference
struct TrackScrollOffset: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .named("scrollView")).minY)
                }
            )
    }
}

extension View {
    func trackScrollOffset() -> some View {
        self.modifier(TrackScrollOffset())
    }
}

