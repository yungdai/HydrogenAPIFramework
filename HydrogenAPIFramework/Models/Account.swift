//
//  AccountType.swift
//  HydrogenAPIFramework
//
//  Created by Yung Dai on 2019-02-12.
//  Copyright © 2019 Yung Dai. All rights reserved.
//

import Foundation

struct Account: Codable {
	
	let id: String
	let mask: Int
	let name: String
	let subtype: String
	let type: String
}
