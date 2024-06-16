//
//  PDFStringsModel.swift
//  PDFTextExtractor
//
//  Created by Leandro Lopes on 15/06/24.
//

import Foundation
import SwiftUI

@MainActor
class PDFStringsModel: ObservableObject {
    @Published var title: String
    @Published var strings: [String]
    
    internal init(title: String, strings: [String]) {
        self.title = title
        self.strings = strings
        
        let json = JsonReader()
        json.readSettings()
    }
}
