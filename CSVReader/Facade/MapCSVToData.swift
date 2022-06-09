//
//  File.swift
//  CSVReader
//
//  Created by Thomas (privat) Leonhardt on 11.04.22.
//

import Foundation
import UIKit

struct CSVRow: Hashable, Comparable {
    var compareIndex: Int = 0
    static func < (lhs: CSVRow, rhs: CSVRow) -> Bool {
        return lhs.row[lhs.compareIndex] < rhs.row[rhs.compareIndex]
    }
    
    static func == (lhs: CSVRow, rhs: CSVRow) -> Bool {
        if lhs.columnCount != rhs.columnCount {
            return false
        }
        for i in 0...lhs.columnCount - 1 {
            if lhs.row[i] != rhs.row[i] {
                return false
            }
        }
        return true
    }
    
    fileprivate static var seperator = ";"
    var columnCount: Int {
        return row.count
    }
    private (set) var row: [String] = [String]()
    
    static func excecute(row: String) -> CSVRow {
        var csvRow = CSVRow()
        csvRow.row = row.components(separatedBy: CSVRow.seperator)
        return csvRow
    }
    
    func index(of: String) -> Int? {
        return row.firstIndex(of: of)
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

typealias CSVPageResult = (csvRows: [CSVRow], error: Error?)

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
    
    func getPage(pageNumber: Int, titleFirst: Bool = true, sortByTitle: String? = nil) -> CSVPageResult {
        var page = [CSVRow]()
        guard !rows.isEmpty else {
            return CSVPageResult(rows, nil)
        }
        for i in (pageNumber * pageSize)...(pageNumber * pageSize) + pageSize - 1 {
            let row = rows[i]
            page.append(row)
            if row == rows.last {
                break
            }
        }
        if let sort = sortByTitle {
            let result = sortPage(titleRow: sort, page: page)
            page = result.csvRows
        }
        if titleFirst {
            page.insert(titleRow, at: 0)
        }
        return CSVPageResult(page, nil)
    }
    
    private func sortPage(index: Int, page: [CSVRow]) -> CSVPageResult {
        var sortedPage = [CSVRow]()
        for var row in page {
            row.compareIndex = index
            sortedPage.append(row)
        }
        sortedPage.sort()
        return CSVPageResult(sortedPage, nil)
    }
    
    private func sortPage(titleRow: String, page: [CSVRow]) -> CSVPageResult {
        guard let rowIndex = self.titleRow.index(of: titleRow) else {
            return CSVPageResult(page, CSVError.rowNotFound)
        }
        return sortPage(index: rowIndex, page: page)
    }
}

typealias CSVDataResult = (data: CSVData?, error: Error?)

class MapCSVToData {
    
    static func excecute(csvArray: [String], pageSize: Int = 1, addLeadingNo: Bool = false) -> CSVDataResult {
        if pageSize <= 0 {
            return CSVDataResult(nil, CSVError.wrongPageSize)
        }
        var csvRows = [CSVRow]()
        for i in 0...csvArray.count - 1 {
            var row = csvArray[i]
            if addLeadingNo {
                row = MapCSVToData.addLeading(to: row, add: i)
            }
            let csvRow = CSVRow.excecute(row: row)
            csvRows.append(csvRow)
        }
        let data = CSVData.excecute(rows: csvRows, pageSize: pageSize)
        return CSVDataResult(data, nil)
    }
    
    static func addLeading(to: String, add: Int) -> String {
        var lead = String("\(add).")
        if add == 0 {
            lead = "No."
        }
        return lead + CSVRow.seperator + to
    }
}
