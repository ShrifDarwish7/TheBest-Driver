//
//  SignUpVC+AuthViewDelegate.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 10/30/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import SVProgressHUD

extension SignUpVC: AuthViewDelegate{
    
    func SVProgressStatus(_ show: Bool) {
        switch show {
        case true:
            SVProgressHUD.show()
        default:
            SVProgressHUD.dismiss()
        }
    }
    
    func didCompletedRegister(_ registered: Bool) {
        if registered{
            if AuthServices.instance.profile.status == "WatingForApproval"{
                showAlert(title: "", message: "WatingForApproval")
            }else{
                
            }
        }
    }
    
    func didCompleteUpdatingProfile(_ response: ProfileResponse?) {
        if let _ = response{
            self.showAlert(title: "", message: "Profile updated successfully")
        }else{
            self.showAlert(title: "", message: "An error occured when attempting to update profile, please try again later")
        }
    }
    
}
