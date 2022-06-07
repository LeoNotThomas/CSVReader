//
//  MainView.swift
//  CSVReader
//
//  Created by Thomas (privat) Leonhardt on 13.04.22.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
//            CSVView()
            CsvArgView()
        }
        .navigationViewStyle(.stack)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
