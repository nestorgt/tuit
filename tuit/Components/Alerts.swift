//
//  Alerts.swift
//  tuit
//
//  Created by Nestor Garcia on 17/06/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import UIKit

/// Provides custom alert controllers.
struct Alerts {
    
    /// Custom configurable alert with an `Ok` button.
    static func standard(title: String?,
                         message: String?,
                         actionOkTitle: String = NSLocalizedString("generic-ok")) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: actionOkTitle, style: .cancel)
        alertController.addAction(okAction)
        return alertController
    }
}
