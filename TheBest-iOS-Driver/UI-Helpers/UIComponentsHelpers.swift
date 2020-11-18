//
//  UIComponentsHelpers.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 11/15/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

@IBDesignable
class LocalizedBtn: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.reload()
    }
    
    private func reload() {
        if "lang".localized == "ar" {
            self.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
    }
}

@IBDesignable
class LocalizedImg: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.reload()
    }
    
    private func reload() {
        if "lang".localized == "ar" {
            self.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
    }
}
