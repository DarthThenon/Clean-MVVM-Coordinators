//
//  MealDetailsContainerDecodable.swift
//  Data
//
//  Created by Dmitriy Yurchenko on 03.02.2022.
//

import Foundation

struct MealDetailsContainerDecodable: Decodable {
    let meals: [MealDetailsDecodable]
}
