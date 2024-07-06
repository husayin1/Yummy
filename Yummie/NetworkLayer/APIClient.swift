//
//  APIClient.swift
//  Yummie
//
//  Created by husayn on 03/07/2024.
//

import Foundation
import Alamofire
class APIClient {
    
    private static func performRequest<T: Decodable> (route: APIRoute, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard AppCommon.shared.isNetworkReachable() else {
            completion(.failure(.networkUnreachable))
            return
        }
        if let requestBody = try? JSONSerialization.data(withJSONObject: route.parameters ?? [:], options: .prettyPrinted),
           let requestBodyString = String(data: requestBody, encoding: .utf8) {
            print("Request Body:")
            print(requestBodyString)
        }
        AF.request(route).validate()
            .responseDecodable { (response: AFDataResponse<T>) in
                switch response.result {
                case .success(let model):
                    completion(.success(model))
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    do {
                        guard let data = response.data else {
                            completion(.failure(.invalidResponse))
                            return
                        }
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let message = (json as? [String: Any])?["Message"] as? String {
                            completion(.failure(.decodingError))
                        } else {
                            completion(.failure(.serverError(error.localizedDescription)))
                        }
                    } catch {
                        completion(.failure(.other(error.localizedDescription)))
                    }
                    break
                }
            }
    }
    
    static func getAllCategories(completion: @escaping (Result<DishCategoryRoot, NetworkError>) -> Void) {
        performRequest(route: APIRoute.getCategories, completion: completion)
    }
    
    static func getFilteredDishes(category: String,completion: @escaping (Result<FilteredDishesRoot, NetworkError>) -> Void) {
        performRequest(route: APIRoute.getFilteredByCategory(category: category), completion: completion)
    }
    static func getFilteredAreas(area: String,completion: @escaping (Result<FilteredDishesRoot, NetworkError>) -> Void) {
        performRequest(route: APIRoute.getFilteredByArea(area: area), completion: completion)
    }
    static func getFilteredIngredient(ingredient: String,completion: @escaping (Result<FilteredDishesRoot, NetworkError>) -> Void) {
        performRequest(route: APIRoute.getFilteredByIngredient(ingredient: ingredient), completion: completion)
    }
    static func getSpecialDishes(completion: @escaping (Result<MealsRoot, NetworkError>) -> Void) {
        performRequest(route: APIRoute.getRandomMeal, completion: completion)
    }
    static func getMealById(id: String,completion: @escaping (Result<MealsRoot, NetworkError>) -> Void) {
        performRequest(route: APIRoute.getMealById(mealId: id), completion: completion)
    }
    static func getAreas(completion: @escaping (Result<AreasRoot, NetworkError>) -> Void) {
        performRequest(route: APIRoute.getAreas, completion: completion)
    }
    static func getIngredients(completion: @escaping (Result<IngredientRoot, NetworkError>) -> Void) {
        performRequest(route: APIRoute.getIngredietns, completion: completion)
    }
    
}

