//
//  LoginResponse.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 10/8/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation


// MARK: - LoginResponse
struct LoginResponse: Codable {
    let status: Int?
    let myProfile: MyProfile

    enum CodingKeys: String, CodingKey {
        case status
        case myProfile = "user"
    }
}



