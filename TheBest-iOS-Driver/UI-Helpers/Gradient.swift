
import Foundation
import UIKit

extension UIView{
    
    func setGradientBackground(color top: UIColor, color Bottom: UIColor) {

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [top.cgColor, Bottom.cgColor]
        gradientLayer.locations = [0.5, 1.0]
        gradientLayer.frame = self.bounds

        self.layer.insertSublayer(gradientLayer, at:0)
    }
    
}
