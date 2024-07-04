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
    
    var method: HTTPMethod {
        switch self {
        case .getCategories:
            return .get
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getCategories:
            return URLEncoding.default
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getCategories:
            return nil
        }
    }
    
    var path: String {
        switch self {
        case .getCategories:
            return TheMealDb.categories.endpoint
        }
    }
    
    var authorizationHeader: HTTPHeaderField? {
        switch self {
        case .getCategories:
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
