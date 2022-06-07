//
//  ErrorView.swift
//  CSVReader
//
//  Created by Thomas Leonhardt on 25.05.22.
//

import SwiftUI

struct ErrorView: View {
    var error: Error
    var body: some View {
        Text("Shit happens :)")
    }
    
    init(error: Error) {
        self.error = error
    }
}
