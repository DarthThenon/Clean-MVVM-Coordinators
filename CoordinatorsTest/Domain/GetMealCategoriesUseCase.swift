//
//  GetMealCategoriesUseCase.swift
//  Domain
//
//  Created by Dmytro Yurchenko on 03.02.2022.
//

import Foundation
import Combine

public protocol GetMealCategoriesUseCase {
    func execute() -> AnyPublisher<[MealCategory], Error>
}

public final class GetMealCategoriesUseCaseImp: GetMealCategoriesUseCase {
    let mealCategoriesRepository: MealCategoriesRepository
    
    public init(mealCategoriesRepository: MealCategoriesRepository) {
        self.mealCategoriesRepository = mealCategoriesRepository
    }
    
    public func execute() -> AnyPublisher<[MealCategory], Error> {
        mealCategoriesRepository.getCategories()
    }
}
