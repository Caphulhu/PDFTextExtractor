//
//  PDFStringsView.swift
//  PDFTextExtractor
//
//  Created by Leandro Lopes on 14/06/24.
//

import SwiftUI
import Quartz

struct PDFStringsView: View {
    @ObservedObject var model: PDFStringsModel
    private var pdfDatasourse: PDFDocumentListQLDatasource

    
    internal init(model: PDFStringsModel) {
        self.model = model
        pdfDatasourse = PDFDocumentListQLDatasource(folderURL: model.pdfURL)
    }

    var body: some View {
        VStack {
            Text(model.title)
                .font(.largeTitle)
                .padding(.top, 20)
            HStack {
                Button("Ler valores", action: {
                    if let tuple = model.json.search(strings: model.strings) {
                        let combined = zip(tuple.0, tuple.1)
                        model.strings = combined.map({ (key, value) in
                            return "\(key) \(value)"
                        })
                    }
                })
                Button("Ver PDF", action: {
                    openPDF()
                })
            }
            List(model.strings, id: \.self) { string in
                HStack {
                    Text(string)
                    Spacer()
                    Text(string)
                }
            }
        }
    }
    
    func openPDF() {
        let preview = QLPreviewPanel.shared()
        preview?.dataSource = pdfDatasourse
        preview?.makeKeyAndOrderFront(nil)
    }
}

struct PDFStringsView_Previews: PreviewProvider {
    static var previews: some View {
        let modelPreview = PDFStringsModel(title: "Valores", strings: ["String 1", "String 2", "String 3", "String 4"], pdfURL: URL(string: "")!)
        PDFStringsView(model: modelPreview)
    }
}

#Preview {
    PDFDragDropView()
}
