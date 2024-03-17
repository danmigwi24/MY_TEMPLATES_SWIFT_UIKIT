//
//  AdCollectionView.swift
//  maishafiti-uikit
//
//  Created by Daniel Kimani on 12/10/2023.
//

import Foundation
import SwiftUI
import MBCore



class TimerManager: ObservableObject {
    @Published var timer: Timer?
    var updateIndexAction: (() -> Void)?
    
    func setupTimer() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
            DispatchQueue.main.async {
                withAnimation {
                    // Call the closure to update the currentIndex
                    self.updateIndexAction?()
                }
            }
        }
        RunLoop.current.add(self.timer!, forMode: .common)
    }
}


    
struct InfiniteHorizontalScrollView: View {
    let images = ["ad1", "ad2", "ad3", "ad4"]
    
    @State private var currentIndex = 0
    @State private var isLongPressing = false
    @StateObject private var timerManager = TimerManager()
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ForEach(images.indices, id: \.self) { index in
                            Image(images[index])
                                .resizable()
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .cornerRadius(10)
                            /*
                                .gesture(LongPressGesture(minimumDuration: 1.0)
                                    .onChanged { isPressing in
                                        if isPressing {
                                            // Long press started, pause the timer
                                            self.timerManager.timer?.invalidate()
                                            self.isLongPressing = true
                                        } else {
                                            // Long press ended, resume the timer
                                            self.isLongPressing = false
                                            self.timerManager.setupTimer()
                                        }
                                    }
                                )
                            */
                        }
                    }
                    //.frame(width: geometry.size.width * CGFloat(images.count), height: geometry.size.height)
                }
                .content.offset(x: -CGFloat(currentIndex) * geometry.size.width)
                
                /*
                HStack {
                    ForEach(images.indices, id: \.self) { index in
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundColor(index == currentIndex ? Color.blue : .red)
                    }
                }
                .padding(.bottom, 10)
                */
                
            }
            .onAppear {
                ///*
            
                timerManager.setupTimer()
                timerManager.updateIndexAction = {
                    self.currentIndex = (self.currentIndex + 1) % self.images.count
                }
              
                 //*/
            }
        }
        .frame(height: 200)
    }
}







struct InfiniteHorizontalScrollView2: View {
    let images = ["ad1", "ad2", "ad3", "ad4"]
    @State private var currentIndex = 0
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ForEach(images.indices, id: \.self) { index in
                            Image(images[index])
                                .resizable()
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .cornerRadius(10) // Optional: Add corner radius
                        }
                    }
                    .frame(width: geometry.size.width * CGFloat(images.count), height: geometry.size.height)
                }
                
                .content.offset(x: -CGFloat(currentIndex) * geometry.size.width)
                .onAppear {
                    
                    let timer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { _ in
                        withAnimation {
                            currentIndex = (currentIndex + 1) % images.count
                        }
                    }
                    
                    RunLoop.current.add(timer, forMode: .common)
                    
                }
                
                HStack {
                    ForEach(images.indices, id: \.self) { index in
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundColor(index == currentIndex ? Color(hexString: CustomColors.blue) : .gray)
                    }
                }
                .padding(.bottom, 10)
                
            }
        }
        .frame(height: 200) // Set your desired height here
    }
}




struct InfiniteHorizontalScrollViewNoIndictors: View {
    let images = ["ad1", "ad2", "ad3", "ad4"]
    @State private var currentIndex = 0
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(images.indices, id: \.self) { index in
                        Image(images[index])
                            .resizable()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .cornerRadius(10) // Optional: Add corner radius
                    }
                }
                .frame(width: geometry.size.width * CGFloat(images.count), height: geometry.size.height)
            }
            .content.offset(x: -CGFloat(currentIndex) * geometry.size.width)
            .onAppear {
                let timer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { _ in
                    withAnimation {
                        currentIndex = (currentIndex + 1) % images.count
                    }
                }
                RunLoop.current.add(timer, forMode: .common)
            }
        }
        .frame(height: 200) // Set your desired height here
    }
}





