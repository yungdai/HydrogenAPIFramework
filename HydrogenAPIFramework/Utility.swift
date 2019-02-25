//
//  Utility.swift
//  HydrogenAPIDemo
//
//  Created by Yung Dai on 2019-02-12.
//  Copyright © 2019 Yung Dai. All rights reserved.
//

import Foundation

typealias PublicTokenKey = String

let publicTokenKey = "public_token"
let hydrogenTokenKey = "hydrogen_token"
let plaidTokenKey = "plaid_token"

class Utility: NSObject {

	// MARK: - Public Token Helpers
	static func savePublicTokenToDefaults(_ publicToken: String) {
		
		UserDefaults.standard.setValue(publicToken, forKey: publicTokenKey)
	}
	
	/// Tries to retrieve a saved public token form the app returns (token: String?, successful: Bool)
	static func retrievePubicTokenFromDefaults(completion: @escaping (PublicTokenKey?, Bool) -> Void)  {
		
		guard let token = UserDefaults.standard.string(forKey: publicTokenKey) else {
			
			completion(nil, false)
			return
		}

		completion(token, true)
	}
    
	static func clearTokenFromDefaults(_ tokenKey: String) {
        
        UserDefaults.standard.removeObject(forKey: tokenKey)
    }
	
	// MARK: Hydrogen API Login Helpers
	
	static func saveHydogenTokenToDefaults(_ hydrogenToken: HydrogenToken) {
		
		do {
			UserDefaults.standard.set(try PropertyListEncoder().encode(hydrogenToken), forKey: hydrogenTokenKey)
		} catch {
			print("unable to save key")
		}

	}
	
	static func retrieveHydogenTokenFromDefaults(completion: @escaping (HydrogenToken?, Bool) -> Void)  {
		
		if let data = UserDefaults.standard.value(forKey: hydrogenTokenKey) as? Data {
			
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
