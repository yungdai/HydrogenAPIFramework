//
//  RatioResults.swift
//  HydrogenAPIFramework
//
//  Created by Yung Dai on 2019-02-21.
//  Copyright © 2019 Yung Dai. All rights reserved.
//

import Foundation

protocol RatioResultsProtocol {
    
    var ratioResult: Float { get set }
    var pass: Bool { get set }
    var percentileGrade: Float { get set }
    func title() -> String
}

extension RatioResultsProtocol {
    
    func getRatioResultsDescription(for title: String) -> String {
        
        let description = """
        \(title):
        Ratio Result: \(ratioResult)
        Pass: \(pass)
        Percentil Grade: \(percentileGrade)
        """
        
        return description
    }
}
