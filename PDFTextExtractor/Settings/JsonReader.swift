//
//  JsonReader.swift
//  PDFTextExtractor
//
//  Created by Leandro Lopes on 15/06/24.
//

import Foundation

class JsonReader {
    func readSettings() {
        if let path = Bundle.main.path(forResource: "settings", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let paymentSlip = try decoder.decode(PaymentSlip.self, from: data)
                
                // Process the JSON result here
                debugPrint(paymentSlip)
                
            } catch {
                // Handle error while reading the file
                print("Error reading settings.json: \(error)")
            }
        }
    }
    
    
}

struct PaymentSlip: Codable {
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
