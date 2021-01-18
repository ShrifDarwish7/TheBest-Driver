//
//  ChooseCollectionViewCell.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 10/4/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

class ChooseCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var check: UIImageView!
    
    func loadFrom(specialty: Specialty){
        title.text = specialty.name
        check.image = specialty.selected == true ? UIImage(named: "checked") : UIImage(named: "unchecked")
    }
    
    func loadFrom(country: Country){
        title.text = country.name
        check.image = country.selected == true ? UIImage(named: "checked") : UIImage(named: "unchecked")
    }
    
}
