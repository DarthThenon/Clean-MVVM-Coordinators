//
//  EntityMappable.swift
//  Data
//
//  Created by Dmitriy Yurchenko on 25.02.2023.
//

import Foundation
import CoreData

protocol EntityMappable {
    associatedtype Entity
    func toEntity(in context: NSManagedObjectContext) -> Entity
}
