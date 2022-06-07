//
//  FileReader.swift
//  CSVReader
//
//  Created by Thomas (privat) Leonhardt on 11.04.22.
//

import Foundation

enum CSVError: Error {
    case reading
    case invalidFile
}
typealias FileReaderResult = (data: [String]?, error: Error?)

class FileReader {
    static func excecute(file: URL) -> FileReaderResult {
        do {
            try checkFile(url: file)
            let content = try String(contentsOf: file)
            let parsedCSV: [String] = content.components(
                separatedBy: "\n"
            ).map{ $0.components(separatedBy: ",")[0] }
              return FileReaderResult(parsedCSV, nil)
            }
        catch {
            return FileReaderResult(nil, error)
        }
    }
    
    internal static func checkFile(url: URL) throws {
        if url.pathExtension != "csv" {
            throw CSVError.invalidFile
        }
    }
}
