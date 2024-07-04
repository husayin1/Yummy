//
//  ChefSpecialCollectionViewCell.swift
//  Yummie
//
//  Created by husayn on 04/07/2024.
//

import UIKit

class ChefSpecialCollectionViewCell: UICollectionViewCell {

    static let identifier = String(describing:  ChefSpecialCollectionViewCell.self)
    
    @IBOutlet weak var mealImageView: UIImageView!
    
    @IBOutlet weak var mealNameLabel: UILabel!
    
    @IBOutlet weak var mealCategoryLabel: UILabel!
    
    @IBOutlet weak var mealCountryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupChefSpecialCollectionViewCell(special: SpecialMeal){
        mealImageView.kf.setImage(with: special.strMealThumb.asUrl)
        self.mealNameLabel.text = special.strMeal
        self.mealCategoryLabel.text = special.strCategory
        self.mealCountryLabel.text = special.strArea
    }

}
