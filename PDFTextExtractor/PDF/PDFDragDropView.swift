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

    var body: some View {
        VStack {
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

            if let pdfDocument = pdfDocument {
                PDFKitView(url: pdfDocument.documentURL!)
            } else {
                Text("No PDF Selected")
            }
        }
    }
}

#Preview {
    PDFDragDropView()
}
