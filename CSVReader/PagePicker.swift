//
//  PagePicker.swift
//  CSVReader
//
//  Created by Thomas Leonhardt on 03.05.22.
//

import SwiftUI

struct PagePicker: View {
    @State private var selectPage: Int
    var currentPage: Int
    var pages: Int
    var availablePages: [Int] {
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
            NavigationLink(destination: CSVView(page: selectPage)) {
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
        .pickerStyle(.segmented)
    }
    
    init(currentPage: Int, pages: Int) {
        self.currentPage = currentPage
        self.selectPage = currentPage
        self.pages = pages
    }
}
