//
//  ContentView.swift
//  CSVReader
//
//  Created by Thomas (privat) Leonhardt on 10.04.22.
//

import SwiftUI

struct CSVView: View {
    @State private var source: CSVDataSource
    @State private var sortName = "No."
    private var pageEntrys: Int {
        return source.data.pageSize
    }
    private var page: Int
    private let entryFont = UIFont.systemFont(ofSize: 20)
    private var pages: Int {
        return Int(ceil(Double((source.data.rowCount)/pageEntrys)))
    }
    
    func columns(page: [CSVRow]) -> [GridItem] {
        var grid = [GridItem]()
        let calculator = CSVCalculater(rows: page)
        let widthCols = calculator.widthColums(font: entryFont)
        for i in 0...widthCols.count - 1 {
            let item = GridItem(.fixed(widthCols[i]))
            grid.append(item)
        }
        return grid
    }
    
    var body: some View {
        List {
            if let rows = source.data.getPage(pageNumber: page, sortByTitle: sortName).csvRows {
                ForEach(rows, id: \.self) { csvRow in
                    LazyVGrid(columns: columns(page: rows)) {
                        ForEach(csvRow.row, id: \.self) { text in
                            Text(text)
                                .font(Font(entryFont as CTFont))
                        }
                    }
                }
                PagePicker(currentPage: page, pages: pages, source: source)
            }
        }
        .navigationTitle("Page: \(page + 1)/\(pages + 1)")
        .padding()
        .navigationBarItems(trailing: Picker("Sorted by: " + sortName , selection: $sortName, content: {
            ForEach(source.data.titleRow.row, id: \.self) {
                Text($0)
            }
        }))
    }
    
    init(page: Int = 0, source: CSVDataSource) {
        self.page = page
        self.source = source
    }
}
