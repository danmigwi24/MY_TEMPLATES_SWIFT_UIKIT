//
//  CustomSwiftUIDialog.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 08/02/2024.
//

import Foundation
import SwiftUI
import MBCore



public struct CustomSwiftUIDialog<Content:View>: View {
    
    @Binding var showDialog:Bool
    let content : Content
    
    init(showDialog: Binding<Bool>, @ViewBuilder content:()-> Content) {
        self._showDialog = showDialog
        self.content = content()
    }
    
    public var body: some View{
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)){
            
            //
            VStack(spacing: 5){
                content
            }
            .padding(.horizontal,24)
            .padding(.vertical,20)
            .background(Color.white)
            .cornerRadius(8)
            .padding(.horizontal,10)
            
            
            
        }
        .onDisappear{
            showDialog = false
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        //.background(BlurView().edgesIgnoringSafeArea(.all))
        .background(Color.black.opacity(0.5).disabled(showDialog).edgesIgnoringSafeArea(.all))
        
    }
    
    
}

