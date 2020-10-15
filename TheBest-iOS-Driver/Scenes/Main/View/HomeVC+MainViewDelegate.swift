//
//  HomeVC+HomeViewDelegate.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 10/16/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import SVProgressHUD

extension HomeVC: MainViewDelegate{
    
    func SVProgressStatus(_ show: Bool) {
        if show{
            SVProgressHUD.show()
        }else{
            SVProgressHUD.dismiss()
        }
    }
    
    func didCompletedWithOrders(_ orders: [MyOrder]?) {
        if let orders = orders,
            !orders.isEmpty
        {
            self.orders = orders
            self.emptyLbl.isHidden = true
            self.loadTableFromNib()
        }else{
            self.emptyLbl.isHidden = false
        }
    }
    
}
