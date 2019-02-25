//
//  Result.swift
//  HydrogenAPIFramework
//
//  Created by Yung Dai on 2019-02-20.
//  Copyright © 2019 Yung Dai. All rights reserved.
//

import Foundation

enum Result<T,E> {
	
	case success(T)
	case error(E)
}
