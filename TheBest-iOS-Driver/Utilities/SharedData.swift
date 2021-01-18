//
//  SharedData.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 10/8/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class SharedData{
    static let headers = [
        "Authorization": "Bearer " + (UserDefaults.init().string(forKey: "accessToken") ?? ""),
        "Accept": "application/json"
    ]
    static let goolgeApiKey = "AIzaSyDBDV-XxFpmbx79T5HLPrG9RmjDpiYshmE"
    static var userLat: CLLocationDegrees?
    static var userLng: CLLocationDegrees?
    static var receivedOrder: ReceivedOrder?
    static var inProgressStatus = "in progress"
    static var orderOnDeliveryStatus = "on delivery"
    static var arrivedStatus = "arrived"
    static var completedStatus = "completed"
    static var receivedPushNotification: [AnyHashable: Any]?
   // static var receivedTripID: Int?
    static var appCategories: [AppCategory]{
        var appCategories = [AppCategory]()
        appCategories.append(AppCategory(icon: UIImage(named: "food_icon6262"), name: "Restaurants & Cafe"))
        appCategories.append(AppCategory(icon: UIImage(named: "taxi_icon562"), name: "Taxi services"))
        appCategories.append(AppCategory(icon: UIImage(named: "car_icon161"), name: "Car rent"))
        appCategories.append(AppCategory(icon: UIImage(named: "special_need_icon451"), name: "Special need car"))
        appCategories.append(AppCategory(icon: UIImage(named: "market_icon46"), name: "Markets & Associations"))
        //appCategories.append(AppCategory(icon: UIImage(named: "azzount_icon"), name: "Monthly  Account"))
        appCategories.append(AppCategory(icon: UIImage(named: "road_icon6463"), name: "Road rescue services"))
        appCategories.append(AppCategory(icon: UIImage(named: "furniture_icon159"), name: "Furniture transporting"))
        return appCategories
    }
    
    static func getColor(_ index: Int)->UIColor{
        switch index{
        case 1,2:
            return UIColor(named: "TaxiGoldColor")!
//        case 2:
//            return UIColor(named: "CarRentColor")!
        case 4:
            return UIColor(named: "SpecialNeedCarColor")!
      /*  case 4:
            return UIColor(named: "MarketsColor")!*/
        case 15:
            return UIColor(named: "RoadServicesColor")!
        case 16:
            return UIColor(named: "FurnitureColor")!
        case 17:
            return UIColor(named: "MonthlyColor")!
        case 40:
            return UIColor(named: "RestaurantsColor")!
        case 21:
            return UIColor(named: "CarRentColor")!
        case 43:
            return UIColor(named: "MarketsColor")!
        case 41:
            return UIColor(named: "vegColor")!
        default:
            return UIColor(named: "RestaurantsColor")!
        }
    }
    
    static func getRideType(_ index: Int)->AppCategory{
        switch index{
        case 1,2:
            return AppCategory(icon: UIImage(named: "taxi_icon562"), name: "Taxi services")
//        case 2:
//            return AppCategory(icon: UIImage(named: "car_icon161"), name: "Car rent")
        case 4:
            return AppCategory(icon: UIImage(named: "special_need_icon451"), name: "Special need car")
      /*  case 4:
            return UIColor(named: "MarketsColor")!*/
        case 15:
            return AppCategory(icon: UIImage(named: "road_icon6463"), name: "Road services")
        case 16:
            return AppCategory(icon: UIImage(named: "furniture_icon159"), name: "Furniture transporting")
        case 17:
            return AppCategory(icon: UIImage(named: "azzount_icon"), name: "Monthly subscript")
        case 40:
            return AppCategory(icon: UIImage(named: "food_icon6262"), name: "Restaurants & Cafe")
        case 21:
            return AppCategory(icon: UIImage(named: "car_icon161"), name: "Car")
        case 43:
            return AppCategory(icon: UIImage(named: "market_icon46"), name: "Markets")
        case 41:
            return AppCategory(icon: UIImage(named: "market_icon46"), name: "")
        default:
            return AppCategory(icon: UIImage(named: "food_icon6262"), name: "Restaurants & Cafe")
        }
    }
    
}

struct AppCategory{
    let icon: UIImage?
    let name: String?
}
