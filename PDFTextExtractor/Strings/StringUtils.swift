//
//  StringUtils.swift
//  PDFTextExtractor
//
//  Created by Leandro Lopes on 18/06/24.
//

import Foundation
import PDFKit

struct StringUtils {
    
    static func readPDFStrings(at url: URL) -> [String] {
        // Read the PDF strings
        var pdfStrings = [String]()
        if let pdfDocument = PDFDocument(url: url) {
            for i in 0..<pdfDocument.pageCount {
                if let page = pdfDocument.page(at: i) {
                    if let pageContent = page.attributedString {
                        let string = pageContent.string
                        pdfStrings.append(string)
                    }
                }
            }
        }
        return pdfStrings
    }
}
