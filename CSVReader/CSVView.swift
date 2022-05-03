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
    @State var page: Int
    let entryFont = UIFont.systemFont(ofSize: 20)
    var pages: Int {
        return Int(ceil(Double((csvData?.rowCount ?? 0)/pageEntrys)))
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
            if let rows = csvData?.getPage(pageNumber: page) {
                ForEach(rows, id: \.self) { csvRow in
                    LazyVGrid(columns: columns(page: rows)) {
                        ForEach(csvRow.row, id: \.self) { text in
                            Text(text)
                                .font(Font(entryFont as CTFont))
                        }
                    }
                }
                PagePicker(currentPage: page, pages: pages)
            }
        }
        .navigationTitle("Page: \(page + 1)/\(pages + 1)")
        .padding()
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
