//
//  CSVDataSource.swift
//  CSVReader
//
//  Created by Thomas (privat) Leonhardt on 12.04.22.
//

import Foundation

class CSVDataSource {
    var data: CSVData!
    var error: Error?
    init(path: URL, pageSize: Int = 3) {
        let readResult = FileReader.excecute(file: path)
        guard let fileContent = readResult.data else {
            error = readResult.error
            return
        }
        let mapResult = MapCSVToData.excecute(csvArray: fileContent, pageSize: pageSize, addLeadingNo: true)
        guard let data = mapResult.data else {
            error = mapResult.error
            return
        }
        self.data = data
    }
}
