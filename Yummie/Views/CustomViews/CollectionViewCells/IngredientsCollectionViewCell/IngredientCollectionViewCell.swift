//
//  IngredientCollectionViewCell.swift
//  Yummie
//
//  Created by husayn on 05/07/2024.
//

import UIKit

class IngredientCollectionViewCell: UICollectionViewCell {

    static let identifier = String(describing:  IngredientCollectionViewCell.self)

    @IBOutlet weak var ingredientsImageView: UIImageView!
    
    @IBOutlet weak var ingredientTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setupIngredientCollectionViewCell(ingredint: Ingredient){
        self.ingredientTitleLabel.text = ingredint.strIngredient
        let img = "https://www.themealdb.com/images/ingredients/" + ingredint.strIngredient + ".png"
        
//        self.ingredientsImageView.kf.setImage(with: formatText(img).asUrl)
        self.ingredientsImageView.setImage(formatText(img))

    }
    func formatText(_ strInstructions: String) -> String {
        return strInstructions.replacingOccurrences(of: " ", with: "%20")
    }

}
