//
//  HomeVC+TableViewDelegate.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 13/01/2021.
//  Copyright © 2021 Sherif Darwish. All rights reserved.
//

import Foundation
import UIKit

extension HomeVC: UITableViewDelegate, UITableViewDataSource{
    
    func loadOrdersTableFromNib(){
        
        let nib = UINib(nibName: "OrdersTableViewCell", bundle: nil)
        self.ordersTableView.register(nib, forCellReuseIdentifier: "OrdersTableViewCell")
        
        self.ordersTableView.delegate = self
        self.ordersTableView.dataSource = self
        
        self.ordersTableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrdersTableViewCell", for: indexPath) as! OrdersTableViewCell
        cell.loadUI(item: orders[indexPath.row])

        let nib = UINib(nibName: "OrdersItemsTableViewCell", bundle: nil)
        cell.itemsTableView.register(nib, forCellReuseIdentifier: "OrdersItemsTableViewCell")
        
        cell.itemsTableView.numberOfRows { (_) -> Int in
            return (self.orders[indexPath.row].orderItems?.count ?? 0)
        }.cellForRow { (index) -> UITableViewCell in
            
            let cell = cell.itemsTableView.dequeueReusableCell(withIdentifier: "OrdersItemsTableViewCell", for: index) as! OrdersItemsTableViewCell
            cell.loadUI(item: (self.orders[indexPath.row].orderItems?[index.row])!)
            return cell
            
        }.heightForRowAt { (_) -> CGFloat in
            return 150
        }
        
        cell.itemsTableView.reloadData()
        
        if orders[indexPath.row].expanded ?? false{
            cell.expandBtn.setImage(UIImage(named: "up-arrow"), for: .normal)
            UIView.animate(withDuration: 0.25) {
                cell.itemsTableView.isHidden = false
                cell.itemsViewHeight.constant = CGFloat((150 * self.orders[indexPath.row].orderItems!.count) + 80)
                cell.itemsTableViewHeight.constant = CGFloat((150 * self.orders[indexPath.row].orderItems!.count))
                self.view.layoutIfNeeded()
            }
        }else{
            cell.expandBtn.setImage(UIImage(named: "down-arrow"), for: .normal)
            UIView.animate(withDuration: 0.25) {
                cell.itemsTableView.isHidden = true
                cell.itemsViewHeight.constant = 70
                cell.itemsTableViewHeight.constant = 0
                self.view.layoutIfNeeded()
            }
        }
        
        cell.itemsView.addTapGesture { (_) in
            self.orders[indexPath.row].expanded = !(self.orders[indexPath.row].expanded ?? false)
            let offset = self.ordersTableView.contentOffset
            self.ordersTableView.reloadData()
            self.ordersTableView.setContentOffset(offset, animated: false)
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if orders[indexPath.row].expanded ?? false{
            return CGFloat((150 * orders[indexPath.row].orderItems!.count) + 280)
        }else{
            return 275
        }
    }
    
}
