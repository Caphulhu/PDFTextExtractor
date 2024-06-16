//
//  JsonReader.swift
//  PDFTextExtractor
//
//  Created by Leandro Lopes on 15/06/24.
//

import Foundation

class JsonReader {
    @Published var documentSettings: DocumentSettings?
    
    func readSettings(with strings: [String]) {
        if let path = Bundle.main.path(forResource: "settings", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                documentSettings = try decoder.decode(DocumentSettings.self, from: data)
            } catch {
                // Handle error while reading the file
                print("Error reading settings.json: \(error)")
            }
        }
    }
    
    func search(strings: [String]) -> ([String], [String])? {
        if let documentSettings = verifyStringsContainName(strings: strings) {
            let mountedValues = mountValues(in: strings, with: documentSettings)
            return mountedValues
        }
        return nil
    }

    private func verifyStringsContainName(strings: [String]) -> PaymentFormat? {
        guard let documentSettings = documentSettings else {
            return nil
        }
        
        for string in strings {
            let paymentType = documentSettings.paymentSlipType.first { paymentFormat in
                string.contains(paymentFormat.name)
            }
            
            if paymentType != nil {
                return paymentType
            }
        }
        
        return nil
    }

    private func mountValues(in strings: [String], with paymentFormat: PaymentFormat) -> ([String], [String]) {
        var keys = [String]()
        var values = [String]()
        var shouldCaptureKey = false
        var shouldCaptureValue = false
        for string in strings {
            if string.contains(paymentFormat.paymentKeys.keyEnd) {
                shouldCaptureKey = false
            }
            if string.contains(paymentFormat.paymentKeys.valueEnd) {
                shouldCaptureValue = false
            }
            
            if shouldCaptureKey {
                keys.append(string)
            }
            if shouldCaptureValue {
                values.append(contentsOf: string.components(separatedBy: " "))
            }
            
            if string.contains(paymentFormat.paymentKeys.keyStart) {
                shouldCaptureKey = true
            }
            if string.contains(paymentFormat.paymentKeys.valueStart) {
                shouldCaptureValue = true
            }
        }
        return (keys, values)
    }
    
}

struct DocumentSettings: Codable {
    let paymentSlipType: [PaymentFormat]
}

struct PaymentFormat: Codable {
    let name: String
    let paymentKeys: PaymentKeys
}

struct PaymentKeys: Codable {
    let keyStart: String
    let keyEnd: String
    let valueStart: String
    let valueEnd: String
}
