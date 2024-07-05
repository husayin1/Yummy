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
    case getFiltered(category: String)
    case getMealById(mealId: String)
    
    var method: HTTPMethod {
        switch self {
        case .getCategories, .getFiltered, .getRandomMeal, .getMealById:
            return .get
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getCategories, .getFiltered, .getRandomMeal, .getMealById:
            return URLEncoding.default
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getCategories, .getRandomMeal:
            return nil
        case .getFiltered(let category):
            return ["c": category]  // Provide the query parameter here
        case .getMealById(let id):
            return ["i": id]
        }
    }
    
    var path: String {
        switch self {
        case .getCategories:
            return TheMealDb.categories.endpoint
        case .getFiltered:
            return TheMealDb.filter.endpoint
        case .getRandomMeal:
            return TheMealDb.random.endpoint
        case .getMealById:
            return TheMealDb.mealById.endpoint
        }
    }
    
    var authorizationHeader: HTTPHeaderField? {
        switch self {
        case .getCategories, .getFiltered, .getRandomMeal, .getMealById:
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
