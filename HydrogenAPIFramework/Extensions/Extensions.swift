//
//  Extensions.swift
//  HydrogenAPIFramework
//
//  Created by Yung Dai on 2019-02-21.
//  Copyright © 2019 Yung Dai. All rights reserved.
//

import Foundation

typealias FHealthCheckResponseCompletion = Result<FHCheckResponse, Error>
typealias OAuthResponseCompletion = Result<Bool, Error>

extension Encodable {
	
	func convertToParameters() -> [String: Any]? {
		
		do {
            
			let jsonEncoder = JSONEncoder()
			let data = try jsonEncoder.encode(self)
			let mappedData = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers, .allowFragments]) as? [String : Any]
			return mappedData
		} catch {
            
			return nil
		}
	}
}

extension Float {
    
    func dollarsFormat() -> String {
        let dollarsFormat = String(format:"$%.2f", arguments: [self])
        return dollarsFormat
    }
}
