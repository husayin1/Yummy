//
//  K.swift
//  Yummie
//
//  Created by husayn on 03/07/2024.
//

import Foundation

struct K {
    static let baseUrl = "https://www.themealdb.com/api/json/v1/1/"
}

enum TheMealDb {
    case categories
    case filter
    case random
    case mealById
    case areas
    case ingredients
    case search

    var endpoint: String {
        switch self {
        case .categories:
            return "categories"
        case .filter:
            return "filter"
        case .random:
            return "random"
        case .mealById:
            return "lookup"
        case .areas, .ingredients:
            return "list"
        case .search:
            return "search"
        }
    }
}

