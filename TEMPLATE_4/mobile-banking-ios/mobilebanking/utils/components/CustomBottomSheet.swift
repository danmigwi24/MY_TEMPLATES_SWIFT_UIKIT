//
//  CustomBottomSheet.swift
//  maishafiti-uikit
//
//  Created by Daniel Kimani on 08/10/2023.
//

import Foundation
import SwiftUI
import MBCore

struct CustomBottomSheet<Content: View> :View {
    let content:Content
    @Binding var sheetShown:Bool
    @Binding var sheetDismissal:Bool
    let height:CGFloat
    
    init(
        sheetShown:Binding<Bool>,
        sheetDismissal:Binding<Bool>,
        height:CGFloat,
        @ViewBuilder content:()-> Content
    ){
        self.height = height
        _sheetShown = sheetShown
        _sheetDismissal = sheetDismissal
        self.content = content()
    }
    
    var body: some View {
        ZStack{
            //REST OF BACKGROUND
            GeometryReader{ _ in
                EmptyView()
            }
            .background(Color.gray.opacity(0.5))
            .opacity(sheetShown ? 1 : 0)
            .animation(Animation.easeIn)
            .onTapGesture {
                self.dismissSheet()
            }
            
            //SHEET IS SELF
            VStack{
                Spacer()
                VStack{
                    content
                        .padding(.bottom,30)
                   /*
                    Button(action: {
                        self.dismissSheet()
                    }, label: {
                        Text("Dismiss")
                            .foregroundColor(Color)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    })
                    */
                }
                .background(Color.white)
                .frame(height: height)
                .offset(y: sheetDismissal && sheetShown ? 0 : height)
                .animation(Animation.default.delay(0.2))
                
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
     
    func dismissSheet(){
        sheetShown.toggle()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2, execute: {
            sheetDismissal.toggle()
        })
    }
}
