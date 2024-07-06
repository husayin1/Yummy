//
//  FilterDishesViewModel.swift
//  Yummie
//
//  Created by husayn on 06/07/2024.
//

import Foundation

class FilterDishesViewModel{
    
    var areas:[Area]?{
        didSet{
            bindAreasToFilterView()
        }
    }
    
    var ingredients:[Ingredient]?{
        didSet{
            bindIngredientsToFilterView()
        }
    }
    
    var categories: [DishCategory]?{
        didSet{
            bindCategoriesToFilterView()
        }
    }
    var bindAreasToFilterView : (()->())={}
    var bindIngredientsToFilterView : (()->())={}
    var bindCategoriesToFilterView : (()->())={}
    
    func fetchAllAreas(){
        APIClient.getAreas{ [weak self] result in
            switch result {
                case .success(let response):
                    self?.areas = response.meals
                case .failure(let err):
                    print("Error Fetching Areas: ",err.localizedDescription)
            }
        }
    }
    func fetchAllIngredients(){
        APIClient.getIngredients { [weak self] result in
            switch result{
            case .success(let response):
                self?.ingredients = response.meals
            case .failure(let err):
                print("Error Fetching Ingredients:  ",err.localizedDescription)
            }
        }
    }
    func fetchAllCategories(){
        APIClient.getAllCategories { [weak self] result in
            switch result{
            case .success(let response):
                self?.categories = response.categories
            case .failure(let err):
                print("Error Fetching Categories: ",err.localizedDescription)
            }
        }
    }
    
}
