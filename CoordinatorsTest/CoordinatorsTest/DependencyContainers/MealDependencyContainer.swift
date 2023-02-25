//
//  MealDependencyContainer.swift
//  CoordinatorsTest
//
//  Created by Dmytro Yurchenko on 03.02.2022.
//

import Foundation
import Domain

struct MealDependencyContainer {
    private let getMealsCategoriesUseCase: GetMealCategoriesUseCase
    private let getMealsByCategoryUseCase: GetMealsByCategoryUseCase
    private let getMealDetailsByIdUseCase: GetMealDetailsByIdUseCase
    private let getMealCategoriesBySearchQueryUseCase: GetMealCategoriesBySearchQueryUseCaseProtocol
    private let isSearchCategoriesAvailable: Bool
    
    init(isSearchCategoriesAvailable: Bool,
         getMealsCategoriesUseCase: GetMealCategoriesUseCase,
         getMealsByCategoryUseCase: GetMealsByCategoryUseCase,
         getMealDetailsByIdUseCase: GetMealDetailsByIdUseCase,
         getMealCategoriesBySearchQueryUseCase: GetMealCategoriesBySearchQueryUseCaseProtocol
    ) {
        self.isSearchCategoriesAvailable = isSearchCategoriesAvailable
        self.getMealsCategoriesUseCase = getMealsCategoriesUseCase
        self.getMealsByCategoryUseCase = getMealsByCategoryUseCase
        self.getMealDetailsByIdUseCase = getMealDetailsByIdUseCase
        self.getMealCategoriesBySearchQueryUseCase = getMealCategoriesBySearchQueryUseCase
    }
    
    func createMealsCoordinator() -> MealsCoordinator {
        let categoriesAssembler = MealsCategoriesAssembler(
            isSearchAvailable: isSearchCategoriesAvailable,
            getMealsCategoriesUseCase: getMealsCategoriesUseCase,
            getMealCategoriesBySearchQueryUseCase: getMealCategoriesBySearchQueryUseCase
        )
        let mealsAssember = MealsAssembler(getMealsByCategoryUseCase: getMealsByCategoryUseCase)
        let coordinator = MealsCoordinator(
            navigationController: .init(),
            mealsCategoriesAssembler: categoriesAssembler,
            mealsAssembler: mealsAssember,
            mealDetailsCoordinatorFactory: { mealID in
                self.createMealDetailsCoordinator(id: mealID)
            })
        
        return coordinator
    }
    
    func createMealDetailsCoordinator(id: String) -> MealDetailsCoordinator {
        let mealDetailsAssembler = MealDetailsAssembler(getMealDetailsByIdUseCase: getMealDetailsByIdUseCase)
        
        return MealDetailsCoordinator(mealID: id,
                                      mealDetailsAssembler: mealDetailsAssembler,
                                      navigationController: .init())
    }
    
}
