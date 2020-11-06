//
//  ReportsVC+MainViewDelegate.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/23/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import SVProgressHUD

extension ReportsVC: MainViewDelegate{
    
    func SVProgressStatus(_ show: Bool) {
        if show{
            SVProgressHUD.show()
        }else{
            SVProgressHUD.dismiss()
        }
    }
    
    func didCompleteWithReports(_ reports: ReportsResponse?) {
        if let _ = reports{
            if (reports?.myTrips.isEmpty)!{
                self.empty.isHidden = false
                self.ordersTableView.isHidden = true
            }else{
                self.myTrips = reports?.myTrips
                self.empty.isHidden = true
                self.loadOrdersTableFromNib()
                self.ordersTableView.isHidden = false
                self.canceled.text = "\(reports?.myTripsCanceled ?? 0)"
                self.completed.text = "\(reports?.myTripsCompleted ?? 0)"
                self.totalOrders.text = "\(reports?.myTripsCount ?? 0)"
                self.totalMoney.text = "\(reports?.myTripsMoney ?? 0) KWD"
            }
        }else{
            self.empty.isHidden = false
        }
    }
}
