//
//  DriversSpecialty.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 10/9/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

struct DriversSpecialty: Codable {
    let status: String
    let driversSpecialty: [Specialty]

    enum CodingKeys: String, CodingKey {
        case status
        case driversSpecialty = "DriversSpecialty"
    }
}

struct Specialty: Codable {
    let id: Int
    let name: String
    let createdAt, updatedAt: String
    var selected: Bool?

    enum CodingKeys: String, CodingKey {
        case id, name
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
