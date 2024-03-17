//
//  CustomSpacer.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 08/02/2024.
//

import Foundation
import SwiftUI
import MBCore

struct CustomSpacer: View {
    var height: CGFloat
    
    var body: some View {
        Rectangle()
            .frame(height: height)
            .foregroundColor(.clear)
    }
}
