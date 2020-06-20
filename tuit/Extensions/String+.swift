//
//  String+.swift
//  tuit
//
//  Created by Nestor Garcia on 17/06/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import Foundation

extension String {
    
    /// Resturns a random string of the specified length.
    static func random(length: Int = 10) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map { _ in letters.randomElement()! })
    }
}
