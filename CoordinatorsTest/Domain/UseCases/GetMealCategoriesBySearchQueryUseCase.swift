//
//  GetMealCategoriesBySearchQueryUseCase.swift
//  Domain
//
//  Created by Dmitriy Yurchenko on 26.02.2023.
//

import Foundation
import Combine

public protocol GetMealCategoriesBySearchQueryUseCaseProtocol {
    func execute(for query: String) -> AnyPublisher<[MealCategory], Error>
}

public final class GetMealCategoriesBySearchQueryUseCase: GetMealCategoriesBySearchQueryUseCaseProtocol {
    let mealCategoriesRepository: MealCategoriesRepository
    
    public init(mealCategoriesRepository: MealCategoriesRepository) {
        self.mealCategoriesRepository = mealCategoriesRepository
    }
    
    public func execute(for query: String) -> AnyPublisher<[MealCategory], Error> {
        mealCategoriesRepository.getCategories(byTitle: query)
    }
}
