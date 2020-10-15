//
//  DriverReports.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 10/16/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

// MARK: - DriverReports
struct DriverReports: Codable {
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

// MARK: - MyTrip
struct MyTrip: Codable {
    let id, clientID, driverID: Int
    let fromLat, fromLng, toLat, toLng: Double
    let paymentMethod: String
    let total: Int
    let status, addressFrom, addressTo: String
    let driverComment: String?
    let rideType: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case clientID = "client_id"
        case driverID = "driver_id"
        case fromLat = "from_lat"
        case fromLng = "from_lng"
        case toLat = "to_lat"
        case toLng = "to_lng"
        case paymentMethod = "payment_method"
        case total, status
        case addressFrom = "address_from"
        case addressTo = "address_to"
        case driverComment = "driver_comment"
        case rideType = "ride_type"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
