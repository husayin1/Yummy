//
//  IngredientResponse.swift
//  Yummie
//
//  Created by husayn on 25/07/2024.
//

import Foundation


struct IngredientRoot: Codable{
    let ingredients: [Ingredient]
    
    enum CodingKeys: String, CodingKey {
        case ingredients = "meals"
    }
}

struct Ingredient: Codable {
    let idIngredient, strIngredient: String
    let strDescription, strType: String?
    
}
