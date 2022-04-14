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
    @State var selectPage = 1
    var pages: [Int] {
        var pages = [Int]()
        let count = Int(ceil(Double((csvData?.rowCount ?? 0)/pageEntrys)))
        for i in 0...count {
            if i != page {
                pages.append(i)
            }
        }
        return pages
    }
    var body: some View {
        List {
            if let rows = csvData?.getPage(pageNumber: page) {
                ForEach(rows, id: \.self) { csvRow in
                    HStack(alignment: .bottom, spacing: 0) {
                        ForEach(csvRow.row, id: \.self) { text in
                            GeometryReader { geo in
                                Text(text)
                            }
                        }
                    }
                }
                NavigationLink(destination: CSVView(page: selectPage)) {
                    Picker("Choose Page", selection: $selectPage) {
                        ForEach(pages, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
        }
        .navigationTitle("Page: \(page)")
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
