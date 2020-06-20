//
//  UIView+.swift
//  tuit
//
//  Created by Nestor Garcia on 17/06/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import UIKit

extension UIView {
    
    // MARK: - Add Subview
    
    /// Adds a array of subviews to self
    ///
    /// - Parameter subviews: the array of subviews to be added
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { addSubview($0) }
    }

    /// Adds a subview to self and sets it's translatesAutoresizingMaskIntoConstraints property to false
    ///
    /// - Parameter subview: the subview to be added
    func addSubviewForAutoLayout(_ subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
    }

    /// Adds a array of subviews to self and sets their translatesAutoresizingMaskIntoConstraints property to false
    ///
    /// - Parameter subviews: the array of subviews to be added
    func addSubviewsForAutoLayout(_ subviews: [UIView]) {
        subviews.forEach { addSubviewForAutoLayout($0) }
    }
}
