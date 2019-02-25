//
//  HydrogenToken.swift
//  HydrogenAPIFramework
//
//  Created by Yung Dai on 2019-02-20.
//  Copyright © 2019 Yung Dai. All rights reserved.
//

import Foundation

struct HydrogenToken: Codable {
    
    let accessToken: String
    let tokenType: String
    let expiresIn: Int
    let scope: String
    let apps: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case scope, apps
    }
}
