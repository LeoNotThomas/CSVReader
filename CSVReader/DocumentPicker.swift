//
//  DocumentPicker.swift
//  CSVReader
//
//  Created by Thomas Leonhardt on 07.06.22.
//

import SwiftUI
import Foundation

struct DocumentPicker: UIViewControllerRepresentable {
    @Binding var path: URL?
    func makeCoordinator() -> DocumentPickerCoordinator {
        return DocumentPickerCoordinator(path: $path)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentPicker>) -> UIDocumentPickerViewController {
        let controller = UIDocumentPickerViewController(forOpeningContentTypes: [.text])
        controller.allowsMultipleSelection = false
        controller.shouldShowFileExtensions = true
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<DocumentPicker>) {
        
    }
}

class DocumentPickerCoordinator: NSObject, UIDocumentPickerDelegate {
    @Binding var path: URL?
    init(path: Binding<URL?>) {
        _path = path
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else {
            return
        }
        self.path = url
    }
    
}
