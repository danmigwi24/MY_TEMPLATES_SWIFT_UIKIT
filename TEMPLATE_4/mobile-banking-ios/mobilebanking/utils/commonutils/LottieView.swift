//
//  LottieView.swift
//  Deliverance IOS App
//
//  Created by Eclectics on 18/05/2023.
//

import SwiftUI
import MBCore

import Lottie

struct LottieView: UIViewRepresentable {
    var name: String
    var loopMode: LottieLoopMode = .loop
    
   
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        
        let animationView = LottieAnimationView(name: name)
        
        let view = UIView(frame: .zero)
        
       // animationView.animation = Animation.named(name)
        //animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.play()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {}
}


struct LottieViewBegin: UIViewRepresentable {
    var name: String
    var loopMode: LottieLoopMode = .playOnce
    
    func makeUIView(context: Context) -> Lottie.LottieAnimationView {
        
        let animationView = LottieAnimationView(name: name)
        //let view = UIView(frame: .zero)
        animationView.loopMode = loopMode
        animationView.play()

        return animationView
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}
