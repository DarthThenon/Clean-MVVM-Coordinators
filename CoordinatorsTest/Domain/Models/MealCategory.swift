//
//  MealCategory.swift
//  Domain
//
//  Created by Dmytro Yurchenko on 03.02.2022.
//

import Foundation

public struct MealCategory: Hashable {
    public let id, title, description: String
    public let imageURL: URL?
    
    public init(id: String,
                title: String,
                description: String,
                imageURL: URL?) {
        self.id = id
        self.description = description
        self.title = title
        self.imageURL = imageURL
    }
}
