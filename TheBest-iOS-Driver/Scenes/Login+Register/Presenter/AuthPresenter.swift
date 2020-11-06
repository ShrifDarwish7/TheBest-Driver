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
    func didCompleteLoginWith(_ error: NSError?,_ banned: String?)
    func didCompletedRegister(_ registered: Bool)
    func didCompleteUpdatingProfile(_ response: ProfileResponse?)
}

extension AuthViewDelegate{
    func SVProgressStatus(_ show: Bool){}
    func didCompleteLoginWith(_ error: NSError?,_ banned: String?){}
    func didCompletedRegister(_ registered: Bool){}
    func didCompleteUpdatingProfile(_ response: ProfileResponse?){}
}

class AuthPresenter{
    
    var authViewDelegate: AuthViewDelegate?
    
    init(authViewDelegate: AuthViewDelegate) {
        self.authViewDelegate = authViewDelegate
    }
    
    func loginWith(email: String, password: String, fcmToken: String){
        self.authViewDelegate?.SVProgressStatus(true)
        AuthServices.loginWith(email, password, fcmToken, completed: { (completed) in
            self.authViewDelegate?.SVProgressStatus(false)
            if completed{
                self.authViewDelegate?.didCompleteLoginWith(nil, nil)
            }else{
                self.authViewDelegate?.didCompleteLoginWith(NSError(domain: "Login Failed", code: 0, userInfo: nil), nil)
            }
        }) { (bannedMsg) in
            if let _ = bannedMsg{
                self.authViewDelegate?.didCompleteLoginWith(nil, bannedMsg)
            }
        }
    }
    
    func registerWith(info: DriverInfo){
        self.authViewDelegate?.SVProgressStatus(true)
        AuthServices.registerWith(driverInfo: info) { (completed) in
            if completed{
                self.authViewDelegate?.didCompletedRegister(true)
            }else{
                self.authViewDelegate?.didCompletedRegister(false)
            }
        }
    }
    
    func updateProfile(info: DriverInfo){
        self.authViewDelegate?.SVProgressStatus(true)
        AuthServices.updateProfile(body: info) { (response) in
            self.authViewDelegate?.SVProgressStatus(false)
            if let _ = response{
                self.authViewDelegate?.didCompleteUpdatingProfile(response)
            }else{
                self.authViewDelegate?.didCompleteUpdatingProfile(nil)
            }
        }
    }
    
}
