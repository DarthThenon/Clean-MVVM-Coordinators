//
//  MealIngredient.swift
//  Domain
//
//  Created by Dmitriy Yurchenko on 03.02.2022.
//

import Foundation

public struct MealIngredient {
    public let title: String
    public let measure: String
    
    public init(title: String,
                measure: String) {
        
        self.title = title
        self.measure = measure
    }
}
