//
//  JSONDecoder+.swift
//  tuit
//
//  Created by Nestor Garcia on 17/06/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import Foundation

extension JSONDecoder {

    /// Common json decoder to use for all repositories.
    static var tuit: JSONDecoder {
        let decoder = JSONDecoder()
        return decoder
    }
}
