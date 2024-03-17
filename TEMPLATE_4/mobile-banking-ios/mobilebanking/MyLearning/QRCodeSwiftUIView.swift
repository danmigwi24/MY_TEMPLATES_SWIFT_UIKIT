//
//  QRCodeSwiftUIView.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 09/02/2024.
//

import SwiftUI
import MBCore
import CodeScanner

struct QRCodeSwiftUIView: View {
    @State var isPresentingScanner = false
   @State var scannerCodeDetails:String =  "Scan code details"
    
    
    var scannerSheet : some View{
        CodeScannerView(
            codeTypes: [.qr])
        { results in
            if case let .success(code) = results {
                self.scannerCodeDetails = code.string
                self.isPresentingScanner = false
            }
        }
    }
    var body: some View {
        VStack(spacing: 10) {
            Text(scannerCodeDetails)
            
            Button(action: {
                self.isPresentingScanner = true
            }, label: {
                Text("Scan QR Code").padding(20).foregroundColor(.white).background(Color.brown)
            })
        }.sheet(isPresented: $isPresentingScanner) {
            self.scannerSheet
        }
    }
}

struct QRCodeSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeSwiftUIView()
    }
}
