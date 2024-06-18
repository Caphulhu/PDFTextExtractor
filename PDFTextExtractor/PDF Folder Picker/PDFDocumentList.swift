//
//  PDFDocumentList.swift
//  PDFTextExtractor
//
//  Created by Leandro Lopes on 16/06/24.
//

import SwiftUI
import PDFKit
import Quartz // Add this line to import the Quartz framework
import QuickLook

struct PDFDocumentList: View {
    let folderURL: URL // Replace with your actual folder path
    private var pdfDatasourse: PDFDocumentListQLDatasource
    
    init(folderURL: URL) {
        self.folderURL = folderURL
        self.pdfDatasourse = PDFDocumentListQLDatasource(folderURL: folderURL)
    }
    
    var body: some View {
        List(getPDFFileNames(), id: \.self) { fileName in
            Text(fileName)
                .onTapGesture {
                    if let fileURL = getPDFFileURL(fileName: fileName) {
                        pdfDatasourse.folderURL = fileURL
                        openPDF(fileURL: fileURL)
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

    func openPDF(fileURL: URL) {
        let preview = QLPreviewPanel.shared()
        preview?.dataSource = pdfDatasourse
        preview?.makeKeyAndOrderFront(nil)
    }
}

class PDFDocumentListQLDatasource: QLPreviewPanelDataSource {
    var folderURL: URL
    
    internal init(folderURL: URL) {
        self.folderURL = folderURL
    }
    
    func numberOfPreviewItems(in panel: QLPreviewPanel) -> Int {
        return 1
    }

    func previewPanel(_ panel: QLPreviewPanel, previewItemAt index: Int) -> QLPreviewItem {
        return folderURL as NSURL
    }
}
