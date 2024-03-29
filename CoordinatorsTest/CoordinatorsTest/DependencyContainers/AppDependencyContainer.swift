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
    private let databaseService: DatabaseServiceProtocol
    
    init() {
        networkRepository = RealNetworkRepository()
        databaseService = DatabaseService()
    }
    
    func createMealDependencyContainer() -> MealDependencyContainer {
        let networkMealsRepository = NetworkMealsRepository(networkRepository: networkRepository)
        let localMealsRepository = LocalMealsRepository(databaseService: databaseService)
        let mealsRepository = CompositeMealsRepository(
            localRepository: localMealsRepository,
            networkRepository: networkMealsRepository
        )
        let getMealCategoriesUseCase = GetMealCategoriesUseCaseImp(mealCategoriesRepository: mealsRepository)
        let getMealsByCategoryUseCase = GetMealsByCategoryUseCaseImp(mealsByCategoryRepository: mealsRepository)
        let getMealDetailsByIdUseCase = GetMealDetailsByIdUseCaseImp(repository: networkMealsRepository)
        let getMealCategoriesBySearchQueryUseCase = GetMealCategoriesBySearchQueryUseCase(
            mealCategoriesRepository: mealsRepository
        )
        
        return MealDependencyContainer(
            isSearchCategoriesAvailable: mealsRepository.isSearchCategoriesByTitleEnabled,
            getMealsCategoriesUseCase: getMealCategoriesUseCase,
            getMealsByCategoryUseCase: getMealsByCategoryUseCase,
            getMealDetailsByIdUseCase: getMealDetailsByIdUseCase,
            getMealCategoriesBySearchQueryUseCase: getMealCategoriesBySearchQueryUseCase
        )
    }
}
