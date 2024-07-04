//
//  CategoryCollectionViewCell.swift
//  Yummie
//
//  Created by husayn on 03/07/2024.
//

import UIKit
import Kingfisher

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var categoryImageView: UIImageView!
   
    @IBOutlet private weak var categoryLabel: UILabel!
    static let identifier = String(describing: CategoryCollectionViewCell.self)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCategoryCell(category: DishCategory){
        self.categoryLabel.text = category.strCategory
        categoryImageView.kf.setImage(with: category.strCategoryThumb.asUrl)
        
    }
    
    func changeColor(to color: UIColor) {
//        self.contentView.backgroundColor = color // Change to desired color
        self.categoryLabel.textColor = color // Change to desired color
        self.contentView.cornerRadius = 10
    }

}
