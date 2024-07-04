//
//  DishesCollectionViewCell.swift
//  Yummie
//
//  Created by husayn on 04/07/2024.
//

import UIKit

class DishesCollectionViewCell: UICollectionViewCell {

    static let identifier = String(describing: DishesCollectionViewCell.self)
    
    @IBOutlet private weak var dishTitle: UILabel!
    
    @IBOutlet private weak var dishImageView: UIImageView!
    
    @IBOutlet private weak var dishCategory: UILabel!
    
    @IBOutlet private weak var dishCountry: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupDishCollectionCell(dish: FilteredDishes){
        self.dishTitle.text = dish.strMeal
        dishImageView.kf.setImage(with: dish.strMealThumb.asUrl)
        
    }

}
