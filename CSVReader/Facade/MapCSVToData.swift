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
    var columnCount: Int {
        return columnCounts.count
    }
    private (set) var row: [String] = [String]()
    
    static func excecute(row: String) -> CSVRow {
        var csvRow = CSVRow()
        csvRow.row = row.components(separatedBy: csvRow.seperator)
        for value in csvRow.row {
            csvRow.columnCounts.append(value.count)
        }
        return csvRow
    }
}

struct CSVData {
    private (set) var maxCounts = [Int]()
    private (set) var maxStrings = [String]()
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
        for row in rows {
            csvData.columnsCount = max(csvData.columnsCount, row.columnCount)
            if csvData.maxCounts.isEmpty {
                csvData.maxCounts = row.columnCounts
                continue
            }
            for i in 0...row.columnCount - 1 {
                if i == csvData.maxCounts.count {
                    csvData.maxCounts.append(row.columnCounts[i])
                    continue
                }
                csvData.maxCounts[i] = max(csvData.maxCounts[i], row.columnCounts[i])
            }
        }
        return csvData
    }
    
    func getPage(pageNumber: Int) -> [CSVRow] {
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
        page.insert(titleRow, at: 0)
        return page
    }
}

class MapCSVToData {
    static func excecute(csvArray: [String], pageSize: Int = 0, addSequence: Bool = false) -> CSVData {
        var csvRows = [CSVRow]()
        for row in csvArray {
            let csvRow = CSVRow.excecute(row: row)
            csvRows.append(csvRow)
        }
        return CSVData.excecute(rows: csvRows, pageSize: pageSize)
    }
}
