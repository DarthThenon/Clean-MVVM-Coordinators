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
    
    func toDomainModel() -> Meal {
        Meal.init(id: idMeal,
                  imageURL: strMealThumb.flatMap(URL.init),
                  title: strMeal)
    }
}
