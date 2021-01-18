//
//  MainPresenter.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 10/15/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import GoogleMaps

protocol MainViewDelegate{
    func SVProgressStatus(_ show: Bool)
    func didCompletedWithOrders(_ orders: [MyTrip]?)
    func didCompleteWithTripByID(_ trip: MyTrip?)
    func didCompleteConfirmEndRideByID(_ error: Bool)
    func didCompleteConfirmRidePrice(_ error: Bool)
    func didCompleteConfirmDriverHere(_ error: Bool)
    func didCompleteWithReports(_ reports: ReportsResponse?)
    func didCompleteWithAddressFromGoogleMapsAPI(_ address: String?)
    func didCompleteWithDirectionFromGoogleMapsAPI(_ polyline: GMSPolyline?)
    func didCompleteAcceptOrder(_ error: Bool)
    func didCompleteWithProfle(profile: ProfileResponse?)
    func didCompleteChangeStatus(_ done: Bool)
    func didCompleteStartRide(_ done: Bool)
    func didCompleteEndRide(_ done: Bool)
}

extension MainViewDelegate{
    func SVProgressStatus(_ show: Bool){}
    func didCompletedWithOrders(_ orders: [MyTrip]?){}
    func didCompleteWithTripByID(_ trip: MyTrip?){}
    func didCompleteConfirmEndRideByID(_ error: Bool){}
    func didCompleteConfirmRidePrice(_ error: Bool){}
    func didCompleteConfirmDriverHere(_ error: Bool){}
    func didCompleteWithReports(_ reports: ReportsResponse?){}
    func didCompleteWithAddressFromGoogleMapsAPI(_ address: String?){}
    func didCompleteWithDirectionFromGoogleMapsAPI(_ polyline: GMSPolyline?){}
    func didCompleteAcceptOrder(_ error: Bool){}
    func didCompleteWithProfle(profile: ProfileResponse?){}
    func didCompleteChangeStatus(_ done: Bool){}
    func didCompleteStartRide(_ done: Bool){}
    func didCompleteEndRide(_ done: Bool){}
}

class MainPresenter{
    
    var mainViewDelegate: MainViewDelegate?
    
    init(_ mainViewDelegate: MainViewDelegate) {
        self.mainViewDelegate = mainViewDelegate
    }
    
    func getMyOrders(){
        self.mainViewDelegate?.SVProgressStatus(true)
        APIServices.myOrders { (response) in
            self.mainViewDelegate?.SVProgressStatus(false)
            if let _ = response{
                self.mainViewDelegate?.didCompletedWithOrders(response?.myOrders)
            }else{
                self.mainViewDelegate?.didCompletedWithOrders(nil)
            }
        }
    }
    
    func getTripBy(id: String){
        self.mainViewDelegate?.SVProgressStatus(true)
        APIServices.getTripBy(id) { (reponse) in
            self.mainViewDelegate?.SVProgressStatus(false)
            if let _ = reponse{
                self.mainViewDelegate?.didCompleteWithTripByID(reponse?.trip.first)
            }else{
                self.mainViewDelegate?.didCompleteWithTripByID(nil)
            }
        }
    }
    
    func confirmEndRideBy(id: String, comment: String, status: String){
        self.mainViewDelegate?.SVProgressStatus(true)
        APIServices.confirmEndRide(id, comment, status) { (completed) in
            self.mainViewDelegate?.SVProgressStatus(false)
            if completed{
                self.mainViewDelegate?.didCompleteConfirmEndRideByID(false)
            }else{
                self.mainViewDelegate?.didCompleteConfirmEndRideByID(true)
            }
        }
    }
    
    func confirmEndRideBy(total: String, paymentMethod: String){
           self.mainViewDelegate?.SVProgressStatus(true)
           APIServices.confirmRidePrice(total, paymentMethod) { (completed) in
               self.mainViewDelegate?.SVProgressStatus(false)
               if completed{
                   self.mainViewDelegate?.didCompleteConfirmRidePrice(false)
               }else{
                   self.mainViewDelegate?.didCompleteConfirmRidePrice(true)
               }
           }
       }
    
