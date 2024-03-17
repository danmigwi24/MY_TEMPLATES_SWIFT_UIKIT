//
//  SampleDailog.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 08/02/2024.
//

import Foundation
import SwiftUI
import MBCore


struct SampleDailog:View{
    @Binding var showDialog:Bool
    let action:()->()
    
    var body: some View{
        VStack(spacing: 25){
            
            Image("onboarding_1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50,height: 50)
               
            
            Text("title")
                .font(.title)
                .foregroundColor(.black)
                .vSpacingWithMaxWidth(.center)
            Text("subtitble")
                .font(.body)
                .foregroundColor(.black)
                .vSpacingWithMaxWidth(.center)
            
            Button(action: {
                //showDialog.toggle()
                action()
            }, label: {
                Text("buttonText")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical,10)
                    .padding(.horizontal,25)
                    .background(Color.blue)
                    .clipShape(Capsule())
                    .vSpacingWithMaxWidth(.center)
                
            })
            
        }.padding(.vertical,20).padding(.horizontal,20)
    }
}
