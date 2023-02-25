//
//  MealCategoriesRepository.swift
//  Domain
//
//  Created by Dmytro Yurchenko on 03.02.2022.
//

import Foundation
import Combine

public protocol MealCategoriesRepository {
    var isSearchCategoriesByTitleEnabled: Bool { get }
    
    func getCategories() -> AnyPublisher<[MealCategory], Error>
    func getCategories(byTitle title: String) -> AnyPublisher<[MealCategory], Error>
}
