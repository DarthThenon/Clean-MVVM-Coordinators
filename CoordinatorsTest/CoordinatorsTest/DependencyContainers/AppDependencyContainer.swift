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
        let mealCategoriesRepository = MealsRepositoryImpl(networkRepository: networkRepository)
        let getMealCategoriesUseCase = GetMealCategoriesUseCaseImp(mealCategoriesRepository: mealCategoriesRepository)
        let getMealsByCategoryUseCase = GetMealsByCategoryUseCaseImp(mealsByCategoryRepository: mealCategoriesRepository)
        
        return MealDependencyContainer(getMealsCategoriesUseCase: getMealCategoriesUseCase,
                                       getMealsByCategoryUseCase: getMealsByCategoryUseCase)
    }
}
