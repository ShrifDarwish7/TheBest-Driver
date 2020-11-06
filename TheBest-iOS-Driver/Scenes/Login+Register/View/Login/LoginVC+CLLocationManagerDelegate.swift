//
//  LoginVC+CLLocationManagerDelegate.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 10/8/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import CoreLocation

extension LoginVC: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations", locValue.latitude + locValue.longitude)
        SharedData.userLat = locValue.latitude
        SharedData.userLng = locValue.longitude
    }
}
