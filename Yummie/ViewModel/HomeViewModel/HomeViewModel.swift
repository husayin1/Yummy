//
//  HomeViewModel.swift
//  Yummie
//
//  Created by husayn on 03/07/2024.
//

import Foundation

class HomeViewModel {
    
    var categories:[DishCategory]?{
        didSet{
            bindCategoriesToHomeView()
        }
    }
    var filteredDishes:[FilteredDishes]?{
        didSet{
            bindFilteredMealsToHomeView()
        }
    }
    var specials:[SpecialMeal]?{
        didSet{
            bindSpecialMealsToHomeView()
        }
    }
    
    var bindCategoriesToHomeView : (()->())={}
    var bindFilteredMealsToHomeView : (()->())={}
    var bindSpecialMealsToHomeView : (()->())={}
    
    func fetchAllFoodCategories(){
        APIClient.getAllCategories { [weak self] result in
            switch result {
                case .success(let response):
                    self?.categories = response.categories
                case .failure(let err):
                    print("Error Fetching Food Categories: ",err.localizedDescription)
                
            }
        }
    }
    
    func fetchAllFilteredDishes(category:String = "Beef"){
        APIClient.getFilteredDishes(category: category) { [weak self] result in
            switch result {
            case .success(let response):
                self?.filteredDishes = response.meals
            case .failure(let err):
                print("Error Fetching Filtered Meals: ",err.localizedDescription)
            }
        }
    }
    
    func fetchSpecialMeals(){
        APIClient.getSpecialDishes { [weak self] result in
            switch result {
            case .success(let meal):
                self?.specials = meal.meal
            case .failure(let err):
                print("Error Fetching Special Meals: ",err.localizedDescription)
            }
        }
    }
}
