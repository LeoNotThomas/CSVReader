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
    
    func testReadCSV() {
        let path = Bundle(for: type(of: self)).path(forResource: "persons", ofType: "csv")
        guard let result = try? FileReader.excecute(file: path!) else {
            XCTAssertTrue(false, "Can't read data.")
            return
        }
        XCTAssertTrue(result.count == 8, "Wrong Count FileReader")
    }
    
    func testCsvRow() {
        let result = CSVRow.excecute(row: "0;1;2;3;4")
        XCTAssertTrue(result.row.count == 5, "Wrong Count CSVRow")
    }
    
    func testMapCSV() {
        let csv = ["Name;Age;City",
                   "Peter;42;New York",
                   "Jaques;66;Paris",
                   "Stephanie;47;Stockholm;Dänemark"]
        
        let result = MapCSVToData.excecute(csvArray: csv)
        XCTAssertTrue(result.columnsCount == 4, "Count Columns Incorrect")
    }
    
    func testWidthColums() {
        var csv = ["111;111;111",
                   "111;111;111"]
        var csvData = MapCSVToData.excecute(csvArray: csv)
        var calculator = CSVCalculater(rows: csvData.getPage(pageNumber: 0))
        let result = calculator.widthColums(font: UIFont.systemFont(ofSize: 20))
        csv = ["11111111111;111;111",
               "111;11111111111;111"]
        csvData = MapCSVToData.excecute(csvArray: csv)
        calculator = CSVCalculater(rows: csvData.getPage(pageNumber: 0))
        let compareResult = calculator.widthColums(font: UIFont.systemFont(ofSize: 20))
        XCTAssertFalse(result[0] >= compareResult[0] || result[1] > compareResult[1] || result[2] != compareResult[2], "Estimates of width wrong" )
    }
}
