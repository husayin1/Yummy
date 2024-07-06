//
//  APIRoute.swift
//  Yummie
//
//  Created by husayn on 03/07/2024.
//

import Foundation
import Alamofire
// MARK: - API Router: the endpoint builder
// MARK: - API request builder component which presents an endpoint

enum APIRoute: URLRequestConvertible {
    
    case getCategories
    case getRandomMeal
    case getFilteredByCategory(category: String)
    case getFilteredByArea(area: String)
    case getFilteredByIngredient(ingredient: String)
    case getMealById(mealId: String)
    case getAreas
    case getIngredietns
    
    var method: HTTPMethod {
        switch self {
        case .getCategories, .getFilteredByCategory, .getRandomMeal, .getMealById, .getAreas, .getIngredietns, .getFilteredByArea, .getFilteredByIngredient:
            return .get
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getCategories, .getFilteredByCategory, .getRandomMeal, .getMealById, .getAreas, .getIngredietns, .getFilteredByArea, .getFilteredByIngredient:
            return URLEncoding.default
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getCategories, .getRandomMeal:
            return nil
        case .getFilteredByCategory(let category):
            return ["c": category]  // Provide the query parameter here
        case .getMealById(let id):
            return ["i": id]
        case .getFilteredByArea(let area):
            return ["a":area]
        case .getAreas:
            return ["a":"list"]
        case .getIngredietns:
            return ["i":"list"]
        case .getFilteredByIngredient(let ingredient):
            return ["i":ingredient]
        }
    }
    
    var path: String {
        switch self {
        case .getCategories:
            return TheMealDb.categories.endpoint
        case .getFilteredByCategory, .getFilteredByArea, .getFilteredByIngredient:
            return TheMealDb.filter.endpoint
        case .getRandomMeal:
            return TheMealDb.random.endpoint
        case .getMealById:
            return TheMealDb.mealById.endpoint
        case .getAreas, .getIngredietns:
            return TheMealDb.areas.endpoint
        }
    }
    
    var authorizationHeader: HTTPHeaderField? {
        switch self {
        case .getCategories, .getFilteredByCategory, .getRandomMeal, .getMealById, .getAreas, .getIngredietns, .getFilteredByArea, .getFilteredByIngredient:
            return .basicAuthorization
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try K.baseUrl.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path + ".php"))
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        
        return try encoding.encode(urlRequest, with: parameters)
    }
}
