//
//  ViewController.swift
//  UIkitProgrammaticTemplateOne
//
//  Created by Daniel Kimani on 17/03/2024.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemPink
        setupUI()
    }

    //MARK: IF YOU WANT TO USE SWIFTUI USE THIS FUNCTION TO ENABLE YOU LOAD SWIFTUI VIEW
    private  func setupUI() {
        // Create your SwiftUI root view
       let rootView = NavigationView{MainSwiftUIView()}.preferredColorScheme(.light)
       //let rootView = MainSwiftUIView().preferredColorScheme(.light)
        
        //let rootView = NavigationView{Step3StartActivityScreen()}.preferredColorScheme(.light).environmentObject(activityTracker)
        
        // Set edgesIgnoringSafeArea to .all except .bottom
        let viewController = UIHostingController(rootView: rootView)
        viewController.edgesForExtendedLayout = [.top, .left, .right] // Ignore only the top, left, and right safe areas
        addChild(viewController)
        view.addSubview(viewController.view)
        
        // Set up Auto Layout constraints
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            viewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        viewController.didMove(toParent: self)
    }
    
}

