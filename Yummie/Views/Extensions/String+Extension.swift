//
//  String+Extension.swift
//  Yummie
//
//  Created by husayn on 03/07/2024.
//

import Foundation

extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
}
