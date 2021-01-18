//
//  HomeVC.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/22/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
import SwiftToast
import AVFoundation
import SVProgressHUD
import FirebaseDatabase

class HomeVC: UIViewController{
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var drawerBtn: UIButton!
    @IBOutlet weak var drawerPosition: NSLayoutConstraint!
    @IBOutlet weak var blurBlockView: UIVisualEffectView!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var allowBtn: UIButton!
    @IBOutlet weak var denyBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyLbl: UILabel!
    @IBOutlet weak var GMSView: GMSMapView!
    @IBOutlet weak var totalTrip: UILabel!
    @IBOutlet weak var ordersTableView: UITableView!
    @IBOutlet weak var bottomSheetView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var fromView: UIView!
    @IBOutlet weak var toView: UIView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var orderInfo: UIView!
    @IBOutlet weak var acceptOrderBtn: UIButton!
    @IBOutlet weak var denyOrderBtn: UIButton!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var addressFrom: UILabel!
    @IBOutlet weak var addressTo: UILabel!
    //@IBOutlet weak var total: UILabel!
    @IBOutlet weak var bottomSheetPosition: NSLayoutConstraint!
    @IBOutlet weak var blockView: UIView!
    @IBOutlet weak var endRideBtn: UIButton!
    @IBOutlet weak var goBtn: UIButton!
    @IBOutlet weak var clientName: UILabel!
    @IBOutlet weak var clientPhone: UILabel!
    @IBOutlet weak var draggableView: UIView!
    @IBOutlet weak var bottomSheetTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var draggableSubView: UIView!
    @IBOutlet weak var rideTypeIcon: UIImageView!
    @IBOutlet weak var rideType: UILabel!
    @IBOutlet weak var billView: ViewCorners!
    @IBOutlet weak var paidTF: UITextField!
    @IBOutlet weak var completeTripBtn: RoundedButton!
    @IBOutlet weak var counterLbl: UILabel!
    // Furniture Stuff
    @IBOutlet weak var furnitureView: ViewCorners!
    @IBOutlet weak var furnServiceName: UILabel!
    @IBOutlet weak var furnDate: UILabel!
    @IBOutlet weak var furnWorkersCount: UILabel!
    @IBOutlet weak var furnSpecCount: UILabel!
    @IBOutlet weak var furnCarsCount: UILabel!
    // Road services stuff
    @IBOutlet weak var RoadServicesView: ViewCorners!
    @IBOutlet weak var rsImage: UIImageView!
    @IBOutlet weak var rsType: UILabel!
    @IBOutlet weak var rsCost: UILabel!
    @IBOutlet weak var rsDesc: UILabel!
    // Special need stuff
    @IBOutlet weak var specialNeedView: ViewCorners!
    @IBOutlet weak var spPriceMethod: UILabel!
    @IBOutlet weak var spCar: UILabel!
    @IBOutlet weak var spEquipments: UILabel!
    // Monthly stuff
    @IBOutlet weak var monthlyView: ViewCorners!
    @IBOutlet weak var days: UILabel!
    @IBOutlet weak var fromDAte: UILabel!
    @IBOutlet weak var toDate: UILabel!
    @IBOutlet weak var goingTime: UILabel!
    @IBOutlet weak var comingTime: UILabel!
    @IBOutlet weak var needs: UILabel!
    @IBOutlet weak var going_returnView: ViewCorners!
    @IBOutlet weak var cancelTripBtn: UIButton!
    
    @IBOutlet weak var foodView: ViewCorners!
    
    let locationManager = CLLocationManager()
    var mainPresenter: MainPresenter?
    var marker = GMSMarker()
    var camera: GMSCameraPosition?
    var bottomSheetPanStartingTopConstant : CGFloat = 30.0
    var trip: MyTrip?
    var counter = 60
    var timer = Timer()
    var player: AVAudioPlayer?
    var orders = [Order]()
    var priceFromDistance: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        topView.isHidden = true
        