    func confirmDriverHere(id: String){
        self.mainViewDelegate?.SVProgressStatus(true)
        APIServices.hereDriver(id) { (completed) in
            self.mainViewDelegate?.SVProgressStatus(false)
            if completed{
                self.mainViewDelegate?.didCompleteConfirmDriverHere(false)
            }else{
                self.mainViewDelegate?.didCompleteConfirmDriverHere(true)
            }
        }
    }
    
    func getReports(from: Date, to: Date){
        self.mainViewDelegate?.SVProgressStatus(true)
        var fromPrms: String?
        var toPrms: String?
        let calendar = Calendar.current
        let componentsFrom = calendar.dateComponents([.day,.month,.year], from: from)
        let componentsTo = calendar.dateComponents([.day,.month,.year], from: to)
        if let day = componentsFrom.day, let month = componentsFrom.month, let year = componentsFrom.year {
            fromPrms = String(day) + "-" + String(month) + "-" + String(year)
        }
        
        if let day = componentsTo.day, let month = componentsTo.month, let year = componentsTo.year {
            toPrms = String(day) + "-" + String(month) + "-" + String(year)
        }
        
        guard let _ = fromPrms, let _ = toPrms else{
            self.mainViewDelegate?.didCompleteWithReports(nil)
            return
        }
        
        APIServices.getDriverReports(fromPrms!, toPrms!) { (response) in
            self.mainViewDelegate?.SVProgressStatus(false)
            if let _ = response{
                self.mainViewDelegate?.didCompleteWithReports(response)
            }else{
                self.mainViewDelegate?.didCompleteWithReports(nil)
            }
        }
    }
    
    func getAdressWith(location: String){
        self.mainViewDelegate?.SVProgressStatus(true)
        APIServices.getAddressFromGoogleMapsAPI(location: location) { (address) in
            self.mainViewDelegate?.SVProgressStatus(false)
            if let _ = address{
                self.mainViewDelegate?.didCompleteWithAddressFromGoogleMapsAPI(address)
            }else{
                self.mainViewDelegate?.didCompleteWithAddressFromGoogleMapsAPI(nil)
            }
        }
    }
    
    func acceptOrder(id: Int, clientID: String){
        self.mainViewDelegate?.SVProgressStatus(true)
        APIServices.acceptOrder(id, "\(SharedData.userLat ?? 0.0)", "\(SharedData.userLng ?? 0.0)", clientID) { (completed) in
            self.mainViewDelegate?.SVProgressStatus(false)
            if completed{
                self.mainViewDelegate?.didCompleteAcceptOrder(false)
            }else{
                self.mainViewDelegate?.didCompleteAcceptOrder(true)
            }
        }
    }
    
    func getProfile(){
        self.mainViewDelegate?.SVProgressStatus(true)
        APIServices.getProfile { (response) in
            self.mainViewDelegate?.SVProgressStatus(false)
            if let _ = response{
                self.mainViewDelegate?.didCompleteWithProfle(profile: response)
            }else{
                self.mainViewDelegate?.didCompleteWithProfle(profile: nil)
            }
        }
    }
    
    func changeOrderStatus(id: String, status: String){
        self.mainViewDelegate?.SVProgressStatus(true)
        APIServices.changeOrderStatus(id: id, status: status) { (done) in
            self.mainViewDelegate?.SVProgressStatus(false)
            if done{
                self.mainViewDelegate?.didCompleteChangeStatus(true)
            }else{
                self.mainViewDelegate?.didCompleteChangeStatus(false)
            }
        }
    }
    
    func startRide(id: String, trip: MyTrip){
        self.mainViewDelegate?.SVProgressStatus(true)
        APIServices.startRide(id, trip) { (done) in
            self.mainViewDelegate?.SVProgressStatus(false)
            if done{
                self.mainViewDelegate?.didCompleteStartRide(true)
            }else{
                self.mainViewDelegate?.didCompleteStartRide(false)
            }
        }
    }
    
    func endRide(id: String, total: String){
        self.mainViewDelegate?.SVProgressStatus(true)
        APIServices.endRide(id, total) { (done) in
            self.mainViewDelegate?.SVProgressStatus(false)
            if done{
                self.mainViewDelegate?.didCompleteEndRide(true)
            }else{
                self.mainViewDelegate?.didCompleteEndRide(false)
            }
        }
    }
    
}
