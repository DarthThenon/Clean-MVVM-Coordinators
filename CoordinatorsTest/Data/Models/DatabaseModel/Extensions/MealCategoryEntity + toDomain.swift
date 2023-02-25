//
//  MealCategoryEntity + toDomain.swift
//  Data
//
//  Created by Dmitriy Yurchenko on 25.02.2023.
//

import Foundation
import Domain

extension MealCategoryEntity {
    func toDomainModel() -> MealCategory? {
        guard let id,
              let title
        else { return nil }
        
        return MealCategory(
            id: id,
            title: title,
            description: body ?? "",
            imageURL: imageUrlString.flatMap(URL.init)
        )
    }
}
