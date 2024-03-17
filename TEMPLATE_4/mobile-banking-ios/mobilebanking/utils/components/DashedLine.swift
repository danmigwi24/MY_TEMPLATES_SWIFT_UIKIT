//
//  DashedLine.swift
//  maishafiti-uikit
//
//  Created by Eclectics on 31/08/2023.
//

import SwiftUI
import MBCore

struct DashedLine: Shape {
    let dash: CGFloat = 5.0
    let gap: CGFloat = 5.0

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let y = rect.size.height / 2

        for x in stride(from: 0, to: rect.size.width, by: dash + gap) {
            path.move(to: CGPoint(x: x, y: y))
            path.addLine(to: CGPoint(x: x + dash, y: y))
        }

        return path
    }
}
