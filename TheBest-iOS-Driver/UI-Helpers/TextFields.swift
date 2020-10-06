//
//  TextFields.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 10/3/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import UIKit

extension UITextField{
    
    func addBottomBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.height - 1, width: self.frame.width-35, height: 1.5)
        bottomLine.backgroundColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 0.2)
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
    }
    
}
