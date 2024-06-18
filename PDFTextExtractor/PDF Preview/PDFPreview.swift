//
//  PDFPreview.swift
//  PDFTextExtractor
//
//  Created by Leandro Lopes on 17/06/24.
//

import Foundation
import Quartz // Add this line to import the Quartz framework
import QuickLook

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
