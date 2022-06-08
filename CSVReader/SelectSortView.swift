//
//  SwiftUIView.swift
//  CSVReader
//
//  Created by Thomas (privat) Leonhardt on 07.06.22.
//

import SwiftUI

struct SelectSortView: View {
    @State var selection: String
    var titleRow: CSVRow
    var body: some View {
        Picker("Please choose a color", selection: $selection) {
            ForEach(titleRow.row, id: \.self) {
                Text($0)
            }
        }
    }
    
    init(titleRow: CSVRow) {
        self.titleRow = titleRow
        selection = titleRow.row[0]
    }
}
