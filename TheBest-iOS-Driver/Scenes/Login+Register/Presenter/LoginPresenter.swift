//
//  LoginPresenter.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 10/8/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

protocol AuthViewDelegate {
    func SVProgressStatus(_ show: Bool)
    func didCompleteLoginWith(_ error: NSError?)
}

class AuthPresenter{
    
    var authViewDelegate: AuthViewDelegate?
    
    init(authViewDelegate: AuthViewDelegate) {
        self.authViewDelegate = authViewDelegate
    }
    
    func loginWith(email: String, password: String, fcmToken: String){
        self.authViewDelegate?.SVProgressStatus(true)
        AuthServices.loginWith(email, password, fcmToken) { (completd) in
            self.authViewDelegate?.SVProgressStatus(false)
            if completd{
                self.authViewDelegate?.didCompleteLoginWith(nil)
            }else{
                self.authViewDelegate?.didCompleteLoginWith(NSError(domain: "Login Failed", code: 0, userInfo: nil))
            }
        }
    }
    
}
