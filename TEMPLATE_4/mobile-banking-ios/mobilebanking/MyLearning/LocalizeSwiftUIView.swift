//
//  LocalizeSwiftUIView.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 19/02/2024.
//

import SwiftUI
import MBCore
import Combine
import Localize_Swift



struct LocalizeSwiftUIView: View {
    
    let languages = ["en", "fr"]
    @State private var selectedLanguageIndex = 0
       
       var body: some View {
           VStack {
               Text("welcome_message".localized())
                   .font(.title)
                   
               
               Menu {
                   ForEach(0..<languages.count) { index in
                       Button(action: {
                           self.selectedLanguageIndex = index
                           Localize.setCurrentLanguage(self.languages[index])
                       }) {
                           Text(self.languages[index])
                       }
                   }
               } label: {
                   Text("Select Language")
                       .font(.title)
                       .foregroundColor(Color.black)
                       .padding()
               }
                          .frame(maxWidth: .infinity)
              // .padding()
           }
           .background(Color.gray)
           .onReceive(Just(selectedLanguageIndex)) { index in
            Localize.setCurrentLanguage(self.languages[index])
            }
          
       }
}



struct LocalizeSwiftUIView2: View {
    @State private var selectedLanguage = "en"
    
    let languages = ["en", "fr"]
    
    var body: some View {
        VStack {
            Text("welcome_message")
                .font(.title)
                .padding()
            
            Text("LocalizeSwiftUIView.welcome_message")//.localized())
                .font(.title)
                .padding()
            
            Text("introduction-string \(getUserData(key:USERDEFAULTS.USER_NAME))")//.localized())
                .font(.title)
                .padding()
            
            Text("welcome_message".localized())
                .font(.title)
                .padding()
            
           //
            Menu(content: {
                VStack{
                    ForEach(languages, id: \.self) { item in
                        Button(action: {
                            selectedLanguage = item
                           
                        }, label: {
                            Text(item)
                        })
                    }
                }
            }, label: {
                HStack{
                    Text(selectedLanguage).padding()
                    Spacer()
                }
            }).padding()
            
        }
        .onReceive(Just(selectedLanguage)) { index in
                  // Localize.setCurrentLanguage(selectedLanguage)
               //localizationViewModel.setLanguage(selectedLanguage)
               }
    }
}

