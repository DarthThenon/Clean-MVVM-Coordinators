//
//  AppDependencyContainer.swift
//  CoordinatorsTest
//
//  Created by Dmytro Yurchenko on 03.02.2022.
//

import Foundation
import Data
import Domain

final class AppDependencyContainer {
    private let networkRepository: NetworkRepository
    
    init() {
        networkRepository = RealNetworkRepository()
    }
    
    func createMealDependencyContainer() -> MealDependencyContainer {
        let mealsRepository = MealsRepositoryImpl(networkRepository: networkRepository)
        let getMealCategoriesUseCase = GetMealCategoriesUseCaseImp(mealCategoriesRepository: mealsRepository)
        let getMealsByCategoryUseCase = GetMealsByCategoryUseCaseImp(mealsByCategoryRepository: mealsRepository)
        let getMealDetailsByIdUseCase = GetMealDetailsByIdUseCaseImp(repository: mealsRepository)
        
        return MealDependencyContainer(getMealsCategoriesUseCase: getMealCategoriesUseCase,
                                       getMealsByCategoryUseCase: getMealsByCategoryUseCase,
                                       getMealDetailsByIdUseCase: getMealDetailsByIdUseCase)
    }
}
