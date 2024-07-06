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
/*
 var formattedCalories: String{
 return String(foramt:"%.2f", calories ?? 0)
 }
 */

struct MealsRoot: Codable {
    let meals: [SpecialMeal]
}

struct SpecialMeal: Codable {
    let idMeal: String
    let strMeal: String
    let strDrinkAlternate: String?
    let strCategory: String
    let strArea: String
    let strInstructions: String
    let strMealThumb: String
    let strTags: String?
    let strYoutube: String?
    let strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10, strIngredient11, strIngredient12,
        strIngredient13, strIngredient14,
        strIngredient15, strIngredient16,
        strIngredient17, strIngredient18,
        strIngredient19, strIngredient20: String?
    let strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10, strMeasure11, strMeasure12,
        strMeasure13, strMeasure14,
        strMeasure15, strMeasure16,
        strMeasure17, strMeasure18,
        strMeasure19, strMeasure20: String?
    let strSource, strImageSource, strCreativeCommonsConfirmed, dateModified: String?
    
    
    
}

struct AreasRoot: Codable{
    let meals:[Area]
}

struct Area: Codable{
    var strArea: String
    
    func setThumbnail(for area: String) -> String {
        let countryCode: [String: String] = [
            "Vietnamese": "vn",
            "Turkish": "tr",
            "Tunisian": "tn",
            "Thai": "th",
            "Spanish": "es",
            "Russian": "ru",
            "American": "us",
            "British": "gb",
            "Canadian": "ca",
            "Chinese": "cn",
            "Croatian": "hr",
            "Dutch": "de",
            "Egyptian": "eg",
            "French": "fr",
            "Greek": "gr",
            "Indian": "in",
            "Irish": "ie",
            "Italian": "it",
            "Jamaican": "jm",
            "Japanese": "jp",
            "Kenyan": "ke",
            "Malaysian": "my",
            "Mexican": "mx",
            "Moroccan": "ma",
            "Polish": "pl",
            "Portuguese": "pt",
            "Unknown": "ps",
            "Filipino": "ph",
            "Ukrainian": "ua"
        ]

        let code = countryCode[area] ?? "ps"
        return "https://www.themealdb.com/images/icons/flags/big/64/\(code).png"
    }
}

struct IngredientRoot: Codable{
    let meals: [Ingredient]
}

struct Ingredient: Codable {
    let idIngredient, strIngredient: String
    let strDescription, strType: String?
    
}

enum FilterType{
    case area, ingredient, category
}
