//
//  InternetConnectionChecker.swift
//  maishafiti-uikit
//
//  Created by Daniel Kimani on 23/01/2024.
//

import Foundation
import SwiftUI
import MBCore
import Combine

class InternetConnectionChecker: ObservableObject {
    @Published var     isConnected: Bool = true
    
    private var     cancellables: Set<AnyCancellable> = []

    init() {
        checkInternetConnection()
    }

    func checkInternetConnection() {
        guard  let   url = URL(string: "https://www.apple.com") else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { _ in true }
            .replaceError(with: false)
            .receive(on: DispatchQueue.main)
            .assign(to: \.isConnected, on: self)
            .store(in: &cancellables)
    }
}

public struct InternetConnectionCheckerContentView: View {
    @StateObject private var     internetConnectionChecker = InternetConnectionChecker()
    
   public var     body: some View {
        VStack {
            if internetConnectionChecker.isConnected {
                Text("You have internet connection.")
            } else {
                Text("No internet connection.")
            }
        }
        .onAppear {
            // You can also use this to recheck internet connection when the view appears
            internetConnectionChecker.checkInternetConnection()
        }
    }
}
