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
    
    init(getMealsCategoriesUseCase: GetMealCategoriesUseCase,
         getMealsByCategoryUseCase: GetMealsByCategoryUseCase,
         getMealDetailsByIdUseCase: GetMealDetailsByIdUseCase) {
        self.getMealsCategoriesUseCase = getMealsCategoriesUseCase
        self.getMealsByCategoryUseCase = getMealsByCategoryUseCase
        self.getMealDetailsByIdUseCase = getMealDetailsByIdUseCase
    }
    
    func createMealsCoordinator() -> MealsCoordinator {
        let categoriesAssembler = MealsCategoriesAssembler(getMealsCategoriesUseCase: getMealsCategoriesUseCase)
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