       // NotificationCenter.default.addObserver(self, selector:#selector(appMovedToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        let viewPan = UIPanGestureRecognizer(target: self, action: #selector(viewPanned(_:)))
        viewPan.delaysTouchesBegan = false
        viewPan.delaysTouchesEnded = false
        self.draggableView.addGestureRecognizer(viewPan)
        
        draggableView.addTapGesture { (_) in
            self.bottomSheetTopConstraint.constant = 400
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, animations: {
                self.view.layoutIfNeeded()
            }) { (_) in
                
            }
        }
        
        cancelTripBtn.setTitle("Cancel trip".localized, for: .normal)
        
       // bottomSheetPosition.constant = -400
        NotificationCenter.default.addObserver(self, selector: #selector(closeDrawer), name: NSNotification.Name(rawValue: "CloseDrawer"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(receivedOrderFromFCM(sender:)), name: NSNotification.Name(rawValue: "ReceivedOrderFromFCM"), object: nil)
        
        mainPresenter = MainPresenter(self)
        
        
        loadUI()
                
        popupView.transform = CGAffineTransform(scaleX: 0, y: 0)
        popupView.layer.cornerRadius = 15
        allowBtn.layer.cornerRadius = 15
        denyBtn.layer.cornerRadius = 15
        cancelTripBtn.layer.cornerRadius = 15
        
        denyBtn.onTap {
            self.blurBlockView.isHidden = true
            self.popupView.transform = CGAffineTransform(scaleX: 0, y: 0)
        }
        
        allowBtn.onTap {
           if let BUNDLE_IDENTIFIER = Bundle.main.bundleIdentifier,
                let url = URL(string: "\(UIApplication.openSettingsURLString)&path=LOCATION/\(BUNDLE_IDENTIFIER)") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            self.blurBlockView.isHidden = true
            self.popupView.transform = CGAffineTransform(scaleX: 0, y: 0    )
        }
        
        handleIncomingOrder()
        mainPresenter?.getProfile()
    }
    
