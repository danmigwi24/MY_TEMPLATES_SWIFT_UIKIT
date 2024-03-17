//
//  FormContentView.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 07/03/2024.
//

import Foundation
import SwiftUI

struct FormContentView: View {
    
    @State var isDarkModeEnabled: Bool = true
    @State var downloadViaWifiEnabled: Bool = false
    
    var body: some View {
     
            Form {
                Group {
                    HStack{
                        Spacer()
                        VStack {
                            //                            Image(uiImage: UIImage(named: "UserProfile")!)
                            Image("mb_logo")
                                .resizable()
                                .frame(width:100, height: 100, alignment: .center)
                            Text("Wolf Knight")
                                .font(.title)
                            Text("WolfKnight@kingdom.tv")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Spacer()
                            Button(action: {
                                print("Edit Profile tapped")
                            }) {
                                Text("Edit Profile")
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .font(.system(size: 18))
                                    .padding()
                                    .foregroundColor(.white)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 25)
                                            .stroke(Color.white, lineWidth: 2)
                                    )
                            }
                            .background(Color.blue)
                            .cornerRadius(25)
                        }
                        Spacer()
                    }
                }
                
                Section(header: Text("CONTENT"), content: {
                    HStack{
                        //Image(uiImage: UIImage(named: "Favorite")!)
                        Image("mb_logo")
                        Text("Favorites")
                    }
                    
                    HStack{
                        //Image(uiImage: UIImage(named: "Download")!)
                        Image("mb_logo")
                        Text("Downloads")
                    }
                    
                })
                
                Section(header: Text("PREFRENCES"), content: {
                    HStack{
                        //Image(uiImage: UIImage(named: "Language")!)
                        Image("mb_logo")
                        Text("Language")
                    }
                    HStack{
                        //Image(uiImage: UIImage(named: "DarkMode")!)
                        Image("mb_logo")
                        Toggle(isOn: $isDarkModeEnabled) {
                            Text("Dark Mode")
                        }
                    }
                    HStack{
                        //Image(uiImage: UIImage(named: "DownloadViaWifi")!)
                        Image("mb_logo")
                        Toggle(isOn: $downloadViaWifiEnabled) {
                            Text("Only Download via Wi-Fi")
                        }
                    }
                    HStack{
                        //Image(uiImage: UIImage(named: "PlayInBackground")!)
                        Image("mb_logo")
                        Text("Play in Background")
                    }
                    
                })
            }
            .navigationBarTitle("Settings")
        
        
    }
}
