//
//  Meal + toEntity.swift
//  Data
//
//  Created by Dmitriy Yurchenko on 25.02.2023.
//

import Foundation
import Domain
import CoreData

extension Meal: EntityMappable {
    func toEntity(in context: NSManagedObjectContext) -> MealEntity {
        let entity = MealEntity(context: context)
        
        entity.id = id
        entity.title = title
        entity.imageUrlString = imageURL?.absoluteString
        entity.category = category
        
        return entity
    }
}
