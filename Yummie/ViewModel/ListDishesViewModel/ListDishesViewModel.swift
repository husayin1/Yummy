//
//  ListDishesViewModel.swift
//  Yummie
//
//  Created by husayn on 06/07/2024.
//

import Foundation

class ListDishesViewModel {
    var meals:[FilteredDishes]?{
        didSet{
            bindMealsToListDishesView()
        }
    }
    var bindMealsToListDishesView : (()->())={}
    
    func fetchAllFilteredDishesByCategory(category:String){
        APIClient.getFilteredDishes(category: category) { [weak self] result in
            switch result {
            case .success(let response):
                self?.meals = response.meals
            case .failure(let err):
                print("Error Fetching Filtered Meals (By Category): ",err.localizedDescription)
            }
        }
    }
    func fetchAllFilteredDishesByArea(area:String){
        APIClient.getFilteredAreas(area: area) { [weak self] result in
            switch result {
            case .success(let response):
                self?.meals = response.meals
            case .failure(let err):
                print("Error Fetching Filtered Meals (By Area): ",err.localizedDescription)
            }
        }
    }
    func fetchAllFilteredDishesByCategory(ingredient:String){
        APIClient.getFilteredIngredient(ingredient: ingredient) { [weak self] result in
            switch result {
            case .success(let response):
                self?.meals = response.meals
            case .failure(let err):
                print("Error Fetching Filtered Meals (By Ingredient): ",err.localizedDescription)
            }
        }
    }
    
    func searchFor(meal:String){
        APIClient.searchFor(meal: meal) { [weak self] result in
            switch result {
            case .success(let response):
                self?.meals = response.meals
            case .failure(let err):
                self?.meals = []
                print("Error Searching For Meals: ",err.localizedDescription)
            }
        }
    }
    
}
