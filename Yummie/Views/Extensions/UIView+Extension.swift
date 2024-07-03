//
//  UIView+Extension.swift
//  Yummie
//
//  Created by husayn on 03/07/2024.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.cornerRadius
        }
        set{
            self.layer.cornerRadius = newValue
        }
    }
}
