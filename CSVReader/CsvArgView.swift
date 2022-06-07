//
//  CsvArgView.swift
//  CSVReader
//
//  Created by Thomas Leonhardt on 25.05.22.
//

import SwiftUI

struct CsvArgView: View {
    @State private var file: URL?
    @State private var pageSize: String = ""
    @State private var showPicker = false
           
    var body: some View {
        VStack(spacing: 0) {
            Text(file?.absoluteString  ?? "Choose a File!")
            Divider()
            Button("Pick File") {
                showPicker = true
            }
            .sheet(isPresented: $showPicker) {
                DocumentPicker(path: $file)
            }
            TextField("PageSize", text: $pageSize)
                .padding(8)
                .keyboardType(.numberPad)
    
            if let pageSize = Int(pageSize), let file = file {
                let source = CSVDataSource(path: file, pageSize: pageSize)
                if let error = source.error {
                    NavigationLink("Error", destination: ErrorView(error: error))
                } else {
                    NavigationLink("Show It", destination: CSVView(source: source))
                }
            }
        }
    }
}
