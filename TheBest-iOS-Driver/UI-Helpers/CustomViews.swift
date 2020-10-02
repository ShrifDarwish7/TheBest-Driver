
import Foundation
import UIKit

extension UIView {
    func setupShadow(){
        //self.layer.cornerRadius = 10
        //self.backgroundColor = UIColor.white
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 3
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.masksToBounds = false
    }
      
    func roundCorners(_ corners: CACornerMask, radius: CGFloat) {
        
        self.layer.maskedCorners = corners
        self.layer.cornerRadius = radius

    }

    
}
