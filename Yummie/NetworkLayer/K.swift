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

    var endpoint: String {
        switch self {
        case .categories:
            return "categories"
        case .filter:
            return "filter"
        }
    }
}

enum HTTPHeaderField: String {
    case contentType = "Content-Type"
    case basicAuthorization = "Authorization"
    case apiKeyAuthorization = "X-Shopify-Access-Token"
}

enum ContentType: String {
    case json = "application/json"
}

