//
//  MealCategoriesRepository.swift
//  Domain
//
//  Created by Dmytro Yurchenko on 03.02.2022.
//

import Foundation
import Combine

public protocol MealCategoriesRepository {
    func getCategories() -> AnyPublisher<[MealCategory], Error>
}
