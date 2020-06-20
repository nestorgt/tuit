//
//  Localizable+.swift
//  tuit
//
//  Created by Nestor Garcia on 17/06/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import Foundation

/// Short version of `public func NSLocalizedString(_ key: String, tableName: String? = nil, bundle: Bundle = Bundle.main, value: String = "", comment: String) -> String`
func NSLocalizedString(_ key: String) -> String {
    NSLocalizedString(key, comment: "")
}
