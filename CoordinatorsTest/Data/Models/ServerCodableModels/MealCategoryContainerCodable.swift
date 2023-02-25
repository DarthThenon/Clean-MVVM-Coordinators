//
//  MealCategoryContainer.swift
//  Data
//
//  Created by Dmytro Yurchenko on 03.02.2022.
//

import Foundation

struct MealCategoryContainerCodable: Codable, Equatable {
    let categories: [MealCategoryCodable]
}
