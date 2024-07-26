//
//  DishCategoryModel.swift
//  Yummie
//
//  Created by husayn on 03/07/2024.
//

import UIKit

struct DishCategoryRoot: Codable {
    let categories: [DishCategory]
}

struct DishCategory:Codable{
    let idCategory, strCategory, strCategoryThumb, strCategoryDescription: String
}

struct FilteredDishesRoot: Codable {
    let meals: [FilteredDishes]
}

struct FilteredDishes: Codable {
    let strMeal, strMealThumb, idMeal: String
}
