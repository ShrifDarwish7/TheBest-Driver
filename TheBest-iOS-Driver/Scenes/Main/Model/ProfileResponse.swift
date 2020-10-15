//
//  ProfileResponse.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 10/15/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

// MARK: - ProfileResponse
struct ProfileResponse: Codable {
    let status: Int
    let myProfile: User
    let currnetTrip: CurrnetTrip

    enum CodingKeys: String, CodingKey {
        case status
        case myProfile = "MyProfile"
        case currnetTrip = "CurrnetTrip"
    }
}

// MARK: - CurrnetTrip
struct CurrnetTrip: Codable {
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

// MARK: - MyCar
struct MyCar: Codable {
    let id: Int
    let carNumber, image: String
    let carModel, userID: Int
    let type: String?
    let carTypeID: Int
    let carColor: String
    let carFactor, expiryDate: String?
    let imagecert, carbook: String
    let sanelderNumber: Int
    let createdAt, updatedAt: String
    let hasImage: String

    enum CodingKeys: String, CodingKey {
        case id
        case carNumber = "car_number"
        case image
        case carModel = "car_model"
        case userID = "user_id"
        case type
        case carTypeID = "car_type_id"
        case carColor = "car_color"
        case carFactor = "car_factor"
        case expiryDate = "expiry_date"
        case imagecert, carbook
        case sanelderNumber = "sanelder_number"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case hasImage = "has_image"
    }
}
