//
//  CountriesResponse.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 11/18/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

class CountriesResponse: Codable{
    let status: String
    let countries: CountriesContainer
    
    enum CodingKeys: String, CodingKey{
        case status
        case countries = "Countries"
    }
}

class CountriesContainer: Codable{
    let data: [Country]
}

class Country: Codable{
    let id: Int
    let name: String
    let hasImage: String
    var selected: Bool?
    
    enum CodingKeys: String, CodingKey{
        case id, name
        case hasImage = "has_image"
    }
}
