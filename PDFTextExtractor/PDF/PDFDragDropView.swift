//
//  File.swift
//  PDFTextExtractor
//
//  Created by Leandro Lopes on 14/06/24.
//

import SwiftUI
import PDFKit

struct PDFDragDropView: View {
    @State private var pdfURL: URL?
    @State private var pdfDocument: PDFDocument?
    @State private var pdfStrings: [String] = []
    @State private var isPDFRead: Bool = false
    @State private var showPDFStringsView: Bool = false
    
    var body: some View {
        if showPDFStringsView {
            PDFStringsView(title: "Valores", strings: pdfStrings)
        } 

        VStack {
            if isPDFRead {
                Button("Ver Valores") {
                    showPDFStringsView.toggle()
                }
                .padding(.top, 20)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            Text("Drag and Drop PDF Here")
                .onDrop(of: ["public.file-url"], isTargeted: nil) { providers -> Bool in
                    if let item = providers.first {
                        if let identifier = item.registeredTypeIdentifiers.first {
                            if identifier == "public.file-url" {
                                item.loadItem(forTypeIdentifier: identifier, options: nil) { data, _ in
                                    if let data = data as? Data, let url = URL(dataRepresentation: data, relativeTo: nil) {
                                        pdfURL = url
                                        pdfDocument = PDFDocument(url: url)
                                    }
                                }
                            }
                        }
                    }
                    return true
                }
            
            if let pdfDocument = pdfDocument, let url = pdfDocument.documentURL {
                PDFKitView(url: url)
                    .padding(.top, 20)
                    .onAppear(perform: readPDFStrings)
            } else {
                Text("No PDF Selected")
            }
        }
    }
    
    func readPDFStrings() {
        // Read the PDF strings
        if let pdfDocument = pdfDocument {
            for i in 0..<pdfDocument.pageCount {
                if let page = pdfDocument.page(at: i) {
                    if let pageContent = page.attributedString {
                        let string = pageContent.string
                        pdfStrings.append(string)
                    }
                }
            }
            isPDFRead = true
            debugPrint(pdfStrings)
        }
    }
}

#Preview {
    PDFDragDropView()
}