//    @objc func appMovedToForeground(){
//        AppDelegate.player?.stop()
//    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        timer.invalidate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        requestLocationPermission()
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways , .authorizedWhenInUse:
            print("")
        default:
            self.askForLocationAlert()
        }
    }
    
    @objc func closeDrawer(){
        Drawer.close(drawerPosition, self)
    }
    
    @IBAction func cancelTripACtion(_ sender: Any) {
        SVProgressHUD.show()
        APIServices.cancelRide { (done) in
            SVProgressHUD.dismiss()
            if done{
                Router.toCancelation(self)
            }
        }
    }
    
    @objc func viewPanned(_ panRecognizer: UIPanGestureRecognizer){
        let translation = panRecognizer.translation(in: self.view)
        let velocity = panRecognizer.velocity(in: self.view)
    
        switch panRecognizer.state {
        case .began:
            bottomSheetPanStartingTopConstant = self.bottomSheetTopConstraint.constant
        case .changed:
            
            if self.bottomSheetPanStartingTopConstant + translation.y > 200 {
                self.bottomSheetTopConstraint.constant = self.bottomSheetPanStartingTopConstant + translation.y
            }

        case .ended:
            print(velocity.y)
//            if velocity.y > 1500.0 {
//
//                let safeAreaHeight = UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.size.height
//             //   let bottomPadding = UIApplication.shared.keyWindow?.safeAreaInsets.bottom
//                self.bottomSheetTopConstraint.constant = safeAreaHeight! - CGFloat(35)
//
//              UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, animations: {
//                  self.view.layoutIfNeeded()
//              }) { (_) in
//
//                }
//            }else if velocity.y < 10{
//
//                self.bottomSheetTopConstraint.constant = UIApplication.shared.statusBarFrame.height + CGFloat(110)
//
//                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, animations: {
//                    self.view.layoutIfNeeded()
//                }) { (_) in
//
//                }
//
//            }
            
        default:
            break
        }
    }
    
    func loadUI(){
        
        draggableSubView.layer.cornerRadius = draggableSubView.frame.height/2
       // bottomSheetView.setupShadow()
        bottomSheetView.clipsToBounds = true
        bottomSheetView.roundCorners([.layerMinXMinYCorner,.layerMaxXMinYCorner], radius: 15)
        fromView.layer.cornerRadius = fromView.frame.height/2
        fromView.layer.borderWidth = 1.5
        fromView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        toView.layer.cornerRadius = toView.frame.height/2
        acceptOrderBtn.layer.cornerRadius = 10
        denyOrderBtn.layer.cornerRadius = 10
        endRideBtn.layer.cornerRadius = 10
        goBtn.layer.cornerRadius = 10
        orderInfo.layer.cornerRadius = 15
        topView.layer.cornerRadius = 15
        
        drawerPosition.constant = "lang".localized == "ar" ? self.view.frame.width : -self.view.frame.width
        upperView.setupShadow()
        upperView.layer.cornerRadius = upperView.frame.height/2
        
        drawerBtn.onTap {
            Drawer.open(self.drawerPosition, self)
        }
        
    }
    
    @IBAction func completeTripAction(_ sender: Any) {
        
        var parameters: [String: Any] = ["trip_id": self.trip?.id ?? 0]
        
        switch self.trip?.rideType ?? 40 {
        case 40,41,43:
            parameters.updateValue(self.trip?.order?.first?.total ?? "0", forKey: "total_order")
            parameters.updateValue(self.priceFromDistance ?? 0, forKey: "total")
        default:
            parameters.updateValue("0", forKey: "total_order")
            parameters.updateValue(self.trip?.total ?? "0.0", forKey: "total")
        }
     
        SVProgressHUD.show()
        APIServices.postRidePrice(parameters) { [self] (done) in
            SVProgressHUD.dismiss()
            if done{
                mainPresenter?.endRide(id: "\(self.trip?.id ?? 0)", total: paidTF.text!)
            }
        }
    }
    
    
    @objc func receivedOrderFromFCM(sender: NSNotification){
        handleIncomingOrder()
    }
    
    func handleIncomingOrder(){
        if let _ = SharedData.receivedOrder{
            playSound(fileName: "loud_beeps")
            endRideBtn.isHidden = true
            furnitureView.isHidden = true
            RoadServicesView.isHidden = true
            monthlyView.isHidden = true
            specialNeedView.isHidden = true
            billView.isHidden = true
            
            clientName.text = SharedData.receivedOrder?.clientName
            clientPhone.text = SharedData.receivedOrder?.clientPhone
            mainPresenter?.getAdressWith(location: "\(SharedData.receivedOrder?.clientLat ?? ""),\(SharedData.receivedOrder?.clientLng ?? "")")
            if let _ = SharedData.receivedOrder?.tripID{
                mainPresenter?.getTripBy(id: SharedData.receivedOrder!.tripID)
               // mainPresenter?.getTripBy(id: "1323")
            }
            UIView.animate(withDuration: 0.3) {
                self.acceptOrderBtn.isHidden = false
                self.denyOrderBtn.isHidden = false
                self.endRideBtn.isHidden = true
                self.goBtn.isHidden = true
            }
            showBottomSheet()
            
            counter = 60
            timer.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] (Timer) in
                self.counterLbl.isHidden = false
                if self.counter > 0 {
                    self.counter -= 1
                    counterLbl.text = "00:\(counter)"
                } else {
                    self.bottomSheetTopConstraint.constant = self.view.frame.height
                    UIView.animate(withDuration: 0.3) {
                        self.view.layoutIfNeeded()
                    } completion: { (_) in
                        self.bottomSheetView.isHidden = true
                    }
                    Timer.invalidate()
                    self.player?.stop()
                }
            }
          //  SharedData.receivedOrder = nil
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
    
    
    

    func playSound(fileName: String) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url)
            player!.numberOfLoops =  -1
            player!.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
  
    @IBAction func forwardToWhatsapp(_ sender: Any) {
        let urlWhats = "whatsapp://send?phone=\(SharedData.receivedOrder!.clientPhone)"
        
        let characterSet = CharacterSet.urlQueryAllowed
       // characterSet.insert(charactersIn: "?&")
        
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: characterSet){
            
            if let whatsappURL = NSURL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL as URL){
                    UIApplication.shared.open(whatsappURL as URL, completionHandler: nil)
                }
                else {
                    print("Install Whatsapp")
                    
                }
            }
        }
    }
    
    @IBAction func callClient(_ sender: Any) {
        AppDelegate.call(phoneNumber: SharedData.receivedOrder!.clientPhone)
    }
    
    @IBAction func goAction(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            
            let lat = Double(SharedData.receivedOrder!.clientLat)!
            let lng = Double(SharedData.receivedOrder!.clientLng)!
            AppDelegate.forwardToGoogleMapsApp(lat: lat, lng: lng)
            
        default:
            
            let lat = (self.trip?.toLat)!
            let lng = (self.trip?.toLng)!
            AppDelegate.forwardToGoogleMapsApp(lat: lat, lng: lng)
            
        }
        
        
    }
    
    
    func showBottomSheet(){
        //self.blockView.isHidden = false
        self.bottomSheetView.isHidden = false
        self.bottomSheetTopConstraint.constant = 400
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, animations: {
          //  self.blockView.alpha = 1
       //     self.bottomSheetPosition.constant = 15
            self.view.layoutIfNeeded()
        }) { (_) in
            
        }
    }
    
    @IBAction func acceptOrderAction(_ sender: Any) {
        self.timer.invalidate()
        player?.stop()
        self.counterLbl.isHidden = true        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways , .authorizedWhenInUse:
            mainPresenter?.acceptOrder(id: AuthServices.instance.profile.id, clientID: SharedData.receivedOrder!.clientID)
        default:
            self.askForLocationAlert()
        }
    }
    
    @IBAction func denyOrderAction(_ sender: Any) {
       // self.bottomSheetPosition.constant = -400
        self.timer.invalidate()
        player?.stop()
        self.counterLbl.isHidden = true
        UIView.animate(withDuration: 0.3, animations: {
            self.blockView.alpha = 0
            self.view.layoutIfNeeded()
        }) { (_) in
            self.blockView.isHidden = true
        }
    }
    
    @IBAction func arrivedAction(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            mainPresenter?.confirmDriverHere(id: SharedData.receivedOrder!.clientID)
        case 1:
            mainPresenter?.startRide(id: "\(self.trip?.id ?? 0)", trip: self.trip!)
        case 2:
            switch self.trip?.rideType ?? 40 {
            case 40,41,43:
                let parameters = [
                    "latitudeFrom": self.trip?.fromLat ?? 0.0,
                    "longitudeFrom": self.trip?.fromLng ?? 0.0,
                    "latitudeTo": self.trip?.toLat ?? 0.0,
                    "longitudeTo": self.trip?.toLng ?? 0.0,
                ] as [String: Any]
                SVProgressHUD.show()
                APIServices.getDistance(parameters) { (dis) in
                    SVProgressHUD.dismiss()
                    if let _ = dis{
                        self.priceFromDistance = dis?.cost
                        self.totalTrip.text = "\((dis?.cost ?? 0.0) + Double(self.trip?.order?.first?.total ?? "0.0")!) KWT"
                        print(dis)
                    }
                }
            default:
                break
            }
            self.billView.isHidden = false
            endRideBtn.isHidden = true
//            mainPresenter?.endRide(id: "\(self.trip?.id ?? 0)")
        default:
            break
        }
    }
    
    
    func askForLocationAlert(){
        self.blurBlockView.isHidden = false
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.8, options: [], animations: {
            self.popupView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }) { (_) in
            
        }
    }

}

