//
//  TripByIdResponse.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 10/16/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

// MARK: - TripByIDResponse
struct TripByIDResponse: Codable {
    let status: Int
    let trip: MyTrip

    enum CodingKeys: String, CodingKey {
        case status
        case trip = "Trip"
    }
}

