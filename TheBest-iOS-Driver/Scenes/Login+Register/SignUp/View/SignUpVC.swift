//
//  SignUpVC.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 10/3/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit
import Closures

class SignUpVC: UIViewController {

    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet var customTFs: [UITextField]!
    @IBOutlet weak var tf: UITextField!
    @IBOutlet weak var carIcon: UIView!
    @IBOutlet weak var carPic: UIImageView!
    @IBOutlet weak var carInfoView: UIView!
    @IBOutlet weak var sendRequest: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
        
        profileImage.addTapGesture { (_) in
            
            let imagePicker = UIImagePickerController.init(source: .photoLibrary, allow: .image, showsCameraControls: true, didCancel: { (controller) in
                controller.dismiss(animated: true, completion: nil)
            }) { (result, controller) in
                controller.dismiss(animated: true, completion: nil)
                self.profileImage.image = result.originalImage
            }
            
            self.present(imagePicker, animated: true, completion: nil)
            
        }
        
        carPic.addTapGesture { (_) in
            
            let imagePicker = UIImagePickerController.init(source: .photoLibrary, allow: .image, showsCameraControls: true, didCancel: { (controller) in
                controller.dismiss(animated: true, completion: nil)
            }) { (result, controller) in
                controller.dismiss(animated: true, completion: nil)
                self.carPic.image = result.originalImage
            }
            
            self.present(imagePicker, animated: true, completion: nil)
            
        }
        
    }
    
    func loadUI(){
        infoView.setupShadow()
        infoView.layer.cornerRadius = 15
        carInfoView.setupShadow()
        carInfoView.layer.cornerRadius = 15
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        sendRequest.layer.cornerRadius = 15
        carIcon.layer.cornerRadius = carIcon.frame.height/2
        for tf in customTFs{
            tf.addBottomBorder()
        }
        
    }

    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
