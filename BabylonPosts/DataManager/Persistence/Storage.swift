//
//  Storage.swift
//  BabylonPosts
//
//  Created by Li Linyu on 22/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import Foundation

public class Storage {

    enum Directory {
        case documents
        case caches
    }

    static private func getURL(for directory: Directory) -> URL {
        var searchPathDirectory: FileManager.SearchPathDirectory

        switch directory {
        case .documents:
            searchPathDirectory = .documentDirectory
        case .caches:
            searchPathDirectory = .cachesDirectory
        }

        if let url = FileManager.default.urls(for: searchPathDirectory, in: .userDomainMask).first {
            return url
        } else {
            fatalError("Could not create URL for system directory!")
        }
    }

    static func store<T: Encodable>(_ object: T, to directory: Directory, as fileName: String) {
        let url = getURL(for: directory).appendingPathComponent(fileName, isDirectory: false)

        if let data = try? JSONEncoder().encode(object) {
            try? FileManager.default.removeItem(at: url)
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        }
    }

    static func retrieve<T: Decodable>(_ fileName: String, from directory: Directory, as type: T.Type) -> T? {
        let url = getURL(for: directory).appendingPathComponent(fileName, isDirectory: false)

        guard let data = FileManager.default.contents(atPath: url.path) else {
            return nil
        }

        return try? JSONDecoder().decode(type, from: data)
    }
}
