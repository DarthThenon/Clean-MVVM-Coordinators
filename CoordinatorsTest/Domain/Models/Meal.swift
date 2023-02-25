//
//  Meal.swift
//  Domain
//
//  Created by Dmytro Yurchenko on 03.02.2022.
//

import Foundation

public struct Meal {
    public let id, category: String
    public let imageURL: URL?
    public let title: String
    
    public init(
        id: String,
        category: String,
        imageURL: URL?,
        title: String
    ) {
        self.id = id
        self.category = category
        self.imageURL = imageURL
        self.title = title
    }
}
