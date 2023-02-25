//
//  MealEntity + toDomain.swift
//  Data
//
//  Created by Dmitriy Yurchenko on 25.02.2023.
//

import Foundation
import Domain

extension MealEntity {
    func toDomainModel() -> Meal? {
        guard let id,
              let category,
              let title
        else { return nil }
        
        return Meal(
            id: id,
            category: category,
            imageURL: imageUrlString.flatMap(URL.init),
            title: title
        )
    }
}
