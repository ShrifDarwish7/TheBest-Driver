//
//  IncomingOrderTableViewCell.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 10/5/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

class IncomingOrderTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var fromView: UIView!
    @IBOutlet weak var toView: UIView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var vendorView: UIView!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var denyBtn: UIButton!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var addressFrom: UILabel!
    @IBOutlet weak var addressTo: UILabel!
    @IBOutlet weak var total: UILabel!
    
    func loadUI(){
        containerView.setupShadow()
        containerView.layer.cornerRadius = 15
        fromView.layer.cornerRadius = fromView.frame.height/2
        fromView.layer.borderWidth = 1.5
        fromView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        toView.layer.cornerRadius = toView.frame.height/2
        acceptBtn.layer.cornerRadius = 10
        denyBtn.layer.cornerRadius = 10
        statusView.layer.cornerRadius = 15
        vendorView.layer.cornerRadius = 15
        statusLbl.layer.cornerRadius = 10
        topView.layer.cornerRadius = 15
    }
    
    func loadFrom(_ trip: MyTrip){
        loadUI()
        statusLbl.text = trip.status
        addressFrom.text = trip.addressFrom
        addressTo.text = trip.addressTo
        total.text = "\(trip.total)" + " " + "KWD"
    }
    
}
