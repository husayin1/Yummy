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
    
    var bindCategoriesToHomeView : (()->())={}
    
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
}
