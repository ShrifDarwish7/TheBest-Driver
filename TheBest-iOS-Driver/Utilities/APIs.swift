//
//  APIs.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 10/8/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

let BASE_URL = "https://thebest-solution.com/"
let LOGIN_API = BASE_URL + "Driver/Auth/login"
let REGISTER_API = BASE_URL + "Driver/Auth/register"
let DRIVERS_SPECIALTY_API = BASE_URL + "Driver/DriversSpecialty"
let PROFILE_UPDATE_API = BASE_URL + "Driver/Main/UpdateDriver"
let MY_ORDERS_API = BASE_URL + "Driver/Main/Myorders"
let DRIVER_REPORTS_API = BASE_URL + "Driver/Main/DriverReports"
let GET_TRIP_BY_ID = BASE_URL + "Driver/Main/GetTripByID/"
let CONFIRM_END_RIDE = BASE_URL + "Driver/Main/ConformEndRide/"
let RIDE_PRICE_API = BASE_URL + "Driver/Main/RidePrice"
let HERE_DRIVER_API = BASE_URL + "Driver/Main/DriverArrived/"
let ACCEPT_ORDER_API = BASE_URL + "Driver/Main/AcceptTrip/"
let ADD_SPECIALTY_API = BASE_URL + "Driver/Main/AddSpecialty"
let PROFILE_API = BASE_URL + "Driver/Main/Myprofile"
let CHANGE_ORDER_STATUS_API = BASE_URL + "api/Main/ChangeOrderTrip/"
let COUNTRIES_API = BASE_URL + "Driver/Main/Country"
let START_RIDE_API = BASE_URL + "api/Trip/StartRide/"
let END_RIDE_API = BASE_URL + "api/Trip/EndRide/"
let CANCEL_RIDE = BASE_URL + "api/Trip/CancelRide"
let DISTANCE_API = BASE_URL + "Restaurants/Main/GetDistanceRest"
let RIDE_PRICE = BASE_URL + "api/Trip/RidePrice"
let CHANGE_TRIP_STATUS_API = BASE_URL + "api/Trip/ChangeOrderTrip/{trip_id}"
let HEADERS = ["Accept": "application/json"]
