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
    
    func loadFrom(option: Option){
        title.text = option.title
        check.image = option.selected == true ? UIImage(named: "checked") : UIImage(named: "unchecked")
    }
    
}
