//
//  ReportsVC+UITableViewDelegate.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/23/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import UIKit

extension ReportsVC: UITableViewDelegate, UITableViewDataSource{
    func loadOrdersTableFromNib(){
        
        let nib = UINib(nibName: "IncomingOrderTableViewCell", bundle: nil)
        self.ordersTableView.register(nib, forCellReuseIdentifier: "IncomingOrderTableViewCell")
        
        self.ordersTableView.delegate = self
        self.ordersTableView.dataSource = self
        
        self.ordersTableView.reloadData()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myTrips!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "IncomingOrderTableViewCell", for: indexPath) as! IncomingOrderTableViewCell
        cell.loadFrom(self.myTrips![indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
    
}
