//
//  ReportsVC.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/22/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

class ReportsVC: UIViewController, UITextFieldDelegate {

    @IBOutlet var customTF: [UITextField]!
    @IBOutlet weak var fromTF: UITextField!
    @IBOutlet weak var toTF: UITextField!
    @IBOutlet weak var ordersTableView: UITableView!
    @IBOutlet weak var empty: UILabel!
    @IBOutlet var customView: [UIView]!
    @IBOutlet weak var totalOrders: UILabel!
    @IBOutlet weak var totalMoney: UILabel!
    @IBOutlet weak var completed: UILabel!
    @IBOutlet weak var canceled: UILabel!
    @IBOutlet var getReportsBtn: [UIButton]!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var blockView: UIView!
    @IBOutlet weak var filterViewBottomCnst: NSLayoutConstraint!
    
    var mainPresenter: MainPresenter?
    var selectedFromDate: Date?
    var selectedToDate: Date?
    var myTrips: [MyTrip]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
        mainPresenter = MainPresenter(self)
    }
    
    func loadUI(){
        for tf in customTF{
            tf.addBottomBorder()
        }
        
        for v in customView{
            v.layer.cornerRadius = 10
        }
        
        for btn in getReportsBtn{
            btn.layer.cornerRadius = 10
        }
        filterView.setupShadow()
        filterView.roundCorners([.layerMinXMinYCorner,.layerMaxXMinYCorner], radius: 30)
        filterViewBottomCnst.constant = 230
        blockView.addTapGesture { (_) in
            self.dismissFilterView()
        }
        fromTF.setInputViewDatePicker { (datePicker) in
            datePicker.onChange { (date) in
                let dateformatter = DateFormatter()
                dateformatter.dateStyle = .medium
                let date = dateformatter.string(from: datePicker.date)
                self.fromTF.text = date
                self.selectedFromDate = datePicker.date
            }
        }
        
        toTF.setInputViewDatePicker { (datePicker) in
            datePicker.onChange { (date) in
                let dateformatter = DateFormatter()
                dateformatter.dateStyle = .medium
                let date = dateformatter.string(from: datePicker.date)
                self.toTF.text = date
                self.selectedToDate = datePicker.date
            }
        }
        
    }
    
    @IBAction func back(sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func getReports(_ sender: Any) {
        if let _ = selectedFromDate , let _ = selectedToDate{
            mainPresenter?.getReports(from: selectedFromDate!, to: selectedToDate!)
        }
    }
    
    @IBAction func viewFilteringOptions(_ sender: Any) {
        showFilterView()
    }
    
    
    @IBAction func filterByLastMonth(_ sender: Any) {
        dismissFilterView()
        let monthAgo = Calendar.current.date(byAdding: .month, value: -1, to: Date())
        if let _ = monthAgo{
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            fromTF.text = dateFormatter.string(from: monthAgo!)
            toTF.text = dateFormatter.string(from: Date())
            mainPresenter?.getReports(from: monthAgo!, to: Date())
        }
    }
    
    @IBAction func filterByLastWeek(_ sender: Any) {
        dismissFilterView()
        let weekAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date())
        if let _ = weekAgo{
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            fromTF.text = dateFormatter.string(from: weekAgo!)
            toTF.text = dateFormatter.string(from: Date())
            mainPresenter?.getReports(from: weekAgo!, to: Date())
        }
    }
    
    func showFilterView(){
        blockView.isHidden = false
        filterViewBottomCnst.constant = 0
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    func dismissFilterView(){
        filterViewBottomCnst.constant = 230
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        }) { (_) in
            self.blockView.isHidden = true
        }
    }
    
}
