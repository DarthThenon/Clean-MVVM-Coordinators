//
//  MealDetailsDecodable.swift
//  Data
//
//  Created by Dmitriy Yurchenko on 03.02.2022.
//

import Foundation
import Domain

struct MealDetailsDecodable: Decodable {
    let idMeal, strMeal, strCategory: String
    let strArea, strInstructions, strTags: String
    let strMealThumb, strYoutube: String?
    
    let strIngredient1, strIngredient2, strIngredient3: String?
    let strIngredient4, strIngredient5, strIngredient6: String?
    let strIngredient7, strIngredient8, strIngredient9: String?
    let strIngredient10, strIngredient11, strIngredient12: String?
    let strIngredient13, strIngredient14, strIngredient15: String?
    let strIngredient16, strIngredient17, strIngredient18: String?
    let strIngredient19, strIngredient20: String?
    
    let strMeasure1, strMeasure2, strMeasure3: String?
    let strMeasure4, strMeasure5, strMeasure6: String?
    let strMeasure7, strMeasure8, strMeasure9: String?
    let strMeasure10, strMeasure11, strMeasure12: String?
    let strMeasure13, strMeasure14, strMeasure15: String?
    let strMeasure16, strMeasure17, strMeasure18: String?
    let strMeasure19, strMeasure20: String?
    
    func toDomainModel() -> MealDetails {
        MealDetails.init(
            id: idMeal,
            title: strMeal,
            category: strCategory,
            nationality: strArea,
            instruction: strInstructions,
            imageUrl: strMealThumb.flatMap(URL.init),
            ingredients: gatherIngredients(),
            tags: strTags,
            link: strYoutube.flatMap(URL.init))
    }
    
    private func gatherIngredients() -> [MealIngredient] {
        [
            createIngredient(ingredient: strIngredient1, measure: strMeasure1),
            createIngredient(ingredient: strIngredient2, measure: strMeasure2),
            createIngredient(ingredient: strIngredient3, measure: strMeasure3),
            createIngredient(ingredient: strIngredient4, measure: strMeasure4),
            createIngredient(ingredient: strIngredient5, measure: strMeasure5),
            createIngredient(ingredient: strIngredient6, measure: strMeasure6),
            createIngredient(ingredient: strIngredient7, measure: strMeasure7),
            createIngredient(ingredient: strIngredient8, measure: strMeasure8),
            createIngredient(ingredient: strIngredient9, measure: strMeasure9),
            createIngredient(ingredient: strIngredient10, measure: strMeasure10),
            createIngredient(ingredient: strIngredient11, measure: strMeasure11),
            createIngredient(ingredient: strIngredient12, measure: strMeasure12),
            createIngredient(ingredient: strIngredient13, measure: strMeasure13),
            createIngredient(ingredient: strIngredient14, measure: strMeasure14),
            createIngredient(ingredient: strIngredient15, measure: strMeasure15),
            createIngredient(ingredient: strIngredient16, measure: strMeasure16),
            createIngredient(ingredient: strIngredient17, measure: strMeasure17),
            createIngredient(ingredient: strIngredient18, measure: strMeasure18),
            createIngredient(ingredient: strIngredient19, measure: strMeasure19),
            createIngredient(ingredient: strIngredient20, measure: strMeasure20),
        ].compactMap { $0 }
    }
    
    private func createIngredient(ingredient: String?,
                                  measure: String?) -> MealIngredient? {
        guard let ingredient = ingredient else {
            return nil
        }
        
        return MealIngredient.init(title: ingredient, measure: measure ?? "")
    }
}
