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
import GoogleMaps

class APIServices{
    
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
    
    //    static func getDriverReports(_ from: String,_ to: String, completed: @escaping (DriverReports?)->Void){
    //
    //        URLCache.shared.removeAllCachedResponses()
    //        Alamofire.upload(multipartFormData: { (multipartFormData) in
    //
    //            multipartFormData.append(from.data(using: String.Encoding.utf8)!, withName: "from_date")
    //            multipartFormData.append(to.data(using: String.Encoding.utf8)!, withName: "to_date")
    //
    //        }, to: URL(string: DRIVER_REPORTS_API)!, method: .post, headers: SharedData.headers) { (encodingResult) in
    //
    //            switch encodingResult{
    //
    //            case .success(let uploadRequest,_,_):
    //
    //                uploadRequest.responseData { (response) in
    //
    //                    switch response.result{
    //
    //                    case .success(let data):
    //
    //                        print("reports",try? JSON(data: data))
    //
    //                        if JSON(data)["status"].intValue == 200{
    //
    //                            do{
    //
    //                                let dataModel = try JSONDecoder().decode(DriverReports.self, from: data)
    //                                print(dataModel)
    //                                completed(dataModel)
    //
    //                            }catch let error{
    //                                print("parsErrr",error)
    //                                completed(nil)
    //                            }
    //
    //                        }else{
    //                            completed(nil)
    //                        }
    //
    //                    case .failure(let error):
    //
    //                        print("reportsParseError",error)
    //                        completed(nil)
    //
    //                    }
    //
    //                }
    //
    //            case .failure(let error):
    //
    //                print("error",error)
    //                completed(nil)
    //
    //            }
    //
    //        }
    //
    //    }
    
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
    
    static func getDriverReports(_ from: String,_ to: String, completed: @escaping (ReportsResponse?)->Void){
        
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
                                
                                let dataModel = try JSONDecoder().decode(ReportsResponse.self, from: data)
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
    
    static func getAddressFromGoogleMapsAPI(location : String , completed: @escaping ( _ address: String? )->Void) {
        
        Alamofire.request("https://maps.google.com/maps/api/geocode/json?language=ar&latlng=\(location)&key=\(SharedData.goolgeApiKey)", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .responseData { response in
                switch response.result {
                    
                case .success(let data):
                    let json = JSON(data)
                    //print(json)
                    if json["results"].arrayValue.count > 1 {
                        let results = json["results"].arrayValue[0]
                        print("formatted_address",results["formatted_address"].stringValue)
                        completed(results["formatted_address"].stringValue)
                    }else{
                        completed(nil)
                    }
                    
                case .failure(let error):
                    print(error)
                    completed(nil)
                }
        }
    }
    
    static func getDirectionFromGoogleMapsAPI(origin: String, destination: String, completed: @escaping ( _ polyline: GMSPolyline? )->Void) {
        Alamofire.request("https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving&key=\(SharedData.goolgeApiKey)", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .responseData { response in
                switch response.result {
                    
                case .success(let data):
                    
                    do{
                        
                        let json = try JSON(data: data)
                        print(json)
                        let routes = json["routes"].arrayValue
                        
                        for route in routes{
                            
                            let overviewPolyline = route["overview_polyline"].dictionary
                            let points  = overviewPolyline?["points"]?.string
                            let path = GMSPath(fromEncodedPath: points ?? "")
                            let polyline = GMSPolyline(path: path)
                            polyline.strokeWidth = 5
                            completed(polyline)
                            
                        }
                        
                    }catch{
                        completed(nil)
                    }
                    
                case .failure(let error):
                    print(error)
                    completed(nil)
                }
        }
    }
    
    static func acceptOrder(_ id: Int, _ lat: String,_ lng: String,_ clientID: String, completed: @escaping (Bool)->Void){
        
        URLCache.shared.removeAllCachedResponses()
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(lat.data(using: String.Encoding.utf8)!, withName: "lat")
            multipartFormData.append(lng.data(using: String.Encoding.utf8)!, withName: "lng")
            multipartFormData.append("\(id)".data(using: String.Encoding.utf8)!, withName: "driver_id")
            
        }, to: URL(string: ACCEPT_ORDER_API + "\(clientID)")!, method: .post, headers: SharedData.headers) { (encodingResult) in
            
            switch encodingResult{
            
            case .success(let uploadRequest,_,_):
                
                uploadRequest.responseData { (response) in
                    
                    switch response.result{
                        
                    case .success(let data):
                        
                        print("res",try? JSON(data: data))
                        
                        if JSON(data)["masseage"].stringValue == "Notification send"{
                            completed(true)
                        }else{
                            completed(false)
                        }
                        
                    case .failure(let error):
                        
                        completed(false)
                        
                    }
                    
                }
                
            case .failure(let error):
                
                print("error",error)
                completed(false)
                
            }
            
        }
        
    }
    
    static func getProfile(completed: @escaping (ProfileResponse?)->Void){
        Alamofire.request(PROFILE_API, method: .get, parameters: nil, headers: SharedData.headers).responseData { (response) in
            switch response.result{
            case .success(let data):
                do{
                    let dataModel = try JSONDecoder.init().decode(ProfileResponse.self, from: data)
                    completed(dataModel)
                }catch let err{
                    print("err",err)
                    completed(nil)
                }
            default:
                completed(nil)
            }
        }
    }
    
    static func changeOrderStatus(id: String, status: String, completed: @escaping (Bool)->Void){
        Alamofire.upload(multipartFormData: { (multipart) in
            multipart.append(status.data(using: .utf8)!, withName: "status")
        }, to: CHANGE_ORDER_STATUS_API+id, method: .post, headers: SharedData.headers) { (encodingResult) in
            switch encodingResult{
            case.success(request: let request,_,_):
                request.responseData { (response) in
                    switch response.result{
                    case .success(let data):
                        do{
                            let json = try JSON(data: data)
                            if json["status"].stringValue == "200"{
                                completed(true)
                            }else{
                                completed(false)
                            }
                        }catch let error{
                            print("errPars",error)
                            completed(false)
                        }
                    case .failure(let error):
                        print("err",error)
                        completed(false)
                    }
                }
            default:
                break
            }
        }
    }
    
}
