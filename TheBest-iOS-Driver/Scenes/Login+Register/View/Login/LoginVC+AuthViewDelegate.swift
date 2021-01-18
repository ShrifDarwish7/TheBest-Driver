//
//  LoginVC+AuthViewDelegate.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 10/8/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import SVProgressHUD

extension LoginVC: AuthViewDelegate{

    func SVProgressStatus(_ show: Bool) {
        switch show {
        case true:
            SVProgressHUD.show()
        default:
            SVProgressHUD.dismiss()
        }
    }
    
    func didCompleteLoginWith(_ error: NSError?, _ banned: String?) {
        if let _ = error{
            self.showAlert(title: error!.domain, message: "An error occured when attemping to login, please try again later")
        }else if let  _ = banned{
            self.showAlert(title: error!.domain, message: banned!)
        }else{
            Router.toHome(self)
        }
    }
    
}
