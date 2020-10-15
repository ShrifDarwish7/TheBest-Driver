//
//  LoginResponse.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 10/8/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation


// MARK: - LoginResponse
struct LoginResponse: Codable {
    let user: User
    let accessToken: String
}

// MARK: - User
struct User: Codable {
    let id: Int
    let name, email, image, fcmToken: String
    let phone: String
    let isAdmin, isDriver: Int
    let lat, lng: Double
    let birthDate, nationality: String?
    let status, imgcert, ssidDriver, ssidfront: String
    let ssidback, address, passport: String
    let expierdDate: String?
    let phoneIntreal: String
    let countryID, carCompanyID: Int
    let createdAt, updatedAt: String
    let hasImage: String?
    let myCar: [MyCar]?

    enum CodingKeys: String, CodingKey {
        case id, name, email, image
        case fcmToken = "fcm_token"
        case phone
        case isAdmin = "is_admin"
        case isDriver = "is_driver"
        case lat, lng
        case birthDate = "birth_date"
        case nationality, status, imgcert
        case ssidDriver = "ssid_driver"
        case ssidfront, ssidback, address, passport
        case expierdDate = "expierd_date"
        case phoneIntreal = "phone_intreal"
        case countryID = "country_id"
        case carCompanyID = "car_company_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case hasImage = "has_image"
        case myCar = "my_car"
    }
}
