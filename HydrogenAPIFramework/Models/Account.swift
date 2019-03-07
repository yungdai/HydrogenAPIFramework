//
//  AccountType.swift
//  HydrogenAPIFramework
//
//  Created by Yung Dai on 2019-02-12.
//  Copyright © 2019 Yung Dai. All rights reserved.
//

import Foundation

public struct Account: Codable {
	
	public let id: String
	public let mask: Int
	public let name: String
	public let subtype: String
	public let type: String
}
