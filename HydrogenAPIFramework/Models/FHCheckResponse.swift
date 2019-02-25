//
//  FHCheckResponse.swift
//  HydrogenAPIFramework
//
//  Created by Yung Dai on 2019-02-20.
//  Copyright © 2019 Yung Dai. All rights reserved.
//

import Foundation

struct FHCheckResponse: Decodable {
    
	let liquidityRatioExpenses: LiquidityRatioExpenses?
	let liquidityRatioLiabilities: LiquidityRatioLiabilities?
	let currentRatio: CurrentRatio?
	let assetAllocationRatio: AssetAllocationRatio?
	let savingsRatioGross: SavingsRatioGross?
	let savingsRatioNet: SavingsRatioNet?
	let totalAssets: Float
	let netWorth: Float
	let grossMonthlyIncome: Float
	let monthlySurplus: Float?
	
	enum CodingKeys: String, CodingKey {
		
		case liquidityRatioExpenses = "liquidity_ratio_expenses"
		case liquidityRatioLiabilities = "liquidity_ratio_liabilities"
		case currentRatio = "current_ratio"
		case assetAllocationRatio = "asset_allocation_ratio"
		case savingsRatioGross = "savings_ratio_gross"
		case savingsRatioNet = "savings_ratio_net"
		case totalAssets = "total_assets"
		case netWorth = "net_worth"
		case grossMonthlyIncome = "gross_monthly_income"
		case monthlySurplus = "monthly_surplus"
	}
}

extension FHCheckResponse {
    
    var showValidResponses: String {
   
        var returnedRatioResults = [RatioResultsProtocol]()
        
        if let liquidityRatioExpenses = self.liquidityRatioExpenses {
            returnedRatioResults.append(liquidityRatioExpenses)
        }
        
        if let liquidityRatioLiabilities = self.liquidityRatioLiabilities {
            returnedRatioResults.append(liquidityRatioLiabilities)
        }
        
        if let currentRatio = self.currentRatio {
            returnedRatioResults.append(currentRatio)
        }
        
        if let assetAllocationRatio = self.assetAllocationRatio {
            returnedRatioResults.append(assetAllocationRatio)
        }
        
        if let savingsRatioGross = self.savingsRatioGross {
            returnedRatioResults.append(savingsRatioGross)
        }
        if let savingsRatioNet = self.savingsRatioNet {
            returnedRatioResults.append(savingsRatioNet)
        }
        
        var ratioResultDecriptions: String = ""

        
        
        returnedRatioResults.forEach {
            
            let ratioDescriptions = $0.getRatioResultsDescription(for: $0.title())
            ratioResultDecriptions.append("\(ratioDescriptions)\n\n")
        }
        
        let description = """
        
        \(ratioResultDecriptions)
        total assets: \(totalAssets.dollarsFormat())
        net worth: \(netWorth.dollarsFormat())
        gross monthly income: \(grossMonthlyIncome.dollarsFormat())
        monthly surplus: \(String(describing: monthlySurplus))
        """
        
        return description
    }
}
