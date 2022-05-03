//
//  File.swift
//  CSVReader
//
//  Created by Thomas (privat) Leonhardt on 11.04.22.
//

import Foundation
import UIKit

struct CSVRow: Hashable {
    private var seperator = ";"
    var columnCount: Int {
        return row.count
    }
    private (set) var row: [String] = [String]()
    
    static func excecute(row: String) -> CSVRow {
        var csvRow = CSVRow()
        csvRow.row = row.components(separatedBy: csvRow.seperator)
        return csvRow
    }
}

class CSVCalculater {
    let rows: [CSVRow]
    
    init(rows: [CSVRow]) {
        self.rows = rows
    }
    
    func widthColums(font: UIFont) -> [CGFloat] {
        var result = [CGFloat]()
        let rows: [CSVRow] = rows
        for csvRow in rows {
            var i = 0
            for col in csvRow.row {
                let length = col.width(font: font)
                if result.count < csvRow.row.count {
                    result.append(length)
                    continue
                }
                if result[i] < length {
                   result[i] = length
                }
                i += 1
            }
        }
        return result
    }
}

struct CSVData {
    private (set) var rows: [CSVRow]! {
        didSet {
            titleRow = rows[0]
            rows.remove(at: 0)
        }
    }
    private (set) var titleRow: CSVRow!
    private (set) var columnsCount = 0
    var rowCount: Int {
        return rows.count
    }
    var pageSize: Int
    static func excecute(rows: [CSVRow], pageSize: Int) -> CSVData {
        var csvData = CSVData(pageSize: pageSize)
        csvData.rows = rows
        csvData.columnsCount = csvData.titleRow.columnCount
        for csvRow in rows {
            csvData.columnsCount = max(csvData.columnsCount, csvRow.columnCount)
        }
        return csvData
    }
    
    func getPage(pageNumber: Int, titleFirst: Bool = true) -> [CSVRow] {
        var page = [CSVRow]()
        guard !rows.isEmpty else {
            return rows
        }
        for i in (pageNumber * pageSize)...(pageNumber * pageSize) + pageSize - 1 {
            let row = rows[i]
            page.append(row)
            if row == rows.last {
                break
            }
        }
        if titleFirst {
            page.insert(titleRow, at: 0)
        }
        return page
    }
}

class MapCSVToData {
    static func excecute(csvArray: [String], pageSize: Int = 1) -> CSVData {
        var csvRows = [CSVRow]()
        for row in csvArray {
            let csvRow = CSVRow.excecute(row: row)
            csvRows.append(csvRow)
        }
        return CSVData.excecute(rows: csvRows, pageSize: pageSize)
    }
}
