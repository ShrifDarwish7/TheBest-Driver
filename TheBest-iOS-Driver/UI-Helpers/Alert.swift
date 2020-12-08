

import Foundation
import UIKit
import Toast_Swift

extension UIViewController {
    func showAlert(title : String , message : String){
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let alertAction = UIAlertAction(title: "Done", style: .default, handler: nil)
//        alert.addAction(alertAction)
//        present(alert, animated: true, completion: nil)
        self.view.makeToast(message, duration: 2, position: .bottom)
    }
    
}
