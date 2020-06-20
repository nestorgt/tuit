//
//  Parser.swift
//  tuit
//
//  Created by Nestor Garcia on 17/06/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import Foundation

/// Helper to manipulate strings <> dictionaries in form of JSON.
struct Parser {
    
    /// Transform a string into a Dicrionary.
    static func JSON(from string: String?) -> [String: Any]? {
        guard let data = string?.data(using: .utf8) else { return nil }
        do {
            let dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
            return dict
        } catch let error as NSError {
            Log.message("Can't create dict with string: \(string ?? "<nil>. Error: \(error)")",
                level: .error, type: .parser)
            return nil
        }
    }
    
    /// Transform a string into Data.
    static func JSONData(from string: String) -> Data? {
        return string.data(using: .utf8)
    }
}
