//
//  PDFDocumentList.swift
//  PDFTextExtractor
//
//  Created by Leandro Lopes on 16/06/24.
//

import SwiftUI
import PDFKit


struct PDFDocumentList: View {
    let folderURL: URL // Replace with your actual folder path
    private var pdfDatasourse: PDFDocumentListQLDatasource
    @State private var pdfName: String?
    @State private var pdfURL: URL?
    
    init(folderURL: URL) {
        self.folderURL = folderURL
        self.pdfDatasourse = PDFDocumentListQLDatasource(folderURL: folderURL)
    }
    
    var body: some View {
        if let pdfURL = pdfURL {
            NavigationLink(destination: {
                PDFKitView(url: pdfURL)
            }) {
                Text("ABRIR \(pdfName ?? "")")
            }
            NavigationLink(destination: {
                PDFStringsView(model: PDFStringsModel(title: "Valores", strings: StringUtils.readPDFStrings(at: pdfURL), pdfURL: pdfURL))
            }) {
                Text("LER \(pdfName ?? "")")
            }
        }
        List(getPDFFileNames(), id: \.self) { fileName in
            Text(fileName)
                .onTapGesture {
                    if let fileURL = getPDFFileURL(fileName: fileName) {
                        pdfURL = fileURL
                        pdfName = fileName
                    }
                }
        }
    }

    func getPDFFileNames() -> [String] {
        let fileManager = FileManager.default
        if let files = try? fileManager.contentsOfDirectory(atPath: folderURL.relativePath) {
            return files.filter { $0.hasSuffix(".pdf") }
        }
        return []
    }

    func getPDFFileURL(fileName: String) -> URL? {
        return folderURL.appendingPathComponent(fileName)
    }
}


