//
//  PDFViewer.swift
//  maishafiti-uikit
//
//  Created by Daniel Kimani on 07/10/2023.
//

import Foundation
import SwiftUI
import MBCore
import PDFKit

/**
 PDFViewer(pdfName: "sample")
 */
struct PDFViewContainer: View {
    let pdfName: String

    var body: some View {
        PDFViewRepresentable(pdfName: pdfName)
    }
}

struct PDFViewRepresentable: UIViewRepresentable {
    let pdfName: String
    let pdfView = PDFView()

    func makeUIView(context: Context) -> UIView {
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        if let pdfURL = Bundle.main.url(forResource: pdfName, withExtension: "pdf") {
            if let document = PDFDocument(url: pdfURL) {
                pdfView.document = document
            }
        }
    }
}



/**
 PDFViewerWithURL(pdfURL: pdfURL)
 */

struct PDFViewerWithURL: UIViewRepresentable {
    var pdfURL: URL

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        if let pdfDocument = PDFDocument(url: pdfURL) {
            uiView.document = pdfDocument
        }
    }
}
