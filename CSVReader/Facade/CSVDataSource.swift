//
//  CSVDataSource.swift
//  CSVReader
//
//  Created by Thomas (privat) Leonhardt on 12.04.22.
//

import Foundation

class CSVDataSource {
    var data: CSVData!
    init() {
        if let path = Bundle(for: type(of: self)).path(forResource: "persons", ofType: "csv") {
            guard let fileContent = try? FileReader.excecute(file: path) else {
                return
            }
            data = MapCSVToData.excecute(csvArray: fileContent, pageSize: 3)
        }
    }
}
