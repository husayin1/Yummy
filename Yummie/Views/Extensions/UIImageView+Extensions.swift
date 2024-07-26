//
//  UIImageView+Extensions.swift
//  Yummie
//
//  Created by husayn on 25/07/2024.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    public func setImage(_ urlString: String) {
        guard let imageURL = URL(string: urlString) else {
            self.image = Constant.defaultImage
            return
        }
        
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: imageURL,
            placeholder: Constant.defaultImage,
            options: [
                .transition(.fade(0.2)),
                .cacheOriginalImage
            ]
        )
    }
}
