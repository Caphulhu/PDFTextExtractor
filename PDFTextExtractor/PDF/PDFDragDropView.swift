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
    @State private var isShowingDetailView = false
    
    var body: some View {
        VStack {
            Text("Arraste um boleto aqui")
                .background(.white)
                .padding(40)
                .foregroundColor(.black)
                .onDrop(of: ["public.file-url"], isTargeted: nil) { providers -> Bool in
                    if let item = providers.last {
                        if let identifier = item.registeredTypeIdentifiers.last {
                            if identifier == "public.file-url" {
                                item.loadItem(forTypeIdentifier: identifier, options: nil) { data, _ in
                                    if let data = data as? Data, let url = URL(dataRepresentation: data, relativeTo: nil) {
                                        pdfURL = url
                                        pdfDocument = PDFDocument(url: url)
                                        readPDFStrings()
                                    }
                                }
                            }
                        }
                    }
                    return true
                }
            if isPDFRead {
                NavigationLink(destination: {
                    PDFStringsView(model: PDFStringsModel(title: "Valores", strings: [""]))
                }, label: {
                    Text("Ler texto do PDF")
                })
            }
            if let pdfDocument = pdfDocument, let url = pdfDocument.documentURL {
                NavigationLink(destination: {
                    PDFKitView(url: url)
                        .padding(.top, 20)
                }, label: {
                    Text("Ver PDF")
                })
            } else {
                Text("Arraste um boleto para começar")
            }
        }
    }
    
    func readPDFStrings() {
        // Read the PDF strings
        if let pdfDocument = pdfDocument {
            pdfStrings.removeAll()
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
