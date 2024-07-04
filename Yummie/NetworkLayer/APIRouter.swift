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
    
    var method: HTTPMethod {
        switch self {
        case .getCategories, .getFiltered, .getRandomMeal:
            return .get
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getCategories, .getFiltered, .getRandomMeal:
            return URLEncoding.default
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getCategories, .getRandomMeal:
            return nil
        case .getFiltered(let category):
            return ["c": category]  // Provide the query parameter here
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
        }
    }
    
    var authorizationHeader: HTTPHeaderField? {
        switch self {
        case .getCategories, .getFiltered, .getRandomMeal:
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
