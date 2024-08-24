//
//  OnboardingCollectionViewCell.swift
//  Yummie
//
//  Created by husayn on 03/07/2024.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var onboardingImage: UIImageView!
    
    
    @IBOutlet private weak var onboardingTitle: UILabel!
    
    @IBOutlet private weak var onboardingBody: UILabel!
    static let identifier = String(describing: OnboardingCollectionViewCell.self)
    
    func setupSlide(_ slide: OnboardingSlide){
        self.onboardingImage.image = slide.image
        self.onboardingTitle.text = slide.title
        self.onboardingBody.text = slide.description
    }
}



/*
 command N (create New file)
 comman Shift O (Open Quickly)
 hold and option (open two windows)
 
 
 */
