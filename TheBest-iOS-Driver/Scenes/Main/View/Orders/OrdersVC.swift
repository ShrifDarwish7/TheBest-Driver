//
//  OrdersVC.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 11/3/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit
import CoreLocation

class OrdersVC: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var drawerBtn: UIButton!
    @IBOutlet weak var drawerPosition: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyLbl: UILabel!
    
    let locationManager = CLLocationManager()
    var mainPresenter: MainPresenter?
    var orders: [MyTrip]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainPresenter = MainPresenter(self)
        mainPresenter?.getMyOrders()
        
        NotificationCenter.default.addObserver(self, selector: #selector(closeDrawer), name: NSNotification.Name(rawValue: "CloseDrawer"), object: nil)
        
        loadUI()
                
//        popupView.transform = CGAffineTransform(scaleX: 0, y: 0)
//        popupView.layer.cornerRadius = 15
//        allowBtn.layer.cornerRadius = 15
//        denyBtn.layer.cornerRadius = 15
//
//        denyBtn.onTap {
//            self.blurBlockView.isHidden = true
//            self.popupView.transform = CGAffineTransform(scaleX: 0, y: 0)
//        }
//
//        allowBtn.onTap {
//           if let BUNDLE_IDENTIFIER = Bundle.main.bundleIdentifier,
//                let url = URL(string: "\(UIApplication.openSettingsURLString)&path=LOCATION/\(BUNDLE_IDENTIFIER)") {
//                UIApplication.shared.open(url, options: [:], completionHandler: nil)
//            }
//            self.blurBlockView.isHidden = true
//            self.popupView.transform = CGAffineTransform(scaleX: 0, y: 0    )
//        }

    }
    
    @objc func closeDrawer(){
        Drawer.close(drawerPosition, self)
    }
    
    func loadUI(){
        
        drawerPosition.constant = "lang".localized == "en" ? self.view.frame.width : -self.view.frame.width
        upperView.setupShadow()
        upperView.layer.cornerRadius = upperView.frame.height/2
        
        drawerBtn.onTap {
            Drawer.open(self.drawerPosition, self)
        }
        
    }
    
    
//    func askForLocationAlert(){
//        self.blurBlockView.isHidden = false
//        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.8, options: [], animations: {
//            self.popupView.transform = CGAffineTransform(scaleX: 1, y: 1)
//        }) { (_) in
//
//        }
//    }

}
