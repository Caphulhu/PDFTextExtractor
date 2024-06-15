//
//  Coordinator.swift
//  PDFTextExtractor
//
//  Created by Leandro Lopes on 14/06/24.
//

import SwiftUI

protocol Coordinator: AnyObject {
    associatedtype RootView: View
    func start()
}
