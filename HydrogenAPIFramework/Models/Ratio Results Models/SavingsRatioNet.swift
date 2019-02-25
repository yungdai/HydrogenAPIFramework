//
//  SavingsRatioNet.swift
//  HydrogenAPIFramework
//
//  Created by Yung Dai on 2019-02-21.
//  Copyright © 2019 Yung Dai. All rights reserved.
//

import Foundation

struct SavingsRatioNet: Decodable, RatioResultsProtocol {
    
    var ratioResult: Float
    var pass: Bool
    var percentileGrade: Float
    
    enum CodingKeys: String, CodingKey {
        
        case ratioResult = "ratio_result"
        case pass
        case percentileGrade = "percentile_grade"
    }
    
    func title() -> String {
        return "Savings Ratio Net"
    }
}

extension SavingsRatioNet: CustomStringConvertible {
    
    var description: String {
        let description = self.getRatioResultsDescription(for: title())
        return description
    }
}
