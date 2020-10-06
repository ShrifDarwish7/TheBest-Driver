//
//  HomeVC+TableViewDelegate.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 10/5/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import UIKit

extension HomeVC: UITableViewDelegate, UITableViewDataSource{
    
    func loadTableFromNib(){
        
        let nib = UINib(nibName: "IncomingOrderTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "IncomingOrderTableViewCell")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "IncomingOrderTableViewCell", for: indexPath) as! IncomingOrderTableViewCell
        cell.loadUI()
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
}
