//
//  MealDetailViewController.swift
//  Yummie
//
//  Created by husayn on 04/07/2024.
//

import UIKit

class MealDetailViewController: UIViewController {
    
    @IBOutlet weak var mealImageView: UIImageView!
    
    @IBOutlet weak var mealTitleLabel: UILabel!
    
    @IBOutlet weak var mealCountryLabel: UILabel!
    
    @IBOutlet weak var mealInstructionsLabel: UILabel!
    
    var mealViewModel: MealDetailsViewModel!
    
    var mealId: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        mealViewModel = MealDetailsViewModel()
        mealViewModel.fetchSpecialMealById(id: mealId)
        
        
        mealViewModel.bindCurrentMealToMealDetailsView = {[weak self] () in
            self?.populateMealView()
        }
    }
    
    func populateMealView(){
        self.mealTitleLabel.text = mealViewModel.currentMeal?.strMeal
        self.mealCountryLabel.text = mealViewModel.currentMeal?.strArea
        self.mealInstructionsLabel.text = mealViewModel.currentMeal?.strInstructions
        mealImageView.kf.setImage(with: mealViewModel.currentMeal?.strMealThumb.asUrl)
    }
    
    
}
