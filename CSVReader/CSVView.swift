//
//  ContentView.swift
//  CSVReader
//
//  Created by Thomas (privat) Leonhardt on 10.04.22.
//

import SwiftUI

struct CSVView: View {
    @State private var csvData = CSVDataSource().data
    private let pageEntrys = 3
    var page: Int
    var body: some View {
        List {
            let rows = getPage()
            ForEach(rows, id: \.self) { csvRow in
                HStack(alignment: .bottom, spacing: 0) {
                    ForEach(csvRow.row, id: \.self) { text in
                        GeometryReader { geo in
                            Text(text)
                        }
                    }
                }
            }
            if rows.last != csvData?.rows.last {
                NavigationLink(destination: CSVView(page: page + 1)) {
                Text("Next Page")
                }
            }
        }
        .navigationTitle("Page: \(page)")
        .padding()
    }
    
    private func getPage() -> [CSVRow] {
        var rows = [CSVRow]()
        guard let csvData = csvData, !csvData.rows.isEmpty else {
            return rows
        }
        for i in (page * pageEntrys)...(page * pageEntrys) + pageEntrys - 1 {
            let row = csvData.rows[i]
            rows.append(row)
            if row == csvData.rows.last {
                break
            }
        }
        rows.insert(csvData.titleRow, at: 0)
        return rows
    }
    
    init(page: Int = 0) {
        self.page = page
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CSVView()
    }
}
