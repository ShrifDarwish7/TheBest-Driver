//
//  MyOrdersResponse.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 10/15/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

// MARK: - MyOrdersRsponse
struct MyOrdersRsponse: Codable {
    let status: Int
    let myOrders: [MyTrip]

    enum CodingKeys: String, CodingKey {
        case status
        case myOrders = "MyOrders"
    }
}



struct Order: Codable {
    let id: Int?
    let username: String?
    let userID: Int?
    let lat, lng: Double?
    let comment: String?
    let address, phone, total: String?
  //  let trip: MyTrip?
    let orderItems: [OrderItem]?
    let status, orderDate: String?
    var expanded: Bool?

    enum CodingKeys: String, CodingKey {
        case id, username
        case userID = "user_id"
        case lat, lng, comment, address, phone, total//, trip
        case orderItems = "order_items"
        case status
        case orderDate = "order date"
    }
    
}

// MARK: - OrderItem
struct OrderItem: Codable {
    let id, itemID, placeID, orderID: Int
    let count: Int
    let attributeBody, attributeBodyTwo, attributeBodyThree: String
    let additional: String?
    let itemName, restaurantName, restaurantAddress, restaurantImage: String
    let firstAttrItemsNameAr, firstAttrItemsNameEn: String?
    let firstAttrItemsBody: AttrItemsBody?
    let secondAttrItemsNameAr, secondAttrItemsNameEn: String?
    let secondAttrItemsBody: AttrItemsBody?
    let thirdAttrItemsNameAr, thirdAttrItemsNameEn: String?
    let thirdAttrItemsBody: AttrItemsBody?

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
        case itemName = "Item Name"
        case restaurantName = "Restaurant Name"
        case restaurantAddress = "Restaurant address"
        case restaurantImage = "Restaurant image"
        case firstAttrItemsNameAr = "FirstAttrItemsNameAr"
        case firstAttrItemsNameEn = "FirstAttrItemsNameEn"
        case firstAttrItemsBody = "FirstAttrItemsBody"
        case secondAttrItemsNameAr = "SecondAttrItemsNameAr"
        case secondAttrItemsNameEn = "SecondAttrItemsNameEn"
        case secondAttrItemsBody = "SecondAttrItemsBody"
        case thirdAttrItemsNameAr = "ThirdAttrItemsNameAr"
        case thirdAttrItemsNameEn = "ThirdAttrItemsNameEn"
        case thirdAttrItemsBody = "ThirdAttrItemsBody"
    }
}

// MARK: - AttrItemsBody
struct AttrItemsBody: Codable {
    let nameAr, nameEn, price: String

    enum CodingKeys: String, CodingKey {
        case nameAr = "name_ar"
        case nameEn = "name_en"
        case price
    }
}
