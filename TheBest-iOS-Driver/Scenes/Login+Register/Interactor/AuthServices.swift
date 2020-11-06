//
//  AuthServices.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 10/8/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthServices{
    
    static let instance = AuthServices()
    let defaults = UserDefaults.standard
    var isLogged: Bool{
        set{
            self.defaults.set(newValue, forKey: "isLogged")
        }
        get{
            return self.defaults.bool(forKey: "isLogged")
        }
    }
    var profile: MyProfile{
        get{
            return try! JSONDecoder().decode(MyProfile.self, from: defaults.object(forKey: "user") as? Data ?? Data())
        }
        set{
            let userEncoded = try! JSONEncoder().encode(newValue)
            self.defaults.set(userEncoded, forKey: "user")
        }
    }
    
    static func loginWith(_ email: String, _ password: String, _ fcmToken: String, completed: @escaping (Bool)->Void, banned: @escaping (String?)->Void){
        URLCache.shared.removeAllCachedResponses()
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(email.data(using: String.Encoding.utf8)!, withName: "email")
            multipartFormData.append(password.data(using: String.Encoding.utf8)!, withName: "password")
            multipartFormData.append(fcmToken.data(using: String.Encoding.utf8)!, withName: "fcm_token")
            
        }, to: URL(string: LOGIN_API)!, method: .post, headers: HEADERS) { (encodingResult) in
            
            switch encodingResult{
                
            case .success(let uploadRequest,_,_):
                
                uploadRequest.responseData { (response) in
                    
                    switch response.result{
                        
                    case .success(let data):
                        
                        print("user",try? JSON(data: data))
                        
                        if JSON(data)["message"].stringValue == "Sorry, your account has been banned. Please contact your account manager"{
                            banned("Sorry, your account has been banned. Please contact your account manager")
                        }else{
                            do{
                                
                                let dataModel = try JSONDecoder().decode(LoginResponse.self, from: data)
                                self.instance.profile = dataModel.myProfile
                                UserDefaults.init().set(JSON(data)["accessToken"].stringValue, forKey: "accessToken")
                                print(dataModel)
                                self.instance.isLogged = true
                                completed(true)
                                
                            }catch let error{
                                print("parsErrr",error)
                                self.instance.isLogged = false
                                completed(false)
                            }
                        }
                        
                    case .failure(let error):
                        
                        print("userParseError",error)
                        completed(false)
                        
                    }
                    
                }
                
            case .failure(let error):
                
                print("error",error)
                self.instance.isLogged = false
                completed(false)
                
            }
            
        }
        
    }
    
    static func registerWith(driverInfo: DriverInfo, completed: @escaping (Bool)->Void){
        
        URLCache.shared.removeAllCachedResponses()
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(driverInfo.image!.jpegData(compressionQuality: 0.2)!, withName: "image", mimeType: "image/jpg")
            multipartFormData.append(driverInfo.imgcert!.jpegData(compressionQuality: 0.2)!, withName: "imgcert", mimeType: "imgcert/jpg")
            multipartFormData.append(driverInfo.ssidfront!.jpegData(compressionQuality: 0.2)!, withName: "ssidfront", mimeType: "ssidfront/jpg")
            multipartFormData.append(driverInfo.ssidback!.jpegData(compressionQuality: 0.2)!, withName: "ssidback", mimeType: "ssidback/jpg")
            multipartFormData.append(driverInfo.passport!.jpegData(compressionQuality: 0.2)!, withName: "passport", mimeType: "passport/jpg")
            
            multipartFormData.append(driverInfo.name!.data(using: String.Encoding.utf8)!, withName: "name")
            multipartFormData.append(driverInfo.email!.data(using: String.Encoding.utf8)!, withName: "email")
            multipartFormData.append(driverInfo.password!.data(using: String.Encoding.utf8)!, withName: "password")
            multipartFormData.append(driverInfo.fcm_token!.data(using: String.Encoding.utf8)!, withName: "fcm_token")
            multipartFormData.append(driverInfo.phone!.data(using: String.Encoding.utf8)!, withName: "phone")
            multipartFormData.append(driverInfo.lat.data(using: String.Encoding.utf8)!, withName: "lat")
            multipartFormData.append(driverInfo.lng.data(using: String.Encoding.utf8)!, withName: "lng")
            multipartFormData.append(driverInfo.ssid_driver!.data(using: String.Encoding.utf8)!, withName: "ssid_driver")
            multipartFormData.append(driverInfo.address!.data(using: String.Encoding.utf8)!, withName: "address")
            multipartFormData.append(driverInfo.phone_intreal!.data(using: String.Encoding.utf8)!, withName: "phone_intreal")
            multipartFormData.append(driverInfo.country_id!.data(using: String.Encoding.utf8)!, withName: "country_id")
            multipartFormData.append(driverInfo.car_company_id!.data(using: String.Encoding.utf8)!, withName: "car_company_id")
            
        }, to: URL(string: REGISTER_API)!, method: .post, headers: HEADERS) { (encodingResult) in
            
            switch encodingResult{
                
            case .success(let uploadRequest,_,_):
                
                uploadRequest.responseData { (response) in
                    
                    switch response.result{
                        
                    case .success(let data):
                        
                        print("user",try? JSON(data: data))
                        
                        do{
                            
                            let dataModel = try JSONDecoder().decode(RegisterResponse.self, from: data)
                            self.instance.profile = dataModel.user
                            UserDefaults.init().set(JSON(data)["accessToken"].stringValue, forKey: "accessToken")
                            print(dataModel)
                            self.instance.isLogged = true
                            completed(true)
                            
                        }catch let error{
                            print("parsErrr",error)
                            self.instance.isLogged = false
                            completed(false)
                        }
                        
                    case .failure(let error):
                        
                        print("userParseError",error)
                        completed(false)
                        
                    }
                    
                }
                
            case .failure(let error):
                
                print("error",error)
                self.instance.isLogged = false
                completed(false)
                
            }
            
        }
        
    }
    
    static func updateProfile(body: DriverInfo, completed: @escaping (ProfileResponse?)->Void){
        
        URLCache.shared.removeAllCachedResponses()
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            if let _ = body.image{
                multipartFormData.append(body.image!.jpegData(compressionQuality: 0.2)!, withName: "image", mimeType: "image/jpg")
            }
            if let _ = body.imgcert{
                multipartFormData.append(body.imgcert!.jpegData(compressionQuality: 0.2)!, withName: "imgcert", mimeType: "imgcert/jpg")
            }
            if let _ = body.ssidfront{
                multipartFormData.append(body.ssidfront!.jpegData(compressionQuality: 0.2)!, withName: "ssidfront", mimeType: "ssidfront/jpg")
            }
            if let _ = body.ssidback{
                multipartFormData.append(body.ssidback!.jpegData(compressionQuality: 0.2)!, withName: "ssidback", mimeType: "ssidback/jpg")
            }
            if let _ = body.passport{
                multipartFormData.append(body.passport!.jpegData(compressionQuality: 0.2)!, withName: "passport", mimeType: "passport/jpg")
            }
            
            multipartFormData.append(body.name!.data(using: String.Encoding.utf8)!, withName: "name")
            multipartFormData.append(body.email!.data(using: String.Encoding.utf8)!, withName: "email")
            multipartFormData.append(body.password!.data(using: String.Encoding.utf8)!, withName: "password")
            multipartFormData.append(body.fcm_token!.data(using: String.Encoding.utf8)!, withName: "fcm_token")
            multipartFormData.append(body.phone!.data(using: String.Encoding.utf8)!, withName: "phone")
            multipartFormData.append(body.lat.data(using: String.Encoding.utf8)!, withName: "lat")
            multipartFormData.append(body.lng.data(using: String.Encoding.utf8)!, withName: "lng")
            multipartFormData.append(body.ssid_driver!.data(using: String.Encoding.utf8)!, withName: "ssid_driver")
            multipartFormData.append(body.address!.data(using: String.Encoding.utf8)!, withName: "address")
            multipartFormData.append(body.phone_intreal!.data(using: String.Encoding.utf8)!, withName: "phone_intreal")
            multipartFormData.append(body.country_id!.data(using: String.Encoding.utf8)!, withName: "country_id")
            multipartFormData.append(body.car_company_id!.data(using: String.Encoding.utf8)!, withName: "car_company_id")
            
        }, to: URL(string: PROFILE_UPDATE_API)!, method: .post, headers: SharedData.headers) { (encodingResult) in
            
            switch encodingResult{
                
            case .success(let uploadRequest,_,_):
                
                uploadRequest.responseData { (response) in
                    
                    switch response.result{
                        
                    case .success(let data):
                        
                        print("user",try? JSON(data: data))
                        
                        if JSON(data)["status"].stringValue == "200"{
                            
                            do{
                                
                                let dataModel = try JSONDecoder().decode(ProfileResponse.self, from: data)
                                AuthServices.instance.profile = dataModel.myProfile
                                print(dataModel)
                                completed(dataModel)
                                
                            }catch let error{
                                print("parsErrr",error)
                                completed(nil)
                            }
                            
                        }else{
                            completed(nil)
                        }
                        
                    case .failure(let error):
                        
                        print("userParseError",error)
                        completed(nil)
                        
                    }
                    
                }
                
            case .failure(let error):
                
                print("error",error)
                completed(nil)
                
            }
            
        }
        
    }
    
}
