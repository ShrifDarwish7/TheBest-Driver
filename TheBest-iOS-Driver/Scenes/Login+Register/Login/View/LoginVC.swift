//
//  LoginVC.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 10/2/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var usernameView: UIView!
    @IBOutlet weak var passView: UIView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
        
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
        Router.toHome(self)
    }
    
    @IBAction func signupAction(_ sender: Any) {
        Router.toSignUp(self)
    }
    
}

