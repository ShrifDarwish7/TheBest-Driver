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
    @IBOutlet var customTFs: [UITextField]!
    @IBOutlet var customViews: [UIView]!
    @IBOutlet weak var sendRequest: UIButton!
    @IBOutlet weak var ssidFront: UIButton!
    @IBOutlet weak var ssidBack: UIButton!
    @IBOutlet weak var passportOption1: UIButton!
    @IBOutlet weak var imageCert: UIButton!
    @IBOutlet weak var chooseCollection: UICollectionView!
    @IBOutlet weak var agreeCheck: UIImageView!
    @IBOutlet weak var payTypeChooseCollection: UICollectionView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var phoneTf: UITextField!
    @IBOutlet weak var phoneIntrakTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var ssidDriverTF: UITextField!
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var specLbl: UILabel!
    @IBOutlet weak var cntsLbl: UILabel!
    
    var options = [Option]()
    var payOptions = [Option]()
    var selectedSSIDFront: UIImage?
    var selectedSSIDBack: UIImage?
    var selectedPassport: UIImage?
    var selectedImageCert: UIImage?
    var selectedProfileImage: UIImage?
    var authPresenter: AuthPresenter?
    var viewState: ViewState = .Register
    var selectedCountryId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        specLbl.text = "Specialty".localized
        cntsLbl.text = "Countries".localized
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        authPresenter = AuthPresenter(authViewDelegate: self)
        
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
//        
//        let nib = UINib(nibName: "ChooseCollectionViewCell", bundle: nil)
//        chooseCollection.register(nib, forCellWithReuseIdentifier: "ChooseCollectionViewCell")
//        payTypeChooseCollection.register(nib, forCellWithReuseIdentifier: "ChooseCollectionViewCell")
//        
//        chooseCollection.numberOfItemsInSection { (_) -> Int in
//            return self.options.count
//        }.cellForItemAt { (index) -> UICollectionViewCell in
//            
//            let cell = self.chooseCollection.dequeueReusableCell(withReuseIdentifier: "ChooseCollectionViewCell", for: index) as! ChooseCollectionViewCell
//            cell.loadFrom(option: self.options[index.row])
//            return cell
//            
//        }.didSelectItemAt { (index) in
//            
//            self.options[index.row].selected = !self.options[index.row].selected!
//            self.chooseCollection.reloadData()
//            
//        }.sizeForItemAt { (index) -> CGSize in
//            return CGSize(width: self.chooseCollection.frame.width/2 - 10, height: 35)
//        }
//        
//        payTypeChooseCollection.numberOfItemsInSection { (_) -> Int in
//            return self.payOptions.count
//        }.cellForItemAt { (index) -> UICollectionViewCell in
//            
//            let cell = self.payTypeChooseCollection.dequeueReusableCell(withReuseIdentifier: "ChooseCollectionViewCell", for: index) as! ChooseCollectionViewCell
//            cell.loadFrom(option: self.payOptions[index.row])
//            return cell
//            
//        }.didSelectItemAt { (index) in
//            
//            self.payOptions[index.row].selected = !self.payOptions[index.row].selected!
//            self.payTypeChooseCollection.reloadData()
//            
//        }.sizeForItemAt { (index) -> CGSize in
//            return CGSize(width: self.payTypeChooseCollection.frame.width/3+10, height: 50)
//        }
        
        switch viewState {
        case .Update:
            
            pageTitle.text = "My Profile".localized
            sendRequest.setTitle("Update Profile".localized, for: .normal)
            passTF.isHidden = true
            nameTF.text = AuthServices.instance.profile.name
            emailTF.text = AuthServices.instance.profile.email
            addressTF.text = AuthServices.instance.profile.address
            phoneTf.text = AuthServices.instance.profile.phone
            ssidDriverTF.text = AuthServices.instance.profile.ssidDriver
            phoneIntrakTF.text = AuthServices.instance.profile.phoneIntreal
            profileImage.sd_setImage(with: URL(string: AuthServices.instance.profile.hasImage ?? ""))
            ssidFront.sd_setImage(with: URL(string: AuthServices.instance.profile.ssidfront ?? ""), for: .normal)
            ssidBack.sd_setImage(with: URL(string: AuthServices.instance.profile.ssidback ?? ""), for: .normal)
            passportOption1.sd_setImage(with: URL(string: AuthServices.instance.profile.passport ?? ""), for: .normal)
            imageCert.sd_setImage(with: URL(string: AuthServices.instance.profile.imgcert ?? ""), for: .normal)
            
        default:
            break
        }
        
    }
    
    func loadUI(){
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        sendRequest.layer.cornerRadius = 15
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
                self.selectedProfileImage = result.originalImage
            }
            
            self.present(imagePicker, animated: true, completion: nil)
            
        }
        
        ssidFront.onTap {
            let imagePicker = UIImagePickerController.init(source: .photoLibrary, allow: .image, showsCameraControls: true, didCancel: { (controller) in
                controller.dismiss(animated: true, completion: nil)
            }) { (result, controller) in
                controller.dismiss(animated: true, completion: nil)
                self.ssidFront.setImage(result.originalImage, for: .normal)
                self.selectedSSIDFront = result.originalImage
            }

            self.present(imagePicker, animated: true, completion: nil)
        }
        
        ssidBack.onTap {
            let imagePicker = UIImagePickerController.init(source: .photoLibrary, allow: .image, showsCameraControls: true, didCancel: { (controller) in
                controller.dismiss(animated: true, completion: nil)
            }) { (result, controller) in
                controller.dismiss(animated: true, completion: nil)
                self.ssidBack.setImage(result.originalImage, for: .normal)
                self.selectedSSIDBack = result.originalImage
            }
            
            self.present(imagePicker, animated: true, completion: nil)
        }
        
        passportOption1.onTap {
            let imagePicker = UIImagePickerController.init(source: .photoLibrary, allow: .image, showsCameraControls: true, didCancel: { (controller) in
                controller.dismiss(animated: true, completion: nil)
            }) { (result, controller) in
                controller.dismiss(animated: true, completion: nil)
                self.passportOption1.setImage(result.originalImage, for: .normal)
                self.selectedPassport = result.originalImage
            }
            
            self.present(imagePicker, animated: true, completion: nil)
        }
        
        imageCert.onTap {
            let imagePicker = UIImagePickerController.init(source: .photoLibrary, allow: .image, showsCameraControls: true, didCancel: { (controller) in
                controller.dismiss(animated: true, completion: nil)
            }) { (result, controller) in
                controller.dismiss(animated: true, completion: nil)
                self.imageCert.setImage(result.originalImage, for: .normal)
                self.selectedImageCert = result.originalImage
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
    
    @IBAction func sendRequestAction(_ sender: Any) {
        
        let driverInfo = DriverInfo(
            name: nameTF.text!,
            email: emailTF.text!,
            password: passTF.text!,
            phone: phoneTf.text!,
            image: selectedProfileImage,
            fcm_token: UserDefaults.init().string(forKey: "FCM_Token") ?? "",
            lat: "\(SharedData.userLat ?? 0.0)", lng: "\(SharedData.userLng ?? 0.0)",
            nationality: "",
            imgcert: selectedImageCert,
            ssid_driver: ssidDriverTF.text!,
            ssidfront: selectedSSIDFront, ssidback: selectedSSIDBack,
            address: addressTF.text!,
            passport: selectedPassport,
            phone_intreal: phoneIntrakTF.text!, country_id: "\(self.selectedCountryId ?? 0)", car_company_id: "")

        switch viewState {
        case .Register:
            guard !nameTF.text!.isEmpty, !addressTF.text!.isEmpty, !ssidDriverTF.text!.isEmpty, !emailTF.text!.isEmpty, !passTF.text!.isEmpty, !phoneTf.text!.isEmpty, !phoneIntrakTF.text!.isEmpty else {
                showAlert(title: "", message: "Please fill all required fields")
                return
            }
            guard let _ = selectedProfileImage, let _ = selectedImageCert, let _ = selectedSSIDFront, let _ = selectedSSIDBack, let _ = selectedPassport else {
                showAlert(title: "", message: "Please upload all required images")
                return
            }
            authPresenter?.registerWith(info: driverInfo)
            
        case .Update:
            authPresenter?.updateProfile(info: driverInfo)
        }
        
    }
    
    @IBAction func goToSelection(_ sender: Any){
        Router.toSelection(self)
    }
    
    @IBAction func goToCountriesSelection(_ sender: Any){
        Router.toCountriesSelection(self)
    }
    
}

enum ViewState{
    case Register
    case Update
}
