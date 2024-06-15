//
//  PDFStringsView.swift
//  PDFTextExtractor
//
//  Created by Leandro Lopes on 14/06/24.
//

import SwiftUI

struct PDFStringsView: View {
    let title: String
    let strings: [String]

    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .padding(.top, 20)
            Button("Ler valores", action: {
                
            })

            List(strings, id: \.self) { string in
                Text(string)
            }
        }
    }
}

struct PDFStringsView_Previews: PreviewProvider {
    static var previews: some View {
        PDFStringsView(title: "Valores", strings: ["String 1", "String 2", "String 3", "String 4"])
    }
}

#Preview {
    PDFDragDropView()
}
