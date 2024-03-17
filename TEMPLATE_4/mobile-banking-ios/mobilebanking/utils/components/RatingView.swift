//
//  RatingView.swift
//  maishafiti-uikit
//
//  Created by Eclectics on 06/09/2023.
//

import SwiftUI
import MBCore

struct RatingView: View {
    @Binding var rating: Int
    
    var body: some View {
        HStack {
            ForEach(1..<6) { star in
                Image(systemName: rating >= star ? "star.fill" : "star")
                    .foregroundColor(rating >= star ? .blue : .black)
                    .onTapGesture {
                        rating = star
                    }
            }
        }
    }
}
