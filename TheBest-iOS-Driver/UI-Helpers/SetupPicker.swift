//
//  SetupPicker.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/2/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func setupPicker(textField : UITextField , picker : UIPickerView){
        picker.showsSelectionIndicator=true
        picker.reloadAllComponents()
        textField.inputView = picker
        let done = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissPick))
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.setItems([done], animated: true)
        toolbar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolbar
        
        let icon = UIImageView(frame : CGRect(x: 5, y: 5, width: 30, height: 15))
        icon.image = UIImage(named: "drop-down-arrow")
        icon.contentMode = .scaleAspectFit
        icon.widthAnchor.constraint(equalToConstant: 50).isActive = true
        textField.rightViewMode = .always
        textField.rightView = icon
    }
    
    @objc func dismissPick(){
        view.endEditing(true)
    }
}
