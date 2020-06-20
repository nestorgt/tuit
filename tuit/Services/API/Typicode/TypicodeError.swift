//
//  TypicodeError.swift
//  tuit
//
//  Created by Nestor Garcia on 17/06/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import Foundation

/// Possible errors returned by the Typicode Service.
enum TypicodeError: Error, Equatable {
    
    case api(APIError)
    case generic(message: String?)
    
    var description: String {
        switch self {
        case .api(let error):
            return "api error: \(error)"
        case .generic(let message):
            return "generic error: \(message.unwrappedDescription)"
        }
    }
}
