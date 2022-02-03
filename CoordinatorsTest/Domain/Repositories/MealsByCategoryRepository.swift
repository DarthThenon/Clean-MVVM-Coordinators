//
//  MealsByCategoryRepository.swift
//  Domain
//
//  Created by Dmytro Yurchenko on 03.02.2022.
//

import Foundation
import Combine

public protocol MealsByCategoryRepository {
    func getMeals(by category: String) -> AnyPublisher<[Meal], Error>
}
