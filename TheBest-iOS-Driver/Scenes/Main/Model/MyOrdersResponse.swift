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


