//
//  ResultManager.swift
//  Race
//
//  Created by Volha Furs on 27.04.22.
//

import Foundation

class ResultsManager {
    
//    var fileName = Date()
    
    static func saveResults(result: ResultGame) {
        let result = result
        let resultData = try? JSONEncoder().encode(result)
        guard let resultData = resultData else {
            return
        }
        let documentsUrl = documentsUrl()
        let resultPath = documentsUrl?.appendingPathComponent("result")
        guard let resultPath = resultPath else {
            return
        }
        if !FileManager.default.fileExists(atPath: resultPath.path) {
            FileManager.default.createFile(atPath: resultPath.path, contents: nil, attributes: nil)
        }
        if let handle = try? FileHandle(forWritingTo: resultPath) {
            var array: [ResultGame] = loadData() ?? []
            array.append(result)
            let resultDataArray = try? JSONEncoder().encode(array)
            handle.write(resultDataArray ?? Data()) // adding content

            handle.closeFile() // closing the file
        }
    }
    
    static func loadData() -> [ResultGame]? {
        let documentsUrl = documentsUrl()
        let resultPath = documentsUrl?.appendingPathComponent("result")
        guard let resultPath = resultPath else {
            return nil
        }
        guard let content = try? FileHandle(forReadingAtPath: resultPath.path)?.readToEnd() else {
            return nil
        }
        guard let result = try? JSONDecoder().decode([ResultGame].self, from: content) else {
            return nil
        }
        return result
    }
    static func checkFiles() -> Bool {
        let fileManager = FileManager.default
        let url = documentsUrl()
        guard let url = url else {
            return false
        }
        let fileNames = try? fileManager.contentsOfDirectory(atPath: url.path)
        guard let fileNames = fileNames else {
            return false
        }
        return !fileNames.isEmpty
    }
    
    static func documentsUrl() -> URL? {
        let fileManager = FileManager.default
        let url = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            return url
    }
}
