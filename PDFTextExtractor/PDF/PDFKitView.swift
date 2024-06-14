//
//  PDFView.swift
//  PDFTextExtractor
//
//  Created by Leandro Lopes on 14/06/24.
//

import SwiftUI
import PDFKit

struct PDFKitView: NSViewRepresentable {
    let url: URL

    func makeNSView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: url)
        pdfView.autoScales = true
        return pdfView
    }

    func updateNSView(_ pdfView: PDFView, context: Context) {
        // Update pdf view if needed
    }
}
