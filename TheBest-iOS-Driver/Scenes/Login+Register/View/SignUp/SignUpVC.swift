//
//  SignUpVC.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 10/3/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit
import Closures

class SignUpVC: UIViewController , UIGestureRecognizerDelegate{

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet var customTFs: [UITextField]!
    @IBOutlet var customViews: [UIView]!
    @IBOutlet weak var tf: UITextField!
    @IBOutlet weak var carIcon: UIView!
    @IBOutlet weak var carPic: UIImageView!
    @IBOutlet weak var sendRequest: UIButton!
    @IBOutlet weak var idCardOption1: UIButton!
    @IBOutlet weak var idCardOption2: UIButton!
    @IBOutlet weak var passportOption1: UIButton!
    @IBOutlet weak var driverLicenseOption1: UIButton!
    @IBOutlet weak var carSlinderOption1: UIButton!
    @IBOutlet weak var chooseTaxiBtn: UIButton!
    @IBOutlet var checkIcons: [UIImageView]!
    @IBOutlet weak var chooseCollection: UICollectionView!
    @IBOutlet weak var agreeCheck: UIImageView!
    @IBOutlet weak var payTypeChooseCollection: UICollectionView!
    
    var options = [Option]()
    var payOptions = [Option]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        options.append(Option(id: "", title: "Taxi", selected: false))
        options.append(Option(id: "", title: "Restaurant", selected: false))
        options.append(Option(id: "", title: "Car rent", selected: false))
        options.append(Option(id: "", title: "Markets", selected: false))
        options.append(Option(id: "", title: "Special cars  ", selected: false))
        options.append(Option(id: "", title: "Furniture cars", selected: false))
        
        payOptions.append(Option(id: "", title: "Monthly", selected: false))
        payOptions.append(Option(id: "", title: "Annual", selected: false))
        payOptions.append(Option(id: "", title: "Monthly Annual", selected: false))
        
        loadUI()
        loadActions()
        
        let nib = UINib(nibName: "ChooseCollectionViewCell", bundle: nil)
        chooseCollection.register(nib, forCellWithReuseIdentifier: "ChooseCollectionViewCell")
        payTypeChooseCollection.register(nib, forCellWithReuseIdentifier: "ChooseCollectionViewCell")
        
        chooseCollection.numberOfItemsInSection { (_) -> Int in
            return self.options.count
        }.cellForItemAt { (index) -> UICollectionViewCell in
            
            let cell = self.chooseCollection.dequeueReusableCell(withReuseIdentifier: "ChooseCollectionViewCell", for: index) as! ChooseCollectionViewCell
            cell.loadFrom(option: self.options[index.row])
            return cell
            
        }.didSelectItemAt { (index) in
            
            self.options[index.row].selected = !self.options[index.row].selected!
            self.chooseCollection.reloadData()
            
        }.sizeForItemAt { (index) -> CGSize in
            return CGSize(width: self.chooseCollection.frame.width/2 - 10, height: 35)
        }
        
        payTypeChooseCollection.numberOfItemsInSection { (_) -> Int in
            return self.payOptions.count
        }.cellForItemAt { (index) -> UICollectionViewCell in
            
            let cell = self.payTypeChooseCollection.dequeueReusableCell(withReuseIdentifier: "ChooseCollectionViewCell", for: index) as! ChooseCollectionViewCell
            cell.loadFrom(option: self.payOptions[index.row])
            return cell
            
        }.didSelectItemAt { (index) in
            
            self.payOptions[index.row].selected = !self.payOptions[index.row].selected!
            self.payTypeChooseCollection.reloadData()
            
        }.sizeForItemAt { (index) -> CGSize in
            return CGSize(width: self.payTypeChooseCollection.frame.width/3+10, height: 50)
        }
        
    }
    
    func loadUI(){
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        sendRequest.layer.cornerRadius = 15
        carIcon.layer.cornerRadius = carIcon.frame.height/2
        for tf in customTFs{
            tf.addBottomBorder()
        }
        for v in customViews{
            v.setupShadow()
            v.layer.cornerRadius = 15
        }
        
    }

    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func loadActions(){
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
        
        idCardOption1.onTap {
            let imagePicker = UIImagePickerController.init(source: .photoLibrary, allow: .image, showsCameraControls: true, didCancel: { (controller) in
                controller.dismiss(animated: true, completion: nil)
            }) { (result, controller) in
                controller.dismiss(animated: true, completion: nil)
                self.idCardOption1.setImage(result.originalImage, for: .normal)
            }
            
            self.present(imagePicker, animated: true, completion: nil)
        }
        
        idCardOption2.onTap {
            let imagePicker = UIImagePickerController.init(source: .photoLibrary, allow: .image, showsCameraControls: true, didCancel: { (controller) in
                controller.dismiss(animated: true, completion: nil)
            }) { (result, controller) in
                controller.dismiss(animated: true, completion: nil)
                self.idCardOption2.setImage(result.originalImage, for: .normal)
            }
            
            self.present(imagePicker, animated: true, completion: nil)
        }
        
        passportOption1.onTap {
            let imagePicker = UIImagePickerController.init(source: .photoLibrary, allow: .image, showsCameraControls: true, didCancel: { (controller) in
                controller.dismiss(animated: true, completion: nil)
            }) { (result, controller) in
                controller.dismiss(animated: true, completion: nil)
                self.passportOption1.setImage(result.originalImage, for: .normal)
            }
            
            self.present(imagePicker, animated: true, completion: nil)
        }
        
        driverLicenseOption1.onTap {
            let imagePicker = UIImagePickerController.init(source: .photoLibrary, allow: .image, showsCameraControls: true, didCancel: { (controller) in
                controller.dismiss(animated: true, completion: nil)
            }) { (result, controller) in
                controller.dismiss(animated: true, completion: nil)
                self.driverLicenseOption1.setImage(result.originalImage, for: .normal)
            }
            
            self.present(imagePicker, animated: true, completion: nil)
        }
        
        carSlinderOption1.onTap {
            let imagePicker = UIImagePickerController.init(source: .photoLibrary, allow: .image, showsCameraControls: true, didCancel: { (controller) in
                controller.dismiss(animated: true, completion: nil)
            }) { (result, controller) in
                controller.dismiss(animated: true, completion: nil)
                self.carSlinderOption1.setImage(result.originalImage, for: .normal)
            }
            
            self.present(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func agreeAction(_ sender: UIButton) {
        if sender.tag == 0{
            agreeCheck.image = UIImage(named: "checked")
            sender.tag = 1
        }else{
            agreeCheck.image = UIImage(named: "unchecked")
            sender.tag = 0
        }
    }
    
    
}
