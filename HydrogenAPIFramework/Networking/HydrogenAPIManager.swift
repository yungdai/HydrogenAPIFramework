//
//  HydrogenAPIManager.swift
//  HydrogenAPIFramework
//
//  Created by Yung Dai on 2019-02-24.
//  Copyright © 2019 Yung Dai. All rights reserved.
//

import Foundation
import Alamofire



protocol HydrogenAPIManagerProtocol {
    
    func handleFHCheckResponse(_ results: FHealthCheckResponseCompletion, sender: UIControl?)
}

extension HydrogenAPIManagerProtocol {
    
    // optionally handled
    func handleFHCheckResponse(_ results: FHealthCheckResponseCompletion, sender: UIControl?) {}
}

final class HydrogenAPIManager {
	
	static let sharedInstance = HydrogenAPIManager()
	
	private var hydrogenToken: HydrogenToken?
	
	required init() {
		checkUserDefaultsForToken { hasToken in
			print("There is a Hydrogen API token")
			
		}
	}
	
	private var hydrogenAPIKeys: HydrogenAPIKeys?
	
	// MARK: API Key setup
	public func setupHydrogenAPIKeys(clientID: String, clientSecret: String) {
		
		self.hydrogenAPIKeys = HydrogenAPIKeys(clientID: clientID, clientSecret: clientSecret)
	}
	
	private func getKeys() throws -> (clientID: String, clientSecret: String) {
		
		guard let clientID = hydrogenAPIKeys?.hydrogenClientID else { throw  HydrogenFrameworkErrors.noClientID }
		
		guard let clientSecret = hydrogenAPIKeys?.hydrogenClientSecret else { throw HydrogenFrameworkErrors.noClientSecret}
		
		return (clientID: clientID, clientSecret: clientSecret)
	}
	
	
	// MARK: OAuth flow
	private func startOAuth2Login(_ completion: @escaping (OAuthResponseCompletion) ->()) {

		do {
			let keys = try getKeys()
			
			let credentials = "\(keys.clientID):\(keys.clientSecret)"
			guard let encodedCredentials = credentials.data(using: .utf8)?.base64EncodedString() else { return }
			
			let tokenParam = ["grant_type":"client_credentials"]
			Alamofire.request(authPathURL, method: .post, parameters: tokenParam, headers: ["Authorization": "Basic \(encodedCredentials)"])
				.responseData { response in
					
					guard response.result.isSuccess,
						let data = response.result.value else {
							print("Error while fetching tags: \(String(describing: response.result.error))")
							
							completion(.error(NetworkServiceError.noOAuthtoken))
							return
					}
					
					do {
						
						let jsonDecoder = JSONDecoder()
						let hydrogenToken = try jsonDecoder.decode(HydrogenToken.self, from: data)
						
						UserDefaultsUtility.saveHydogenTokenToDefaults(hydrogenToken)
						self.hydrogenToken = hydrogenToken
						
						completion(.success(true))
					} catch let error {
						
						UserDefaultsUtility.clearTokenFromDefaults(.hydrogenToken)
						print(error.localizedDescription)
						
						completion(.error(NetworkServiceError.noData))
					}
			}
		} catch let error {
			
			
			
			fatalError("Error: \(error)")
		}
		
		
	}
	
	func checkUserDefaultsForToken(completion: @escaping (Bool) ->()) {
		
		UserDefaultsUtility.retrieveHydogenTokenFromDefaults { hydrogenToken, success in
			self.hydrogenToken = hydrogenToken
			completion(success)
		}
	}
	
	private func hasOAuthToken() -> Bool {
		return (hydrogenToken != nil) ? true : false
	}
	
	private func getOAuthToken(completion: @escaping (HydrogenToken?) -> Void) {
		
		if hasOAuthToken() {
			
			completion(self.hydrogenToken)
		} else {
			
			startOAuth2Login { results in
				
				switch results {
				case .success(_):
					
					// if successful we should save the hydrogen token
					print("successfully logged in")
					
					completion(self.hydrogenToken)
				case .error(let error):
					
					print("Could not get Hydrogen Token: \(error)")
					completion(nil)
				}
			}
		}
	}
	
	func fetchFinancialHealthCheckData(with financialData: FHCheckData, completion: @escaping (FHealthCheckResponseCompletion) -> ()) {
		
		guard let healthCheckHeader = getHealthCheckHeader() else {
			completion(.error(NetworkServiceError.noOAuthtoken))
			return
		}
		
		let parameters = financialData.convertToParameters()
		
		Alamofire.request(financialHealthCheckURL, method: .post,
						  parameters: parameters, encoding: JSONEncoding.default,
						  headers: healthCheckHeader)
			.responseData { responseData in
				
				guard responseData.result.isSuccess,
					let data = responseData.result.value else {
						completion(.error(NetworkServiceError.connectionError))
						return
				}
				
				do {
					
					let fhCheckReponse = try JSONDecoder().decode(FHCheckResponse.self, from: data)
					completion(.success(fhCheckReponse))
				} catch {
					completion(.error(NetworkServiceError.decodingError))
					print(error)
				}
		}
	}
	
	private func getHealthCheckHeader() -> [String: String]?  {
		
		var accessToken: [String: String]?
		
		getOAuthToken { (response) in
			
			guard let response = response else { return }
			accessToken = ["Authorization": "Bearer \(response.accessToken)"]
		}
		
		return accessToken
	}
}
