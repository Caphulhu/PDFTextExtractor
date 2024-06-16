//
//  PDFFolderPickerView.swift
//  PDFTextExtractor
//
//  Created by Leandro Lopes on 16/06/24.
//

import SwiftUI
import UniformTypeIdentifiers

struct PDFFolderPickerView: View {
    @State var selectedFolderURL: URL?
    
    var body: some View {
        VStack {
            Text("Select a folder of PDFs")
                .font(.title)
            Button(action: pickFolder) {
                Text("Select Folder")
            }
            .padding()
            Text(selectedFolderURL?.path ?? "No folder selected")
            PDFDocumentList(folderURL: selectedFolderURL)
        }
    }
    
    func pickFolder() {
        let openPanel = NSOpenPanel()
        openPanel.canChooseDirectories = true
        openPanel.allowsMultipleSelection = false
        openPanel.begin { response in
            if response == .OK, let url = openPanel.url {
                selectedFolderURL = url
            }
        }
    }
}
