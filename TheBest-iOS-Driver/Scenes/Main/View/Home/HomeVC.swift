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

class HomeVC: UIViewController {

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
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var bottomSheetPosition: NSLayoutConstraint!
    @IBOutlet weak var blockView: UIView!
    @IBOutlet weak var endRideBtn: UIButton!
    @IBOutlet weak var goBtn: UIButton!
    @IBOutlet weak var clientName: UILabel!
    @IBOutlet weak var clientPhone: UILabel!
    
    let locationManager = CLLocationManager()
    var mainPresenter: MainPresenter?
    var marker = GMSMarker()
    var camera: GMSCameraPosition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomSheetPosition.constant = -400
        NotificationCenter.default.addObserver(self, selector: #selector(closeDrawer), name: NSNotification.Name(rawValue: "CloseDrawer"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(receivedOrderFromFCM(sender:)), name: NSNotification.Name(rawValue: "ReceivedOrderFromFCM"), object: nil)
        
        mainPresenter = MainPresenter(self)
        
        loadUI()
                
        popupView.transform = CGAffineTransform(scaleX: 0, y: 0)
        popupView.layer.cornerRadius = 15
        allowBtn.layer.cornerRadius = 15
        denyBtn.layer.cornerRadius = 15
        
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
    
    func loadUI(){
        
        bottomSheetView.setupShadow()
        bottomSheetView.layer.cornerRadius = 15
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
        
        drawerPosition.constant = self.view.frame.width
        upperView.setupShadow()
        upperView.layer.cornerRadius = upperView.frame.height/2
        
        drawerBtn.onTap {
            Drawer.open(self.drawerPosition, self)
        }
        
    }
    
    @objc func receivedOrderFromFCM(sender: NSNotification){
        handleIncomingOrder()
    }
    
    func handleIncomingOrder(){
        if let _ = SharedData.receivedOrder{
            clientName.text = SharedData.receivedOrder?.clientName
            clientPhone.text = SharedData.receivedOrder?.clientPhone
            mainPresenter?.getAdressWith(location: "\(SharedData.receivedOrder?.clientLat ?? ""),\(SharedData.receivedOrder?.clientLng ?? "")")
            UIView.animate(withDuration: 0.3) {
                self.acceptOrderBtn.isHidden = false
                self.denyOrderBtn.isHidden = false
                self.endRideBtn.isHidden = true
                self.goBtn.isHidden = true
            }
            showBottomSheet()
        }
    }
    
    func showBottomSheet(){
        //self.blockView.isHidden = false
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, animations: {
          //  self.blockView.alpha = 1
            self.bottomSheetPosition.constant = 15
            self.view.layoutIfNeeded()
        }) { (_) in
            
        }
    }
    
    @IBAction func acceptOrderAction(_ sender: Any) {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways , .authorizedWhenInUse:
            mainPresenter?.acceptOrder(id: AuthServices.instance.profile.id, clientID: SharedData.receivedOrder!.clientID)
        default:
            self.askForLocationAlert()
        }
    }
    
    @IBAction func denyOrderAction(_ sender: Any) {
        self.bottomSheetPosition.constant = -400
        UIView.animate(withDuration: 0.3, animations: {
            self.blockView.alpha = 0
            self.view.layoutIfNeeded()
        }) { (_) in
            self.blockView.isHidden = true
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

