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
    let id, clientID, driverID: Int?
    let fromLat, fromLng, toLat, toLng: Double?
    let paymentMethod: String?
    let total: Int?
    let status, addressFrom, addressTo: String?
    let driverComment: String?
    let rideType: Int?
    let createdAt, updatedAt: String?
    let order: Order?

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
        case order
    }
}

// MARK: - OldOrder
struct Order: Codable {
    let id: Int
    let username: String
    let userID: Int
    let lat, lng: Double
    let comment, phone, total: String
    let address: String?
    let status: String
    let driverID: Int?
    let catID: Int?
    let userParent: Int
    let createdAt, updatedAt: String
    let orderItems: [OrderItem]
    
    var expanded: Bool?
        
    enum CodingKeys: String, CodingKey {
        case id, username
        case userID = "user_id"
        case lat, lng, comment, address, phone, total, status
        case catID = "cat_id"
        case driverID = "driver_id"
        case userParent = "user_parent"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case orderItems = "order_items"
    }
}

// MARK: - OrderItem
struct OrderItem: Codable {
    let id, itemID, placeID, orderID: Int?
    let count: Int?
    let attributeBody, attributeBodyTwo, attributeBodyThree: String?
    let additional: String?

    enum CodingKeys: String, CodingKey {
        case id
        case itemID = "item_id"
        case placeID = "place_id"
        case orderID = "order_id"
        case count
        case attributeBody = "attribute_body"
        case attributeBodyTwo = "attribute_body_two"
        case attributeBodyThree = "attribute_body_three"
        case additional
    }
}
