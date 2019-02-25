//
//  NetworkServiceError.swift
//  HydrogenAPIFramework
//
//  Created by Yung Dai on 2019-02-20.
//  Copyright © 2019 Yung Dai. All rights reserved.
//

import Foundation

enum NetworkServiceError: Error {
	case connectionError
	case unableToGetData
	case decodingError
	case noData
	case noOAuthtoken
}
