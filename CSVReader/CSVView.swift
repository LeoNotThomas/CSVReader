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
        Form {
            let rows = getPage()
            ForEach(rows, id: \.self) { csvRow in
                HStack(alignment: .bottom, spacing: 10) {
                    ForEach(csvRow.row, id: \.self) { text in
                        Text(text)
                            .frame(width: 100,  alignment: .leading)
                            .background(.red)
                    }
                }
            }
            if rows.last != csvData?.rows.last {
                NavigationLink(destination: CSVView(page: page + 1)) {
                Text("Choose Tails")
                }
            }
        }
        .navigationTitle("Page: \(page)")
    }
    
    private func getPage() -> [CSVRow] {
        var rows = [CSVRow]()
        for i in (page * pageEntrys)...(page * pageEntrys) + pageEntrys - 1 {
            if let row = csvData?.rows[i] {
                rows.append(row)
                if row == csvData?.rows.last {
                    break
                }
            }
        }
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
