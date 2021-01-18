//
//  HomeVC+CLLocationManagerDelegate.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 11/3/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import CoreLocation
import GoogleMaps
import UIKit

extension HomeVC: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations \(locValue.latitude) , \(locValue.longitude)")
        SharedData.userLat = locValue.latitude
        SharedData.userLng = locValue.longitude
        camera = GMSCameraPosition.camera(withLatitude: SharedData.userLat ?? 0 , longitude: SharedData.userLng ?? 0, zoom: 15)
        GMSView.camera = camera!
        marker.icon = UIImage(named: "map-marker")
        marker.position = CLLocationCoordinate2D(latitude: SharedData.userLat ?? 0, longitude: SharedData.userLng ?? 0)
        marker.map = GMSView
        
        locationManager.stopUpdatingLocation()
    }
    
    func requestLocationPermission(){
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.startUpdatingLocation()
            
        }
    }
}
