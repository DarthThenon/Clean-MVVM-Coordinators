//
//  MealCategoryCodable.swift
//  Data
//
//  Created by Dmytro Yurchenko on 03.02.2022.
//

import Foundation
import Domain

struct MealCategoryCodable: Codable, Equatable {
    let idCategory: String
    let strCategory: String
    let strCategoryThumb: String?
    let strCategoryDescription: String
}

extension MealCategoryCodable {
    func toDomainModel() -> MealCategory {
        MealCategory.init(id: idCategory,
                          title: strCategory,
                          description: strCategoryDescription,
                          imageURL: strCategoryThumb.flatMap(URL.init))
    }
}
