//
//  CountriesResponseModel.swift
//  Yummie
//
//  Created by husayn on 25/07/2024.
//

import Foundation

struct AreasRoot: Codable{
    let areas:[Area]
    
    enum CodingKeys: String, CodingKey {
        case areas = "meals"
    }
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
