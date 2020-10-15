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
    var user: User{
        get{
            return try! JSONDecoder().decode(User.self, from: defaults.object(forKey: "user") as? Data ?? Data())
        }
        set{
            let userEncoded = try! JSONEncoder().encode(newValue)
            self.defaults.set(userEncoded, forKey: "user")
        }
    }
    
    static func loginWith(_ email: String, _ password: String, _ fcmToken: String, completed: @escaping (Bool)->Void){
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
                        
                        do{
                            
                            let dataModel = try JSONDecoder().decode(LoginResponse.self, from: data)
                            self.instance.user = dataModel.user
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
    
    static func registerWith(driverInfo: DriverInfo, completed: @escaping (Bool)->Void){
        
        URLCache.shared.removeAllCachedResponses()
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(driverInfo.image.jpegData(compressionQuality: 0.2)!, withName: "image", mimeType: "image/jpg")
            multipartFormData.append(driverInfo.imgcert.jpegData(compressionQuality: 0.2)!, withName: "imgcert", mimeType: "imgcert/jpg")
            multipartFormData.append(driverInfo.ssidfront.jpegData(compressionQuality: 0.2)!, withName: "ssidfront", mimeType: "ssidfront/jpg")
            multipartFormData.append(driverInfo.ssidback.jpegData(compressionQuality: 0.2)!, withName: "ssidback", mimeType: "ssidback/jpg")
            multipartFormData.append(driverInfo.passport.jpegData(compressionQuality: 0.2)!, withName: "passport", mimeType: "passport/jpg")
            
            multipartFormData.append(driverInfo.name.data(using: String.Encoding.utf8)!, withName: "name")
            multipartFormData.append(driverInfo.email.data(using: String.Encoding.utf8)!, withName: "email")
            multipartFormData.append(driverInfo.password.data(using: String.Encoding.utf8)!, withName: "password")
            multipartFormData.append(driverInfo.fcm_token.data(using: String.Encoding.utf8)!, withName: "fcm_token")
            multipartFormData.append(driverInfo.phone.data(using: String.Encoding.utf8)!, withName: "phone")
            multipartFormData.append(driverInfo.lat.data(using: String.Encoding.utf8)!, withName: "lat")
            multipartFormData.append(driverInfo.lng.data(using: String.Encoding.utf8)!, withName: "lng")
            multipartFormData.append(driverInfo.ssid_driver.data(using: String.Encoding.utf8)!, withName: "ssid_driver")
            multipartFormData.append(driverInfo.address.data(using: String.Encoding.utf8)!, withName: "address") // from google maps api
            multipartFormData.append(driverInfo.phone_intreal.data(using: String.Encoding.utf8)!, withName: "phone_intreal")
            multipartFormData.append(driverInfo.country_id.data(using: String.Encoding.utf8)!, withName: "country_id")
            multipartFormData.append(driverInfo.car_company_id.data(using: String.Encoding.utf8)!, withName: "car_company_id")
            
        }, to: URL(string: LOGIN_API)!, method: .post, headers: HEADERS) { (encodingResult) in
            
            switch encodingResult{
                
            case .success(let uploadRequest,_,_):
                
                uploadRequest.responseData { (response) in
                    
                    switch response.result{
                        
                    case .success(let data):
                        
                        print("user",try? JSON(data: data))
                        
                        do{
                            
                            let dataModel = try JSONDecoder().decode(LoginResponse.self, from: data)
                            self.instance.user = dataModel.user
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
    
    
}
