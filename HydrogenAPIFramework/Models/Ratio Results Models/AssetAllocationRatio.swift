//
//  AssetAllocationRatio.swift
//  HydrogenAPIFramework
//
//  Created by Yung Dai on 2019-02-21.
//  Copyright © 2019 Yung Dai. All rights reserved.
//

import Foundation

public struct AssetAllocationRatio: Codable, RatioResultsProtocol {
    
    public var ratioResult: Float
    public var pass: Bool
    public var percentileGrade: Float
    
    enum CodingKeys: String, CodingKey {
        
        case ratioResult = "ratio_result"
        case pass
        case percentileGrade = "percentile_grade"
    }
    
    public func title() -> String {
        return "Asset Allocation Ratio"
    }
}

extension AssetAllocationRatio: CustomStringConvertible {
    
    public var description: String {
        let description = self.getRatioResultsDescription(for: title())
        return description
    }
}
