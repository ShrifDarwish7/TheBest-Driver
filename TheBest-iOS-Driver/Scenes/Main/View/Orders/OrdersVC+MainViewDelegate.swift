//
//  OrdersVC+MainViewDelegate.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 11/3/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import SVProgressHUD

extension OrdersVC: MainViewDelegate{
    
    func SVProgressStatus(_ show: Bool) {
        if show{
            SVProgressHUD.show()
        }else{
            SVProgressHUD.dismiss()
        }
    }
    
    func didCompletedWithOrders(_ orders: [MyTrip]?) {
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
