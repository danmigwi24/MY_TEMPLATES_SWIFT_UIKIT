//
//  ViewController.swift
//  UIkitProgrammaticTemplateOne
//
//  Created by Daniel Kimani on 17/03/2024.
//

import UIKit
import SwiftUI
import Foundation
import MBCore

class ViewController: UIViewController {
    
    //@StateObject
    var sharedViewModel = SharedViewModel()
    //@StateObject
    var sheetNavigationViewModel = SheetNavigationViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        // Do any additional setup after loading the view.
        //self.view.addSubview(startButton)
        self.view.backgroundColor = .white
        setupUI()
    }

    //MARK: IF YOU WANT TO USE SWIFTUI USE THIS FUNCTION TO ENABLE YOU LOAD SWIFTUI VIEW
    private  func setupUI() {
        print("SwiftUI")
        // Create your SwiftUI root view
       let rootView = NavigationView{ SplashScreen()}
            .preferredColorScheme(.light)
            .environmentObject(sheetNavigationViewModel)
            .environment(\.locale, Locale.init(identifier: getUserData(key: USERDEFAULTS.USER_LANGUAGE) ))
        
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
    
    
    private lazy var startButton: UIButton = {
        let button =  UIButton(type: .system)
        button.configuration = .filled()
        button.setTitle("Let's Start", for: .normal)
        button.setTitleColor(.black, for: .normal)
       // button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        return button
    }()
    
    func setNSLayoutConstraint(){
        //
        NSLayoutConstraint.activate([
           // startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            //startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            //
            //view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: startButton.bottomAnchor,constant: 20),
            //startButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    @objc func startButtonPressed(button:UIButton){
        let vc = SignInViewController()
       // navigationController?.pushViewController(vc, animated: false)
        print("PRESSED")
    }
    
}

