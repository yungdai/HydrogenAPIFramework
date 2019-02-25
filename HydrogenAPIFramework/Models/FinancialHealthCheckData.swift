//
//  FinancialHealthCheck.swift
//  HydrogenAPIFramework
//
//  Created by Yung Dai on 2019-02-20.
//  Copyright © 2019 Yung Dai. All rights reserved.
//

import Foundation

struct FinancialHealthCheckData: Codable {

	let liquidAssets: Float
	let nonLiquidAssets: Float
	let shortTermLiabilities: Float
	let totalLiabilities: Float
	let grossAnnualIncome: Float
	let netMonthlyIncome: Float
	let monthlyExpense: Float
	let ratioTargets: RatioTargets
	
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

extension FinancialHealthCheckData {
    
    static func getTestData() -> FinancialHealthCheckData {
        
        let ratioTargets = RatioTargets.getTestData()
        
        let financialData = FinancialHealthCheckData.init(liquidAssets: 5000,
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


