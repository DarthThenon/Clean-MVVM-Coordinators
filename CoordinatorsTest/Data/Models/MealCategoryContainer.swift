//
//  MealCategoryContainer.swift
//  Data
//
//  Created by Dmytro Yurchenko on 03.02.2022.
//

import Foundation

struct MealCategoryContainerDecodable: Decodable {
    let categories: [MealCategoryDecodable]
}
