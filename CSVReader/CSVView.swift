//
//  ContentView.swift
//  CSVReader
//
//  Created by Thomas (privat) Leonhardt on 10.04.22.
//

import SwiftUI

struct CSVView: View {
    @State private var csvData = CSVDataSource().data
    var body: some View {
        Form {
            ForEach(csvData!.rows, id: \.self) { csvRow in
//                let array: [String] = row.row
                HStack(alignment: .bottom) {
                    ForEach(csvRow.row, id: \.self) { text in
                        Text(text)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CSVView()
    }
}
