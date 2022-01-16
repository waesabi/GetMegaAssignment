//
//  Helper.swift
//  GetMegaAssignment
//
//  Created by sanket kumar on 16/01/22.
//

import Foundation

func loadEntryFromDisk<T: Codable>(
    withName name: String,
    using fileManager: FileManager = .default,
    type: T.Type
) throws -> T {
    let folderURLs = fileManager.urls(
        for: .cachesDirectory,
           in: .userDomainMask
    )
    let fileURL = folderURLs[0].appendingPathComponent(name + ".cache")
    let data = try Data(contentsOf: fileURL)
    let decodedData = try JSONDecoder().decode(type, from: data)
    return decodedData
}
