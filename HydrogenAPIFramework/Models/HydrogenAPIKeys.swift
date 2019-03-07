//
//  HydrogenAPIKeys.swift
//  HydrogenAPIFramework
//
//  Created by Yung Dai on 2019-03-07.
//  Copyright © 2019 Yung Dai. All rights reserved.
//

import Foundation

final class HydrogenAPIKeys {

	var hydrogenClientID: String?
	var hydrogenClientSecret: String?

	convenience init(clientID: String, clientSecret: String) {
		
		self.init()
		self.hydrogenClientID = clientID
		self.hydrogenClientSecret = clientSecret
	}
}
