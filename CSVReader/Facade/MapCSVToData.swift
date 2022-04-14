//
//  File.swift
//  CSVReader
//
//  Created by Thomas (privat) Leonhardt on 11.04.22.
//

import Foundation

struct CSVRow: Hashable {
    private var seperator = ";"
    private (set) var columnCounts = [Int]()
    var columns: Int {
        return columnCounts.count
    }
    private (set) var row: [String] = [String]()
    
    static func excecute(rows: String) -> CSVRow {
        var csvRow = CSVRow()
        csvRow.row = rows.components(separatedBy: csvRow.seperator)
        for value in csvRow.row {
            csvRow.columnCounts.append(value.count)
        }
        return csvRow
    }
}

struct CSVData {
    private (set) var maxCounts = [Int]()
    private (set) var rows: [CSVRow]! {
        didSet {
            titleRow = rows[0]
            rows.remove(at: 0)
        }
    }
    private (set) var titleRow: CSVRow!
    private (set) var columns = 0
    static func excecute(rows: [CSVRow]) -> CSVData {
        var csvData = CSVData()
        csvData.rows = rows
        for row in rows {
            csvData.columns = max(csvData.columns, row.columns)
            if csvData.maxCounts.isEmpty {
                csvData.maxCounts = row.columnCounts
                continue
            }
            for i in 0...row.columns - 1 {
                if i == csvData.maxCounts.count {
                    csvData.maxCounts.append(row.columnCounts[i])
                    continue
                }
                csvData.maxCounts[i] = max(csvData.maxCounts[i], row.columnCounts[i])
            }
        }
        return csvData
    }
}

class MapCSVToData {
    static func excecute(csvArray: [String]) -> CSVData {
        var csvRows = [CSVRow]()
        for row in csvArray {
            let csvRow = CSVRow.excecute(rows: row)
            csvRows.append(csvRow)
        }
        return CSVData.excecute(rows: csvRows)
    }
}
