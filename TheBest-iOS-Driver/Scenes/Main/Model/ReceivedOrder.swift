//
//  ReceivedOrder.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 11/4/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

struct ReceivedOrder {
    
    var tripID: String
    var clientID: String
    var clientName: String
    var clientPhone: String
    var clientLat: String
    var clientLng: String
    
    init(userInfo: [AnyHashable : Any]) {
        tripID = userInfo["trip_id"] as? String ?? ""
        clientID = userInfo["user_id"] as? String ?? ""
        clientName = userInfo["name"] as? String ?? ""
        clientPhone = userInfo["phone"] as? String ?? ""
        clientLat = userInfo["lat"] as? String ?? ""
        clientLng = userInfo["lng"] as? String ?? ""
    }
}
