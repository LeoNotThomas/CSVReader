//
//  PagePicker.swift
//  CSVReader
//
//  Created by Thomas Leonhardt on 03.05.22.
//

import SwiftUI

struct PagePicker: View {
    @State private var selectPage: Int
    private var source: CSVDataSource
    private var currentPage: Int
    private var pages: Int
    private var availablePages: [Int] {
        var availablePages = [Int]()
        for i in 0...pages {
            if i != currentPage {
                availablePages.append(i)
            }
        }
        return availablePages
    }
    var body: some View {
        if currentPage != selectPage {
            NavigationLink(destination: CSVView(page: selectPage, source: source)) {
                pickerView
            }
        } else {
            pickerView
        }
    }
    
    private var pickerView: some View {
        return Picker("Choose Page", selection: $selectPage) {
            ForEach(availablePages, id: \.self) {
                Text("\($0 + 1)")
            }
        }
        .pickerStyle(.menu)
    }
    
    init(currentPage: Int, pages: Int, source: CSVDataSource) {
        self.currentPage = currentPage
        self.selectPage = currentPage
        self.pages = pages
        self.source = source
    }
}
