//
//  APIServices.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 10/9/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIServices{
    
    static func getDriversSpecialty(_ completed: @escaping (DriversSpecialty?)->Void){
        Alamofire.request(URL(string: DRIVERS_SPECIALTY_API)!, method: .get, parameters: nil, headers: SharedData.headers).responseData { (response) in
            switch response.result{
            case .success(let data):
                do{
                    
                    let json = JSON(data)
                    
                    if json["status"].stringValue == "200"{
                        let dataModel = try JSONDecoder().decode(DriversSpecialty.self, from: data)
                        completed(dataModel)
                    }else{
                        completed(nil)
                    }
                    
                }catch let error{
                    print(error)
                    completed(nil)
                }
            case .failure(let error):
                print(error)
                completed(nil)
            }
        }
    }
    
    static func updateProfile(body: DriverInfo, completed: @escaping (Bool)->Void){
        
        URLCache.shared.removeAllCachedResponses()
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(body.image.jpegData(compressionQuality: 0.2)!, withName: "image", mimeType: "image/jpg")
            multipartFormData.append(body.imgcert.jpegData(compressionQuality: 0.2)!, withName: "imgcert", mimeType: "imgcert/jpg")
            multipartFormData.append(body.ssidfront.jpegData(compressionQuality: 0.2)!, withName: "ssidfront", mimeType: "ssidfront/jpg")
            multipartFormData.append(body.ssidback.jpegData(compressionQuality: 0.2)!, withName: "ssidback", mimeType: "ssidback/jpg")
            multipartFormData.append(body.passport.jpegData(compressionQuality: 0.2)!, withName: "passport", mimeType: "passport/jpg")
            
            multipartFormData.append(body.name.data(using: String.Encoding.utf8)!, withName: "name")
            multipartFormData.append(body.email.data(using: String.Encoding.utf8)!, withName: "email")
            multipartFormData.append(body.password.data(using: String.Encoding.utf8)!, withName: "password")
            multipartFormData.append(body.fcm_token.data(using: String.Encoding.utf8)!, withName: "fcm_token")
            multipartFormData.append(body.phone.data(using: String.Encoding.utf8)!, withName: "phone")
            multipartFormData.append(body.lat.data(using: String.Encoding.utf8)!, withName: "lat")
            multipartFormData.append(body.lng.data(using: String.Encoding.utf8)!, withName: "lng")
            multipartFormData.append(body.ssid_driver.data(using: String.Encoding.utf8)!, withName: "ssid_driver")
            multipartFormData.append(body.address.data(using: String.Encoding.utf8)!, withName: "address") // from google maps api
            multipartFormData.append(body.phone_intreal.data(using: String.Encoding.utf8)!, withName: "phone_intreal")
            multipartFormData.append(body.country_id.data(using: String.Encoding.utf8)!, withName: "country_id")
            multipartFormData.append(body.car_company_id.data(using: String.Encoding.utf8)!, withName: "car_company_id")
            
        }, to: URL(string: PROFILE_UPDATE_API)!, method: .post, headers: SharedData.headers) { (encodingResult) in
            
            switch encodingResult{
                
            case .success(let uploadRequest,_,_):
                
                uploadRequest.responseData { (response) in
                    
                    switch response.result{
                        
                    case .success(let data):
                        
                        print("user",try? JSON(data: data))
                        
                        if JSON(data)["status"].intValue == 200{
                            
                            do{
                                
                                let dataModel = try JSONDecoder().decode(ProfileResponse.self, from: data)
                                AuthServices.instance.user = dataModel.myProfile
                                print(dataModel)
                                completed(true)
                                
                            }catch let error{
                                print("parsErrr",error)
                                completed(false)
                            }
                            
                        }else{
                            completed(false)
                        }
                        
                    case .failure(let error):
                        
                        print("userParseError",error)
                        completed(false)
                        
                    }
                    
                }
                
            case .failure(let error):
                
                print("error",error)
                completed(false)
                
            }
            
        }
        
    }
    
    static func myOrders(completed: @escaping (MyOrdersRsponse?)->Void){
        
        URLCache.shared.removeAllCachedResponses()
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            
        }, to: URL(string: MY_ORDERS_API)!, method: .post, headers: SharedData.headers) { (encodingResult) in
            
            switch encodingResult{
                
            case .success(let uploadRequest,_,_):
                
                uploadRequest.responseData { (response) in
                    
                    switch response.result{
                        
                    case .success(let data):
                        
                        print("orders",try? JSON(data: data))
                        
                        if JSON(data)["status"].intValue == 200{
                            
                            do{
                                
                                let dataModel = try JSONDecoder().decode(MyOrdersRsponse.self, from: data)
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
                        
                        print("ordersParseError",error)
                        completed(nil)
                        
                    }
                    
                }
                
            case .failure(let error):
                
                print("error",error)
                completed(nil)
                
            }
            
        }
        
    }
    
    static func getDriverReports(_ from: String,_ to: String, completed: @escaping (DriverReports?)->Void){
        
        URLCache.shared.removeAllCachedResponses()
        Alamofire.upload(multipartFormData: { (multipartFormData) in
        
            multipartFormData.append(from.data(using: String.Encoding.utf8)!, withName: "from_date")
            multipartFormData.append(to.data(using: String.Encoding.utf8)!, withName: "to_date")
            
        }, to: URL(string: DRIVER_REPORTS_API)!, method: .post, headers: SharedData.headers) { (encodingResult) in
            
            switch encodingResult{
                
            case .success(let uploadRequest,_,_):
                
                uploadRequest.responseData { (response) in
                    
                    switch response.result{
                        
                    case .success(let data):
                        
                        print("reports",try? JSON(data: data))
                        
                        if JSON(data)["status"].intValue == 200{
                            
                            do{
                                
                                let dataModel = try JSONDecoder().decode(DriverReports.self, from: data)
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
                        
                        print("reportsParseError",error)
                        completed(nil)
                        
                    }
                    
                }
                
            case .failure(let error):
                
                print("error",error)
                completed(nil)
                
            }
            
        }
        
    }
    
    static func getTripBy(_ id: String, _ completed: @escaping (TripByIDResponse?)->Void){
        Alamofire.request(URL(string: GET_TRIP_BY_ID + id)!, method: .get, parameters: nil, headers: SharedData.headers).responseData { (response) in
            switch response.result{
            case .success(let data):
                do{
                    
                    let json = JSON(data)
                    
                    if json["status"].intValue == 200{
                        let dataModel = try JSONDecoder().decode(TripByIDResponse.self, from: data)
                        completed(dataModel)
                    }else{
                        completed(nil)
                    }
                    
                }catch let error{
                    print(error)
                    completed(nil)
                }
            case .failure(let error):
                print(error)
                completed(nil)
            }
        }
    }
    
    static func confirmEndRide(_ id: String, _ driverComment: String,_ status: String, completed: @escaping (Bool)->Void){
        
        URLCache.shared.removeAllCachedResponses()
        Alamofire.upload(multipartFormData: { (multipartFormData) in
        
            multipartFormData.append(driverComment.data(using: String.Encoding.utf8)!, withName: "driver_comment")
            multipartFormData.append(status.data(using: String.Encoding.utf8)!, withName: "status")
            
        }, to: URL(string: CONFIRM_END_RIDE + id)!, method: .post, headers: SharedData.headers) { (encodingResult) in
            
            switch encodingResult{
                
            case .success(let uploadRequest,_,_):
                
                uploadRequest.responseData { (response) in
                    
                    switch response.result{
                        
                    case .success(let data):
                        
                        print("reports",try? JSON(data: data))
                        
                        if JSON(data)["status"].stringValue == "200"{
                            
                            completed(true)
                            
                        }else{
                            completed(false)
                        }
                        
                    case .failure(_):
                        
                        completed(false)
                        
                    }
                    
                }
                
            case .failure(let error):
                
                print("error",error)
                completed(false)
                
            }
            
        }
        
    }
    
    static func confirmRidePrice( _ total: String,_ paymentMethod: String, completed: @escaping (Bool)->Void){
        
        URLCache.shared.removeAllCachedResponses()
        Alamofire.upload(multipartFormData: { (multipartFormData) in
        
            multipartFormData.append(total.data(using: String.Encoding.utf8)!, withName: "total")
            multipartFormData.append(paymentMethod.data(using: String.Encoding.utf8)!, withName: "payment_method")
            
        }, to: URL(string: RIDE_PRICE_API)!, method: .post, headers: SharedData.headers) { (encodingResult) in
            
            switch encodingResult{
                
            case .success(let uploadRequest,_,_):
                
                uploadRequest.responseData { (response) in
                    
                    switch response.result{
                        
                    case .success(let data):
                        
                        print("reports",try? JSON(data: data))
                        
                        if JSON(data)["status"].stringValue == "200"{
                            
                            completed(true)
                            
                        }else{
                            completed(false)
                        }
                        
                    case .failure(_):
                        
                        completed(false)
                        
                    }
                    
                }
                
            case .failure(let error):
                
                print("error",error)
                completed(false)
                
            }
            
        }
        
    }
    
    static func hereDriver(_ id: String, _ completed: @escaping (Bool)->Void){
        Alamofire.request(URL(string: HERE_DRIVER_API + id)!, method: .get, parameters: nil, headers: SharedData.headers).responseData { (response) in
            switch response.result{
            case .success(let data):
                do{
                    
                    let json = JSON(data)
                    
                    if json["status"].stringValue == "200"{
                        completed(true)
                    }else{
                        completed(false)
                    }
                    
                }catch let error{
                    print(error)
                    completed(false)
                }
            case .failure(let error):
                print(error)
                completed(false)
            }
        }
    }
    
}
