//
//  CSVReaderTests.swift
//  CSVReaderTests
//
//  Created by Thomas (privat) Leonhardt on 10.04.22.
//

import XCTest
@testable import CSVReader

class CSVReaderTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
        
    func testInvalidFile() {
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: "persons", withExtension: "txt")
        let result = FileReader.excecute(file: url!)
        XCTAssertTrue(result.error as? CSVError == CSVError.invalidFile, "File is valid")
    }
    
    func testReadCSV() {
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: "persons", withExtension: "csv")
        let result = FileReader.excecute(file: url!)
        XCTAssertTrue(result.data?.count == 8, "Wrong Count FileReader")
    }
    
    func testWrongPageSize() {
        let csv = ["Name;Age;City",
                   "Peter;42;New York",
                   "Jaques;66;Paris",
                   "Stephanie;47;Stockholm;Dänemark"]
        
        let result = MapCSVToData.excecute(csvArray: csv, pageSize: 0)
        XCTAssertTrue(result.error as? CSVError == CSVError.wrongInput, "Count Columns Incorrect")
    }
    
    func testCsvRow() {
        let result = CSVRow.excecute(row: "0;1;2;3;4")
        XCTAssertTrue(result.row.count == 5, "Wrong Count CSVRow")
    }
    
    func testMapCSV() {
        let csv = ["Name;Age;City",
                   "Peter;42;New York",
                   "Jaques;66;Paris",
                   "Stephanie;47;Stockholm"]
        
        let result = MapCSVToData.excecute(csvArray: csv)
        XCTAssertTrue(result.data?.columnsCount == 4, "Count Columns Incorrect")
    }
    
    func testWidthColums() {
        var csv = ["111;111;111",
                   "111;111;111"]
        var csvData = MapCSVToData.excecute(csvArray: csv).data!
        var calculator = CSVCalculater(rows: csvData.getPage(pageNumber: 0).csvRows)
        let result = calculator.widthColums(font: UIFont.systemFont(ofSize: 20))
        csv = ["11111111111;111;111",
               "111;11111111111;111"]
        csvData = MapCSVToData.excecute(csvArray: csv).data!
        calculator = CSVCalculater(rows: csvData.getPage(pageNumber: 0).csvRows)
        let compareResult = calculator.widthColums(font: UIFont.systemFont(ofSize: 20))
        XCTAssertFalse(result[0] >= compareResult[0] || result[1] > compareResult[1] || result[2] != compareResult[2], "Estimates of width wrong" )
    }
    
    func testEqualRow() {
        let csv = ["Peter;42;New York",
                   "Peter;42;New York"]
        let csvData = MapCSVToData.excecute(csvArray: csv, pageSize: 2, addLeadingNo: false).data!
        let page = csvData.getPage(pageNumber: 0).csvRows
        XCTAssertTrue(page[0] == page[1], "Rows must be equal")
    }
    
    func testSortedPage() {
        let csv = ["Name;Age;City",
                   "Peter;42;New York",
                   "Jaques;66;Paris",
                   "Stephanie;47;Stockholm"]
        let csvData = MapCSVToData.excecute(csvArray: csv, pageSize: 3, addLeadingNo: false).data!
        let page = csvData.getPage(pageNumber: 0, titleFirst: true, sortByTitle: "Name").csvRows
        XCTAssertTrue(page[0] == CSVRow.excecute(row: "Name;Age;City") && page[1] == CSVRow.excecute(row: "Jaques;66;Paris") && page[2] == CSVRow.excecute(row: "Peter;42;New York"), "Wrong sort")
    }
}
