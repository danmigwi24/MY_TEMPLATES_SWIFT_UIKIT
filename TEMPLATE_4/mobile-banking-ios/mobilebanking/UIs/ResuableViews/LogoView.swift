//
//  LogoView.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 07/02/2024.
//

import SwiftUI
import MBCore

struct LogoView: View {
    var body: some View {
        VStack{
            Image("mb_logo")
                .resizable()
                .frame(width:160,height: 36)
                .scaledToFit()
                //.background(Color.blue)
        }
        
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
