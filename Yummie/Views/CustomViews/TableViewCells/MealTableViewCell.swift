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
    
    @IBOutlet weak var mealCountry: UILabel!
    static let identifier = "MealTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupMealTableViewCell(dish: SpecialMeal){
        self.mealImage.kf.setImage(with: dish.strMealThumb.asUrl)
        self.mealName.text = dish.strMeal
        self.mealCountry.text = dish.strArea
        
    }
    
}
