//
//  FileReader.swift
//  CSVReader
//
//  Created by Thomas (privat) Leonhardt on 11.04.22.
//

import Foundation

enum CommonError: Error {
    case readError
}

class FileReader {
    static func excecute(file: String) throws -> [String]? {
        do {
            let content = try String(contentsOfFile: file)
            let parsedCSV: [String] = content.components(
                separatedBy: "\n"
            ).map{ $0.components(separatedBy: ",")[0] }
              return parsedCSV
            }
        catch {
            throw CommonError.readError
        }
    }
}
