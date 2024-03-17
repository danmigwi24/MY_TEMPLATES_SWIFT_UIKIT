//
//  SwiftMessagesSwiftUIView.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 20/02/2024.
//

import SwiftUI
import MBCore
import UIKit
import SwiftMessages




struct SwiftMessagesSwiftUIView: View {
    var body: some View {
        VStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            
            Button("Show Message") {
                let view = MessageView.viewFromNib(layout: .cardView)
                view.configureTheme(.success)
               // view.backgroundColor = UIColor.red // Change UIColor.red to your desired color
                view.configureContent(title: "Title", body: "Message body")
                //view.button?.setTitle("Close", for: .normal)
        
                SwiftMessages.show(view: view)
            }
            .buttonStyle(.borderedProminent)
            .background(Color.red)
            
            Button("Show Message") {
              //buttonTapped()
                showCustomizedSwiftMessages(title: "Ali Did", body: "Thank you")
            }
            .buttonStyle(.borderedProminent)
            .background(Color.red)
        }
    }
    
    @MainActor func buttonTapped() {
            let messageView: MessageView = MessageView.viewFromNib(layout: .centeredView)
            messageView.configureContent(title: "Test", body: "Yep, it works!")
            messageView.button?.isHidden = true
            messageView.iconLabel?.isHidden = true
            messageView.iconImageView?.isHidden = true
            messageView.configureTheme(backgroundColor: .black, foregroundColor: .white)
            messageView.configureDropShadow()
            messageView.configureBackgroundView(width: 200)
            //SwiftMessages.show(view: messageView)
        
            var config = SwiftMessages.defaultConfig
            config.presentationStyle = .center
           // config.presentationContext = .viewController(self)
            SwiftMessages.show(config: config, view: messageView)
        }
}

struct SwiftMessagesSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftMessagesSwiftUIView()
    }
}

