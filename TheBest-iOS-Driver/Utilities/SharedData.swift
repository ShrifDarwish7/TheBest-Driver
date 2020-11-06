//
//  SharedData.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 10/8/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import CoreLocation

class SharedData{
    static let headers = [
        "Authorization": "Bearer " + (UserDefaults.init().string(forKey: "accessToken") ?? ""),
        "Accept": "application/json"
    ]
    static let goolgeApiKey = "AIzaSyDBDV-XxFpmbx79T5HLPrG9RmjDpiYshmE"
    static var userLat: CLLocationDegrees?
    static var userLng: CLLocationDegrees?
    static var receivedOrder: ReceivedOrder?
}
