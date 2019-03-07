//
//  Utility.swift
//  HydrogenAPIDemo
//
//  Created by Yung Dai on 2019-02-12.
//  Copyright © 2019 Yung Dai. All rights reserved.
//

import Foundation

protocol Saveable: Encodable { }

typealias PublicTokenKey = String

enum SaveKeys: String {
	case publicToken
	case hydrogenToken
}

struct UserDefaultsUtility {
	
	// MARK: - Hydrogen Public Token Helpers
	static func savePublicTokenToDefaults(_ publicToken: String) {
		
		UserDefaults.standard.setValue(publicToken, forKey: SaveKeys.publicToken.rawValue)
	}
	
	/// Tries to retrieve a saved public token form the app returns (token: String?, successful: Bool)
	static func retrievePubicTokenFromDefaults(completion: @escaping (PublicTokenKey?, Bool) -> Void)  {
		
		guard let token = UserDefaults.standard.string(forKey: SaveKeys.publicToken.rawValue) else {
			
			completion(nil, false)
			return
		}
		
		completion(token, true)
	}
	
	
	static func clearTokenFromDefaults(_ saveKeys: SaveKeys) {
		
		UserDefaults.standard.removeObject(forKey: saveKeys.rawValue)
	}
	
	// MARK: Hydrogen API Login Helpers
	static func saveHydogenTokenToDefaults(_ hydrogenToken: HydrogenToken) {
		
		do {
			UserDefaults.standard.set(try PropertyListEncoder().encode(hydrogenToken), forKey: SaveKeys.hydrogenToken.rawValue)
		} catch {
			print("unable to save key")
		}
		
	}
	
	static func retrieveHydogenTokenFromDefaults(completion: @escaping (HydrogenToken?, Bool) -> Void)  {
		
		if let data = UserDefaults.standard.value(forKey: SaveKeys.hydrogenToken.rawValue) as? Data {
			
			do {
				let token = try PropertyListDecoder().decode(HydrogenToken.self, from: data)
				completion(token, true)
			} catch {
				
				print("error retrving Hydrogen Token")
				completion(nil, false)
			}
		}
	}
}
