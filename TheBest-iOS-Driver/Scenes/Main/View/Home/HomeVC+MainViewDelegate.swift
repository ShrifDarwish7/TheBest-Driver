//
//  HomeVC+HomeViewDelegate.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 10/16/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import SVProgressHUD
import GoogleMaps

extension HomeVC: MainViewDelegate{
    
    func SVProgressStatus(_ show: Bool) {
        if show{
            SVProgressHUD.show()
        }else{
            SVProgressHUD.dismiss()
        }
    }
    
    func didCompleteWithAddressFromGoogleMapsAPI(_ address: String?) {
        if let _ = address{
            self.addressFrom.text = address!
            let marker = GMSMarker()
            marker.icon = UIImage(named: "location-icon-png")
            marker.position = CLLocationCoordinate2D(latitude: Double(SharedData.receivedOrder?.clientLat ?? "0.0")!, longitude: Double(SharedData.receivedOrder?.clientLng ?? "0.0")!)
            marker.map = GMSView
            let camera = GMSCameraPosition.camera(withLatitude: Double(SharedData.receivedOrder?.clientLat ?? "0.0")! , longitude: Double(SharedData.receivedOrder?.clientLng ?? "0.0")!, zoom: 10)
            GMSView.camera = camera
        }
    }
    
    func didCompleteAcceptOrder(_ error: Bool) {
        if !error{
            if let _ = SharedData.receivedOrder?.tripID{
                self.mainPresenter?.changeOrderStatus(id: SharedData.receivedOrder!.tripID, status: SharedData.orderOnDeliveryStatus)
            }
        }
    }
    
    func didCompleteWithTripByID(_ trip: MyTrip?) {
        if let _ = trip{
            print("didCompleteWithTripByID", trip)
            self.topView.backgroundColor = SharedData.getColor((trip?.rideType)!)
            self.rideTypeIcon.image = SharedData.getRideType((trip?.rideType)!).icon
            self.rideType.text = SharedData.getRideType((trip?.rideType)!).name
        }
    }
    
    func didCompleteChangeStatus(_ done: Bool) {
        if done{
            print("didCompleteChangeStatus")
            UIView.animate(withDuration: 0.3) {
                self.acceptOrderBtn.isHidden = true
                self.denyOrderBtn.isHidden = true
                self.endRideBtn.isHidden = false
                self.goBtn.isHidden = false
            }
        }
    }
    
    func didCompleteConfirmDriverHere(_ error: Bool) {
        if !error{
            print("didCompleteConfirmDriverHere success")
        }else{
            print("didCompleteConfirmDriverHere faild")
        }
    }
    
}
