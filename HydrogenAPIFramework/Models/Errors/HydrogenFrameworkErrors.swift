//
//  HydrogenFrameworkErrors.swift
//  HydrogenAPIFramework
//
//  Created by Yung Dai on 2019-03-07.
//  Copyright © 2019 Yung Dai. All rights reserved.
//

import Foundation

enum HydrogenFrameworkErrors: Error {
	
	case noClientID
	case noClientSecret
}

extension HydrogenFrameworkErrors {
	
	func getErrorDescription(error: HydrogenFrameworkErrors) -> String {
		
		switch error {
			
		case .noClientID:
			return "No ClientID Key, Please check to make set up the ClientID Key and that it is valid"
			
		case .noClientSecret:
			return "No ClientSecret Key, Please check to make set up the ClientSecret Key and that it is valid"
		}
	}
}
