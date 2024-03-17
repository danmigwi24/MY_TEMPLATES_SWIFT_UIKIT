//
//  ToggleViewSectionScreen.swift
//  MobileBanking
//
//  Created by Daniel Kimani on 06/02/2024.
//



import SwiftUI
import MBCore

struct EmailList: Identifiable {
    var id: String
    var isSubscribed = false
}

struct ToggleViewSectionScreen: View {
    @State private var isSwitchOn = true
    
        @State private var lists = [
                EmailList(id: "Monthly Updates", isSubscribed: true),
                EmailList(id: "News Flashes", isSubscribed: true),
                EmailList(id: "Special Offers", isSubscribed: true)
            ]

            var body: some View {
                Form {
                            Section {
                                ForEach($lists) { $list in
                                    Toggle(list.id, isOn: $list.isSubscribed)
                                }
                            }

                            Section {
                                if #available(iOS 16.0, *) {
                                    Toggle(sources: $lists, isOn: \.isSubscribed) {
                                        Text("Subscribe to all")
                                    }
                                } else {
                                    // Fallback on earlier versions
                                    ToggleView(isOn: $isSwitchOn) { isOn in
                                                   print("Switch is \(isOn ? "ON" : "OFF")")
                                               }
                                }
                            }
                        }
            }
 
}








/**
 
 
 @ViewBuilder
 func InputField() -> some View {
     VStack{
         EGTextField(text: $phoneNumber)
             .setTitleText("Phone Number")
             .setTitleColor(.black)
             .setTitleFont(.body)
             .setPlaceHolderText("Eg. +254712345678")
             .setPlaceHolderTextColor(Color.gray)
             .setError(errorText: $sharedViewModel.errorText, error: $errorPhoneNumber)
         
         DropDownField()
         
         EGTextField(text: $accountNumber)
             .setTitleText("Account Number")
             .setTitleColor(.black)
             .setTitleFont(.body)
             .setPlaceHolderText("Eg. 01000012345678")
             .setPlaceHolderTextColor(Color.gray)
             .setError(errorText:  $sharedViewModel.errorText, error: $errorAccountNumber)
     }.padding(.vertical,10)
 }
 
 */
