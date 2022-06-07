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
        let result = FileReader.excecute(file: path)
        guard let fileContent = result.data else {
            error = result.error
            return
        }
        data = MapCSVToData.excecute(csvArray: fileContent, pageSize: pageSize, addLeadingNo: true)
    }
}
