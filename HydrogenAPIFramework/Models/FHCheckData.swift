//
//  FHCheckData.swift
//  HydrogenAPIFramework
//
//  Created by Yung Dai on 2019-02-20.
//  Copyright © 2019 Yung Dai. All rights reserved.
//

import Foundation

public struct FHCheckData: Codable {

	public let liquidAssets: Float
	public let nonLiquidAssets: Float
	public let shortTermLiabilities: Float
	public let totalLiabilities: Float
	public let grossAnnualIncome: Float
	public let netMonthlyIncome: Float
	public let monthlyExpense: Float
	public let ratioTargets: RatioTargets
	
	enum CodingKeys: String, CodingKey {
		
		case liquidAssets = "liquid_assets"
		case nonLiquidAssets = "non_liquid_assets"
		case shortTermLiabilities = "short_term_liabilities"
		case totalLiabilities = "total_liabilities"
		case grossAnnualIncome = "gross_annual_income"
		case netMonthlyIncome = "net_monthly_income"
		case monthlyExpense = "monthly_expense"
		case ratioTargets = "ratio_targets"
	}
}

extension FHCheckData {
    
    public static func getTestData() -> FHCheckData {
        
        let ratioTargets = RatioTargets.getTestData()
        
        let financialData = FHCheckData.init(liquidAssets: 5000,
                                                          nonLiquidAssets: 10000,
                                                          shortTermLiabilities: 1100,
                                                          totalLiabilities: 1400,
                                                          grossAnnualIncome: 60000,
                                                          netMonthlyIncome: 3500,
                                                          monthlyExpense: 3000,
                                                          ratioTargets: ratioTargets)
        
        return financialData
    }
}


