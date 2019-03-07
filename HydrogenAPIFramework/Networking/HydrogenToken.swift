//
//  HydrogenToken.swift
//  HydrogenAPIFramework
//
//  Created by Yung Dai on 2019-02-20.
//  Copyright © 2019 Yung Dai. All rights reserved.
//

import Foundation

public struct HydrogenToken: Codable {
    
    public let accessToken: String
    public let tokenType: String
    public let expiresIn: Int
    public let scope: String
    public let apps: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case scope, apps
    }
}
