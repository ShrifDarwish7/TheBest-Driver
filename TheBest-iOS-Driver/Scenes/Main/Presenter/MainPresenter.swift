//
//  MainPresenter.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 10/15/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

protocol MainViewDelegate{
    func SVProgressStatus(_ show: Bool)
    func didCompletedWithOrders(_ orders: [MyOrder]?)
    func didCompleteWithReports(_ reports: DriverReports?)
    func didCompleteWithTripByID(_ trip: MyTrip?)
    func didCompleteConfirmEndRideByID(_ error: Bool)
    func didCompleteConfirmRidePrice(_ error: Bool)
    func didCompleteConfirmDriverHere(_ error: Bool)
}

extension MainViewDelegate{
    func SVProgressStatus(_ show: Bool){}
    func didCompletedWithOrders(_ orders: [MyOrder]?){}
    func didCompleteWithReports(_ reports: DriverReports?){}
    func didCompleteWithTripByID(_ trip: MyTrip?){}
    func didCompleteConfirmEndRideByID(_ error: Bool){}
    func didCompleteConfirmRidePrice(_ error: Bool){}
    func didCompleteConfirmDriverHere(_ error: Bool){}
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
    
    func getReports(from: String, to: String){
        self.mainViewDelegate?.SVProgressStatus(true)
        APIServices.getDriverReports(from, to) { (reports) in
            self.mainViewDelegate?.SVProgressStatus(false)
            if let _ = reports{
                self.mainViewDelegate?.didCompleteWithReports(reports)
            }else{
                self.mainViewDelegate?.didCompleteWithReports(nil)
            }
        }
    }
    
    func getTripBy(id: String){
        self.mainViewDelegate?.SVProgressStatus(true)
        APIServices.getTripBy(id) { (reponse) in
            self.mainViewDelegate?.SVProgressStatus(false)
            if let _ = reponse{
                self.mainViewDelegate?.didCompleteWithTripByID(reponse?.trip)
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
    
}
