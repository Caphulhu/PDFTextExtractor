//
//  PDFStringsView.swift
//  PDFTextExtractor
//
//  Created by Leandro Lopes on 14/06/24.
//

import SwiftUI

struct PDFStringsView: View {
    @ObservedObject var model: PDFStringsModel
    
    internal init(model: PDFStringsModel) {
        self.model = model
    }

    var body: some View {
        VStack {
            Text(model.title)
                .font(.largeTitle)
                .padding(.top, 20)
            Button("Ler valores", action: {
                if let tuple = model.json.search(strings: model.strings) {
                    let combined = zip(tuple.0, tuple.1)
                    model.strings = combined.map({ (key, value) in
                        return "\(key) \(value)"
                    })
                }
            })

            List(model.strings, id: \.self) { string in
                Text(string)
            }
        }
    }
}

struct PDFStringsView_Previews: PreviewProvider {
    static var previews: some View {
        let modelPreview = PDFStringsModel(title: "Valores", strings: ["String 1", "String 2", "String 3", "String 4"])
        PDFStringsView(model: modelPreview)
    }
}

#Preview {
    PDFDragDropView()
}
