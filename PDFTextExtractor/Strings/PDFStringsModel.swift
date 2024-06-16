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
    var title: String
    @Published var strings: [String]
    let json = JsonReader()
    
    internal init(title: String, strings: [String]) {
        self.title = title
        self.strings = strings
        setup(strings: strings)
        json.readSettings(with: strings)
    }
    
    private func setup(strings: [String]) {
        var finalArray = [String]()
        for string in strings {
            finalArray.append(contentsOf: string.components(separatedBy: "\n"))
        }
        self.strings = finalArray
    }
}
