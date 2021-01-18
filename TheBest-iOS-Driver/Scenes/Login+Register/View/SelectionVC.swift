//
//  SelectionVC.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/21/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit
import SVProgressHUD

class SelectionVC: UIViewController {

    @IBOutlet weak var chooseSubCategory: UICollectionView!
    @IBOutlet weak var confirmBtn: UIButton!
    
    var receivedId: Int?
    var specialty: [Specialty]?
    var authPresenter: AuthPresenter?
    var selectedIds: [Int] = []
    var selectionData: SelectionData = .specialty
    var selectedCoutriesIds: Int?
    var countries: [Country]?

    override func viewDidLoad() {
        super.viewDidLoad()
        authPresenter = AuthPresenter(authViewDelegate: self)
        
        confirmBtn.layer.cornerRadius = 10
        confirmBtn.setTitle("Confirm Selection".localized, for: .normal)
        
        switch selectionData {
        case .specialty:
            authPresenter?.getSpecialty()
        default:
            confirmBtn.isEnabled = false
            authPresenter?.getCountries()
        }
        
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func confirmAction(_ sender: Any) {
        switch selectionData {
        case .specialty:
            authPresenter?.addSpecialty(selectedIds)
        default:
            if let _ = self.selectedCoutriesIds{
                self.navigationController?.popViewController(animated: true)
                let previousVC = self.navigationController?.viewControllers.last as! SignUpVC
                previousVC.selectedCountryId = self.selectedCoutriesIds
            }
        }
        
        //        for controller in self.navigationController!.viewControllers as Array {
        //            if controller.isKind(of: SignUpVC.self) {
        //                self.navigationController!.popToViewController(controller, animated: true)
        //                break
        //            }
        //        }
    }
    
    
}

extension SelectionVC: AuthViewDelegate{
    
    func SVProgressStatus(_ show: Bool) {
        if show{
            SVProgressHUD.show()
        }else{
            SVProgressHUD.dismiss()
        }
    }
    
    func didCompleteWithCountries(_ result: [Country]?) {
        if let _ = result{
            self.countries = result
            self.loadCollectionFromNib()
        }
    }
    
    func didCompleteWithSpecialty(_ specialty: [Specialty]?) {
        if let _ = specialty{
            if !specialty!.isEmpty{
                self.specialty = specialty
                self.loadCollectionFromNib()
            }
        }
    }
    
    func didCompleteAddSpecialty(_ completed: Bool) {
        if completed{
            self.showAlert(title: "", message: "Your specialties updated successfully")
        }else{
             self.showAlert(title: "", message: "Error when updating your specialties")
        }
    }
}

extension SelectionVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func loadCollectionFromNib(){
        let nib = UINib(nibName: "ChooseCollectionViewCell", bundle: nil)
        chooseSubCategory.register(nib, forCellWithReuseIdentifier: "ChooseCollectionViewCell")
        chooseSubCategory.delegate = self
        chooseSubCategory.dataSource = self
        chooseSubCategory.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch selectionData {
        case .specialty:
            return self.specialty!.count
        default:
            return self.countries!.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.chooseSubCategory.dequeueReusableCell(withReuseIdentifier: "ChooseCollectionViewCell", for: indexPath) as! ChooseCollectionViewCell
        switch selectionData {
        case .specialty:
            cell.loadFrom(specialty: self.specialty![indexPath.row])
        default:
            cell.loadFrom(country: self.countries![indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch selectionData {
        case .specialty:
            
            if self.specialty![indexPath.row].selected ?? false{
                
                if !selectedIds.isEmpty{
                    if let index = selectedIds.firstIndex(of: self.specialty![indexPath.row].id){
                        selectedIds.remove(at: index)
                    }
                }
                
            }else{
                selectedIds.append(self.specialty![indexPath.row].id)
            }
            
            self.specialty![indexPath.row].selected = !(self.specialty![indexPath.row].selected ?? false)
            self.chooseSubCategory.reloadData()
            if selectedIds.isEmpty{
                confirmBtn.isEnabled = false
            }else{
                confirmBtn.isEnabled = true
            }
            
        default:
            
            confirmBtn.isEnabled = true
            self.countries?.forEach({ (country) in
                country.selected = false
            })
            self.countries![indexPath.row].selected = true
            self.selectedCoutriesIds = self.countries![indexPath.row].id
            self.chooseSubCategory.reloadData()
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.chooseSubCategory.frame.width, height: 50)
    }
}


enum SelectionData{
    case specialty
    case countries
}
