//
//  MealDetailViewModel.swift
//  Yummie
//
//  Created by husayn on 04/07/2024.
//

import Foundation

class MealDetailsViewModel {
    
    var currentMeal:SpecialMeal?{
        didSet{
            bindCurrentMealToMealDetailsView()
        }
    }
    
    var bindCurrentMealToMealDetailsView : (()->())={}
    
  
    
    func fetchSpecialMealById(id:String){
        APIClient.getMealById(id: id) { [weak self] result in
            switch result {
            case .success(let meal):
                self?.currentMeal = meal.meal.first
            case .failure(let err):
                print("Error Fetching Meal By Id \(err.localizedDescription)")
            }
        }
    }
    
   
}
