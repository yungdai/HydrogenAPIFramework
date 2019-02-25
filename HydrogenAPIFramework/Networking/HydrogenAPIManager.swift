//
//  HydrogenAPIManager.swift
//  HydrogenAPIFramework
//
//  Created by Yung Dai on 2019-02-24.
//  Copyright © 2019 Yung Dai. All rights reserved.
//

import Foundation
import Alamofire

private let clientID = <#String#>
private let clientSecret = <#String#>

typealias FHealthCheckResponseCompletion = Result<FHCheckResponse, Error>
typealias OAuthResponseCompletion = Result<Bool, Error>

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
    

    private let authPathURLString = "https://sandbox.hydrogenplatform.com/authorization/v1/oauth/token"
    
    private let financialHealthCheckURLString = "https://sandbox.hydrogenplatform.com/proton/v1/financial_health_check"
    
    required init() {
        checkUserDefaultsForToken { hasToken in
            print("There is a Hydrogen API token")
            
        }
    }
    
    // MARK: OAuth flow
    func startOAuth2Login(_ completion: @escaping (OAuthResponseCompletion) ->()) {
        
        let credentials = "\(clientID):\(clientSecret)"
        guard let encodedCredentials = credentials.data(using: .utf8)?.base64EncodedString() else { return }
        
        let tokenParam = ["grant_type":"client_credentials"]
        Alamofire.request(authPathURLString, method: .post, parameters: tokenParam, headers: ["Authorization": "Basic \(encodedCredentials)"])
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
                    
                    Utility.saveHydogenTokenToDefaults(hydrogenToken)
                    self.hydrogenToken = hydrogenToken
                    
                    completion(.success(true))
                } catch let error {
                    
                    Utility.clearTokenFromDefaults(hydrogenTokenKey)
                    print(error.localizedDescription)
                    
                    completion(.error(NetworkServiceError.noData))
                }
        }
    }
    
    func checkUserDefaultsForToken(completion: @escaping (Bool) ->()) {
        
        Utility.retrieveHydogenTokenFromDefaults { hydrogenToken, success in
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
                    
                    print(error)
                    completion(nil)
                }
            }
        }
    }
    
    func fetchFinancialHealthCheckData(with financialData: FinancialHealthCheckData, completion: @escaping (FHealthCheckResponseCompletion) -> ()) {
        
        guard let healthCheckHeader = getHealthCheckHeader() else {
            completion(.error(NetworkServiceError.noOAuthtoken))
            return
        }
        
        let parameters = financialData.convertToParameters()
        
        Alamofire.request(financialHealthCheckURLString, method: .post,
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
