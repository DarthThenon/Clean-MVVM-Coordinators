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
        let mealCategoriesRepository = MealCategoriesRepositoryImpl(networkRepository: networkRepository)
        let getMealCategoriesUseCase = GetMealCategoriesUseCaseImp(mealCategoriesRepository: mealCategoriesRepository)
        
        return MealDependencyContainer(getMealsCategoriesUseCase: getMealCategoriesUseCase)
    }
}
