//
//  MealDecodable.swift
//  Data
//
//  Created by Dmytro Yurchenko on 03.02.2022.
//

import Foundation
import Domain

struct MealDecodable: Decodable {
    let idMeal, strMeal: String
    let strMealThumb: String?
}

extension MealDecodable {
    func toDomainModel() -> Meal {
        Meal.init(id: idMeal,
                  imageURL: strMealThumb.flatMap(URL.init),
                  title: strMeal)
    }
    
    func toEntity() -> MealEntity {
        let entity = MealEntity()
        
        entity.id = idMeal
        entity.title = strMeal
        entity.imageUrlString = strMealThumb
        
        return entity
    }
}
