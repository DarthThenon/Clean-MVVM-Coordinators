//
//  MealDetails.swift
//  Domain
//
//  Created by Dmitriy Yurchenko on 03.02.2022.
//

import Foundation

public struct MealDetails {
    public let id: String
    public let title: String
    public let category: String
    public let nationality: String
    public let instruction: String
    public let imageUrl: URL?
    public let ingredients: [MealIngredient]
    public let tags: String
    public let link: URL?
    
    public init(id: String,
         title: String,
         category: String,
         nationality: String,
         instruction: String,
         imageUrl: URL?,
         ingredients: [MealIngredient],
         tags: String,
         link: URL?) {
        
        self.id = id
        self.title = title
        self.category = category
        self.nationality = nationality
        self.instruction = instruction
        self.imageUrl = imageUrl
        self.ingredients = ingredients
        self.tags = tags
        self.link = link
    }
}
