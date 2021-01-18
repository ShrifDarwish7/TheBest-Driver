//
//  ReportsResponse.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 10/31/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

// MARK: - ReportsResponse
struct ReportsResponse: Codable {
    let status: String
    let myTrips: [MyTrip]
    let myTripsCount, myTripsCanceled, myTripsCompleted, myTripsMoney: Int
    let myHandleMoney: String

    enum CodingKeys: String, CodingKey {
        case status
        case myTrips = "MyTrips"
        case myTripsCount = "MyTripsCount"
        case myTripsCanceled = "MyTripsCanceled"
        case myTripsCompleted = "MyTripsCompleted"
        case myTripsMoney = "MyTripsMoney"
        case myHandleMoney = "MyHandleMoney"
    }
}

