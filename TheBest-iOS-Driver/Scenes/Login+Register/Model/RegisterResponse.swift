//
//  RegisterResponse.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 10/31/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

// MARK: - RegisterResponse
struct RegisterResponse: Codable {
    let massege: String
    let user: MyProfile

    enum CodingKeys: String, CodingKey {
        case massege
        case user = "User"
    }
}
