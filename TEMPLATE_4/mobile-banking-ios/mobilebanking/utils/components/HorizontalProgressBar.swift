//
//  HorizontalProgressBar.swift
//  maishafiti-uikit
//
//  Created by Dan Migwi on 2023/9/23.
//

import SwiftUI
import MBCore

struct HorizontalProgressBar: View {
    var percentage: Double // Value between 0 and 1 representing the progress
    var height: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule()
                    .frame(width: geometry.size.width, height: height)
                    .foregroundColor(Color(hexString: CustomColors.lightGray)) // Background color
                
                Capsule()
                    .frame(width: CGFloat(self.percentage) * geometry.size.width, height: height)
                    .foregroundColor(Color(hexString: CustomColors.darkBlue)) // Progress color
            }
        }.frame(maxHeight: 10,alignment: .center)
    }
}


struct HorizontalUIProgressViewBar: UIViewRepresentable {
    @Binding var progress: Float
    //let maxValue: Float // The maximum value the progress represents

    func makeUIView(context: Context) -> UIProgressView {
        let progressView = UIProgressView()
                progressView.trackTintColor = UIColor.gray
                progressView.progressTintColor = UIColor.white
        updateProgress(progressView)
        return progressView
    }

    func updateUIView(_ uiView: UIProgressView, context: Context) {
        updateProgress(uiView)
    }

    private func updateProgress(_ progressView: UIProgressView) {
        //let normalizedProgress = max(0, min(progress, 100)) / 100
        let normalizedProgress = max(0, min(progress, 100)) //* 100
        Logger("updateProgress \(normalizedProgress)",showLog: false)
        progressView.setProgress(normalizedProgress, animated: true)
    }
}

