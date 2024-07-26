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
    
    func setupAreaCell(area: Area){
        self.categoryLabel.text = (area.strArea == "Unknown" ? "Palestine" : area.strArea)
//        categoryImageView.kf.setImage(with: img.asUrl)
        self.categoryImageView.setImage(area.setThumbnail(for: area.strArea))
        
    }
    
}
