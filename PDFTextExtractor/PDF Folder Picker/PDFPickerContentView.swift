//
//  PDFPickerContentView.swift
//  PDFTextExtractor
//
//  Created by Leandro Lopes on 16/06/24.
//

import SwiftUI

struct PDFPickerContentView: View {
    @State private var selectedFolderURL: URL?
    
    var body: some View {
        VStack {
            PDFFolderPickerView(selectedFolderURL: selectedFolderURL)
            if let selectedFolderURL = selectedFolderURL {
                PDFDocumentList(folderURL: selectedFolderURL)
            }
        }
    }
}
