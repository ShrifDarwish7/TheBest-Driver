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
    let trip: [MyTrip]

    enum CodingKeys: String, CodingKey {
        case status
        case trip = "Trip"
    }
}

// MARK: - MyTrip
struct MyTrip: Codable {
    let id, clientID, driverID: Int?
    let fromLat, fromLng, toLat, toLng: Double?
    let paymentMethod, username, phone: String?
    let total: String?
    let status, addressFrom, addressTo: String?
    let driverComment: String?
    let rideType: Int?
    let createdAt, updatedAt: String?
    let order: [Order]?
    let tripFurniture: [Furniture]?
    let tripPrivateCars: [PrivateCars]?
    let tripMonthly: [Monthly]?
    let tripRoadServices: [RoadServices]?

    enum CodingKeys: String, CodingKey {
        case id, username, phone
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
        case order = "MyOrder"
        case tripFurniture = "trip__furniture"
        case tripPrivateCars = "trip__privte_cars"
        case tripMonthly = "trip__monthly"
        case tripRoadServices = "trip__road_service"
    }
}
//
//// MARK: - OldOrder
//struct Order: Codable {
//    let id: Int
//    let username: String
//    let userID: Int
//    let lat, lng: Double
//    let comment, phone, total: String
//    let address: String?
//    let status: String
//    let driverID: Int?
//    let catID: Int?
//    let userParent: Int
//    let createdAt, updatedAt: String
//    let orderItems: [OrderItem]
//
//    var expanded: Bool?
//
//    enum CodingKeys: String, CodingKey {
//        case id, username
//        case userID = "user_id"
//        case lat, lng, comment, address, phone, total, status
//        case catID = "cat_id"
//        case driverID = "driver_id"
//        case userParent = "user_parent"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case orderItems = "order_items"
//    }
//}
//
//// MARK: - OrderItem
//struct OrderItem: Codable {
//    let id, itemID, placeID, orderID: Int?
//    let count: Int?
//    let attributeBody, attributeBodyTwo, attributeBodyThree: String?
//    let additional: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case itemID = "item_id"
//        case placeID = "place_id"
//        case orderID = "order_id"
//        case count
//        case attributeBody = "attribute_body"
//        case attributeBodyTwo = "attribute_body_two"
//        case attributeBodyThree = "attribute_body_three"
//        case additional
//    }
//}


struct RoadServices: Codable{
    let tripId: Int?
    let serviceName: String?
    let serviceImage: String?
    let serviceCount: String?
    let note: String?
    let serviceDesc: String?
    let servicePrice: String?
    
    enum CodingKeys: String, CodingKey {
        case tripId = "trip_id"
        case serviceName = "service_name"
        case serviceImage = "service_image"
        case serviceCount = "service_count"
        case note
        case serviceDesc = "service_desc"
        case servicePrice = "service_price"
    }
}

struct Monthly: Codable {
    let tripId: Int?
    let fromDate: String?
    let toDate: String?
    let fromTime: String?
    let toTime: String?
    let workingDays: [String]?
    let goingComing: Int?
    let needs: String?
    
    enum CodingKeys: String, CodingKey{
        case tripId = "trip_id"
        case fromDate = "from_date"
        case toDate = "to_date"
        case fromTime = "from_time"
        case toTime = "to_time"
        case workingDays = "working_days"
        case goingComing = "going_coming"
        case needs = "required_equipment"
    }
}

struct PrivateCars: Codable {
    let tripId: Int?
    let equipments: String?
    let priceMethod: String?
    let carType: String?
    let priceMethodFrom: String?
    let priceMethodTo: String?
    
    enum CodingKeys: String, CodingKey{
        case tripId = "trip_id"
        case equipments = "required_equipment"
        case priceMethod = "price_method"
        case carType = "car_type"
        case priceMethodFrom = "price_method_from"
        case priceMethodTo = "price_method_to"
    }
    
}

struct Furniture: Codable{
    let tripId: Int?
    let serviceName: String?
    let serviceImage: String?
    let serviceCount: String?
    let note: String?
    let techsCount: String?
    let workersCount: String?
    let date: String?
    let time: String?
    
    enum CodingKeys: String, CodingKey {
        case tripId = "trip_id"
        case serviceName = "service_name"
        case serviceImage = "service_image"
        case serviceCount = "service_count"
        case note, date, time
        case techsCount = "number_technicians"
        case workersCount = "number_workers"
    }
}
