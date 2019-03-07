//
//  RatioTargets.swift
//  HydrogenAPIFramework
//
//  Created by Yung Dai on 2019-02-20.
//  Copyright © 2019 Yung Dai. All rights reserved.
//

import Foundation

public struct RatioTargets: Codable {
	
	public let liquidityRatioExpenses: Float
	public let liquidityRatioLiabilities: Float
	public let currentRatio: Float
	public let assetAllocationRatio: Float
	public let savingsRatioGross: Float
	public let savingsRatioNet: Float
	
    enum CodingKeys: String, CodingKey {
		case liquidityRatioExpenses = "liquidity_ratio_expenses"
		case liquidityRatioLiabilities = "liquidity_ratio_liabilities"
		case currentRatio = "current_ratio"
		case assetAllocationRatio = "asset_allocation_ratio"
		case savingsRatioGross = "savings_ratio_gross"
		case savingsRatioNet = "savings_ratio_net"
	}
}

extension RatioTargets {
    
    public static func getTestData() -> RatioTargets {
        
        let ratioTargets = RatioTargets.init(liquidityRatioExpenses: 2.5,
                                             liquidityRatioLiabilities: 0.1,
                                             currentRatio: 0.5,
                                             assetAllocationRatio: 1.5,
                                             savingsRatioGross: 0.1,
                                             savingsRatioNet: 0.1)
        
        return ratioTargets
    }
}
