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
    func didCompleteWithSpecialty(_ specialty:[Specialty]?)
    func didCompleteAddSpecialty(_ completed: Bool)
    func didCompleteWithCountries(_ result: [Country]?)
}

extension AuthViewDelegate{
    func SVProgressStatus(_ show: Bool){}
    func didCompleteLoginWith(_ error: NSError?,_ banned: String?){}
    func didCompletedRegister(_ registered: Bool){}
    func didCompleteUpdatingProfile(_ response: ProfileResponse?){}
    func didCompleteWithSpecialty(_ specialty:[Specialty]?){}
    func didCompleteAddSpecialty(_ completed: Bool){}
    func didCompleteWithCountries(_ result: [Country]?){}
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
    
    func getSpecialty(){
        self.authViewDelegate?.SVProgressStatus(true)
        AuthServices.getDriversSpecialty { (result) in
            self.authViewDelegate?.SVProgressStatus(false)
            if let _ = result{
                self.authViewDelegate?.didCompleteWithSpecialty(result?.driversSpecialty)
            }else{
                self.authViewDelegate?.didCompleteWithSpecialty(nil)
            }
        }
    }
    
    func addSpecialty(_ ids: [Int]){
        self.authViewDelegate?.SVProgressStatus(true)
        AuthServices.addSpecialty(body: ids) { (done) in
            self.authViewDelegate?.SVProgressStatus(false)
            if done{
                self.authViewDelegate?.didCompleteAddSpecialty(true)
            }else{
                self.authViewDelegate?.didCompleteAddSpecialty(false)
            }
        }
    }
    
    func getCountries(){
        self.authViewDelegate?.SVProgressStatus(true)
        AuthServices.getCountries { (reponse) in
            self.authViewDelegate?.SVProgressStatus(false)
            if let _ = reponse{
                self.authViewDelegate?.didCompleteWithCountries(reponse?.countries.data)
            }else{
                self.authViewDelegate?.didCompleteWithCountries(nil)
            }
        }
    }
    
}
