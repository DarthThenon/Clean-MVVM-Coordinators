//
//  MealCategoryDecodable.swift
//  Data
//
//  Created by Dmytro Yurchenko on 03.02.2022.
//

import Foundation

struct MealCategoryDecodable: Decodable {
    let idCategory: String
    let strCategory: String
    let strCategoryThumb: String?
    let strCategoryDescription: String
}
