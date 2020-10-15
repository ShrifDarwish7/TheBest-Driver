//
//  DriverInfo.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 10/8/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import UIKit

struct DriverInfo {
    var name: String
    var email: String
    var password: String
    var phone: String
    var image: UIImage
    var fcm_token: String
    var lat: String = "\(SharedData.userLat ?? 0.0)"
    var lng: String = "\(SharedData.userLng ?? 0.0)"
    var nationality: String
    var imgcert: UIImage
    var ssid_driver: String
    var ssidfront: UIImage
    var ssidback: UIImage
    var address: String
    var passport: UIImage
    var phone_intreal: String
    var country_id: String
    var car_company_id: String
}
