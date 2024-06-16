//
//  PDFDocumentList.swift
//  PDFTextExtractor
//
//  Created by Leandro Lopes on 16/06/24.
//

import SwiftUI

struct PDFDocumentList: View {
    let folderURL: URL? // Replace with your actual folder path

    var body: some View {
        List(getPDFFileNames(), id: \.self) { fileName in
            Text(fileName)
        }
    }

    func getPDFFileNames() -> [String] {
        guard let folderURL = folderURL else { return [""] }
        let fileManager = FileManager.default
        if let files = try? fileManager.contentsOfDirectory(atPath: folderURL.relativePath) {
            return files.filter { $0.hasSuffix(".pdf") }
        }
        return []
    }
}
