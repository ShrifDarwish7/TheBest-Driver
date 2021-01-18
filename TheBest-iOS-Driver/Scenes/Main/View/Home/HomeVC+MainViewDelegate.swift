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
import FirebaseDatabase

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
                self.cancelTripBtn.isHidden = false
                
                UIView.animate(withDuration: 0.3) {
                    self.acceptOrderBtn.isHidden = true
                    self.denyOrderBtn.isHidden = true
                    self.endRideBtn.isHidden = false
                    self.goBtn.isHidden = false
                }
            }
        }
    }
    
    func didCompleteWithProfle(profile: ProfileResponse?) {
        if let trip = profile?.currnetTrip{
            SharedData.receivedOrder = ReceivedOrder(
                userInfo: [
                    "trip_id": "\(trip.id ?? 0)",
                    "user_id": "\(trip.clientID ?? 0)",
                    "name": "\(trip.username ?? "")",
                    "phone": "\(trip.phone ?? "")",
                    "lat": "\(trip.fromLat ?? 0.0)",
                    "lng": "\(trip.fromLng ?? 0.0)"
                ]
            )
            self.didCompleteWithTripByID(trip)
            clientName.text = SharedData.receivedOrder?.clientName
            clientPhone.text = SharedData.receivedOrder?.clientPhone
            showBottomSheet()
            self.counterLbl.isHidden = true
            switch trip.status {
            case SharedData.inProgressStatus: // accepted
                UIView.animate(withDuration: 0.3) {
                    self.acceptOrderBtn.isHidden = true
                    self.denyOrderBtn.isHidden = true
                    self.endRideBtn.isHidden = false
                    self.goBtn.isHidden = false
                    self.cancelTripBtn.isHidden = false
                }
            case SharedData.arrivedStatus: // arrived
                cancelTripBtn.isHidden = true
                goBtn.tag = 1
                endRideBtn.tag = 1
                endRideBtn.setTitle("Start ride".localized, for: .normal)
                endRideBtn.backgroundColor = UIColor(named: "MainColor")
            case SharedData.orderOnDeliveryStatus: // started
                endRideBtn.tag = 2
                endRideBtn.setTitle("End ride".localized, for: .normal)
                endRideBtn.backgroundColor = UIColor.red
            default:
               break
            }
            var ref: DatabaseReference!
            ref = Database.database().reference()
            ref.child("Orders").child((SharedData.receivedOrder?.tripID)!).observe(.value) { (snapshot) in
              //  NotificationCenter.default.post(name: NSNotification.Name("ReceivedTripId"), object: nil, userInfo: ["ReceivedTripId": tripID])
                if let dic = snapshot.value as? [String : AnyObject]{
                    if dic["is_user"]?.boolValue == true{
                        self.playSound(fileName: "loud_alert")
                        let alert = UIAlertController(title: "Trip has been canceled", message: "Your client has canceled your trip, due to " + ((dic["reason"]!) as! String), preferredStyle: .alert)
                        let action = UIAlertAction(title: "Done", style: .cancel) { (_) in
                            self.player?.stop()
                        }
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    func didCompleteWithTripByID(_ trip: MyTrip?) {
        
        if let _ = trip{
            self.trip = trip
            self.totalTrip.text = "\(trip?.total ?? "0.0")" + " " + "KWT"
            self.topView.isHidden = false
            self.topView.backgroundColor = SharedData.getColor((trip?.rideType) ?? 40)
            self.rideTypeIcon.image = SharedData.getRideType((trip?.rideType) ?? 40).icon
            self.rideType.text = SharedData.getRideType((trip?.rideType) ?? 40).name
            
            switch trip?.rideType ?? 40 {
            case 16:
                
                if let furnitureTrip = trip?.tripFurniture?.first{
                    self.furnitureView.isHidden = false
                    furnDate.text = (furnitureTrip.date ?? "") + " " + (furnitureTrip.time ?? "")
                    furnServiceName.text = furnitureTrip.serviceName
                    furnWorkersCount.text = "(\(furnitureTrip.workersCount ?? "0"))"
                    furnSpecCount.text = "(\(furnitureTrip.techsCount ?? "0"))"
                    furnCarsCount.text = "(\(furnitureTrip.serviceCount ?? "0"))"
                }
                
            case 15:
                
                if let rsTrip = trip?.tripRoadServices?.first{
                    RoadServicesView.isHidden = false
                    rsImage.sd_setImage(with: URL(string: rsTrip.serviceImage ?? ""))
                    rsType.text = (rsTrip.serviceCount ?? "") + " X " + (rsTrip.serviceName ?? "")
                    rsCost.text = "(\(rsTrip.servicePrice ?? "")) KWD"
                    rsDesc.text = rsTrip.serviceDesc ?? ""
                }
                
            case 4:
                
                if let spTrip = trip?.tripPrivateCars?.first{
                    specialNeedView.isHidden = false
                    spPriceMethod.text = spTrip.priceMethod ?? ""
                    spCar.text = spTrip.carType ?? ""
                    spEquipments.text = spTrip.equipments ?? ""
                }
                
            case 17:
                
                if let monthlyTrip = trip?.tripMonthly?.first{
                    monthlyView.isHidden = false
                    if let days = monthlyTrip.workingDays?.joined(separator: ", "){
                        self.days.text = days
                    }
                    fromDAte.text = monthlyTrip.fromDate
                    toDate.text = monthlyTrip.toDate
                    goingTime.text = monthlyTrip.fromTime
                    comingTime.text = monthlyTrip.toTime
                    needs.text = monthlyTrip.needs ?? ""
                    going_returnView.isHidden = monthlyTrip.goingComing == 0 ? true : false
                }
                
            case 40,41,43:
                
                if let order = trip?.order{
                    
                    self.orders.append(order.first!)
                    self.foodView.isHidden = false
                    self.loadOrdersTableFromNib()
                    
                }
                
            default:
                break
            }
            
        }
    }
    
    func didCompleteChangeStatus(_ done: Bool) {
        if done{
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
            cancelTripBtn.isHidden = true
            goBtn.tag = 1
            endRideBtn.tag = 1
            endRideBtn.setTitle("Start ride".localized, for: .normal)
            endRideBtn.backgroundColor = UIColor(named: "MainColor")
            self.mainPresenter?.changeOrderStatus(id: "\((self.trip?.id)!)", status: SharedData.arrivedStatus)
            
        }else{
            print("didCompleteConfirmDriverHere faild")
        }
    }
    
    func didCompleteStartRide(_ done: Bool) {
        if done{
            endRideBtn.tag = 2
            endRideBtn.setTitle("End ride".localized, for: .normal)
            endRideBtn.backgroundColor = UIColor.red
            self.mainPresenter?.changeOrderStatus(id: "\((self.trip?.id)!)", status: SharedData.orderOnDeliveryStatus)
        }else{
            
        }
    }
    
    func didCompleteEndRide(_ done: Bool) {
        if done{
//            self.billView.isHidden = false
            Router.toTripInfo(self, trip: trip!)
            showAlert(title: "", message: "Trip ended successfully".localized)
            self.mainPresenter?.changeOrderStatus(id: "\((self.trip?.id)!)", status: SharedData.completedStatus)
        }else{
            
        }
    }
    
}
