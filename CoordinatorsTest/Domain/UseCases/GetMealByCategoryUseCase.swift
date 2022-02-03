//
//  GetMealsByCategoryUseCase.swift
//  Domain
//
//  Created by Dmytro Yurchenko on 03.02.2022.
//

import Foundation
import Combine

public protocol GetMealsByCategoryUseCase {
    func execute(from category: String) -> AnyPublisher<[Meal], Error>
}

public final class GetMealsByCategoryUseCaseImp: GetMealsByCategoryUseCase {
    let repository: MealsByCategoryRepository
    
    public init(mealsByCategoryRepository: MealsByCategoryRepository) {
        self.repository = mealsByCategoryRepository
    }
    
    public func execute(from category: String) -> AnyPublisher<[Meal], Error> {
        repository.getMeals(by: category)
    }
}
