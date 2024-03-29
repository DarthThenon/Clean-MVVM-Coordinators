//
//  MealCategory + toEntity.swift
//  Data
//
//  Created by Dmitriy Yurchenko on 25.02.2023.
//

import Foundation
import Domain
import CoreData

extension MealCategory: EntityMappable {
    func toEntity(in context: NSManagedObjectContext) -> MealCategoryEntity {
        let entity = MealCategoryEntity(context: context)
        
        entity.id = id
        entity.title = title
        entity.body = description
        entity.imageUrlString = imageURL?.absoluteString
        
        return entity
    }
}
