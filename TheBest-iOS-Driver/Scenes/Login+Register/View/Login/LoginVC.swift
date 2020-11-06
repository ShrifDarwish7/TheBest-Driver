//
//  LoginVC.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 10/2/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit
import CoreLocation

class LoginVC: UIViewController {

    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var usernameView: UIView!
    @IBOutlet weak var passView: UIView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!
    
    var authPresenter: AuthPresenter?
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authPresenter = AuthPresenter(authViewDelegate: self)
        loadUI()
        requestLocationPermission()
    }
    
    func loadUI(){
        loginView.setupShadow()
        loginView.layer.cornerRadius = 15
        usernameView.layer.cornerRadius = usernameView.frame.height/2
        passView.layer.cornerRadius = passView.frame.height/2
        loginBtn.layer.cornerRadius = 15
        signupBtn.layer.cornerRadius = 15
    }
    
    @IBAction func loginAction(_ sender: Any) {
        guard !self.usernameTF.text!.isEmpty, !self.passTF.text!.isEmpty else {
            showAlert(title: "", message: "Please enter your email and password")
            return
        }
        self.authPresenter?.loginWith(email: self.usernameTF.text!, password: self.passTF.text!, fcmToken: UserDefaults.init().string(forKey: "FCM_Token") ?? "")
    }
    
    @IBAction func signupAction(_ sender: Any) {
        Router.toSignUp(self)
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

