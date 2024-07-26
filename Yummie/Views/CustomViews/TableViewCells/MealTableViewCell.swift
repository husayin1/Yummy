//
//  MealTableViewCell.swift
//  Yummie
//
//  Created by husayn on 05/07/2024.
//

import UIKit

class MealTableViewCell: UITableViewCell {
    @IBOutlet weak var mealImage: UIImageView!
    
    @IBOutlet weak var mealName: UILabel!
    
    static let identifier = String(describing: MealTableViewCell.self)
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupMealTableViewCell(dish: FilteredDishes){
//        self.mealImage.kf.setImage(with: dish.strMealThumb.asUrl)
        self.mealImage.setImage(dish.strMealThumb)
        self.mealName.text = dish.strMeal        
    }
    
}
