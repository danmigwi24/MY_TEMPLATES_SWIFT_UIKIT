//
//  Snackbar.swift
//  maishafiti-uikit
//
//  Created by Daniel Kimani on 28/09/2023.
//

import SwiftUI
import MBCore

struct Snackbar: View {
    let text: String

    var body: some View {
        Text(text)
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .background(Color.secondary)
            .foregroundColor(Color.white)
            .cornerRadius(10)
            .padding(.horizontal)
            //.offset(y: -50) // Adjust this value to control the Snackbar's position
    }
}

extension View {
    func snackbarAtTop(isPresented: Binding<Bool>, text: String) -> some View {
        ZStack(alignment: .bottom) {
            self
            if isPresented.wrappedValue {
                Snackbar(text: text)
                    .transition(.slide)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                isPresented.wrappedValue = false
                            }
                        }
                    }
            }
        }
    }
    
    func snackbarAtCenter(isPresented: Binding<Bool>, text: String) -> some View {
           ZStack {
               self
               if isPresented.wrappedValue {
                   Snackbar(text: text)
                       .transition(.slide)
                       .frame(maxWidth: .infinity, maxHeight: .infinity)
                       .background(Color.black.opacity(0.3))
                       .edgesIgnoringSafeArea(.all)
                       .onAppear {
                           DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                               withAnimation {
                                   isPresented.wrappedValue = false
                               }
                           }
                       }
               }
           }
       }
    func snackbarAtBottom(isPresented: Binding<Bool>, text: String) -> some View {
            ZStack {
                self
                if isPresented.wrappedValue {
                    Snackbar(text: text)
                        .transition(.slide)
                        .frame(maxWidth: .infinity, alignment: .bottom)
                        //.background(Color.black.opacity(0.3))
                        .edgesIgnoringSafeArea(.all)
                        .offset(y: UIScreen.main.bounds.height / 2 - 30) // Adjust the value to position it as desired
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    isPresented.wrappedValue = false
                                }
                            }
                        }
                }
            }
        }
  
}
