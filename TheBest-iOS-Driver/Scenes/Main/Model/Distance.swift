//
//  Distance.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 15/01/2021.
//  Copyright © 2021 Sherif Darwish. All rights reserved.
//

import Foundation

struct Distance: Codable {
    let distance, cost, est: Double

    enum CodingKeys: String, CodingKey {
        case distance
        case cost = "Cost"
        case est
    }
}
