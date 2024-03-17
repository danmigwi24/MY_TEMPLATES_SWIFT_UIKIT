//
//  WebViewUI.swift
//  maishafiti-uikit
//
//  Created by Daniel Kimani on 26/09/2023.
//

import Foundation
import SwiftUI
import MBCore
import WebKit


struct WebViewUI: UIViewRepresentable {
    let urlString: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }

    func updateUIView2(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            DispatchQueue.global(qos: .background).async {
                let request = URLRequest(url: url)
                DispatchQueue.main.async {
                    uiView.load(request)
                }
            }
        }
    }

}
