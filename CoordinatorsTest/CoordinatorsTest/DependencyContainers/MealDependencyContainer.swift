//
//  MealDependencyContainer.swift
//  CoordinatorsTest
//
//  Created by Dmytro Yurchenko on 03.02.2022.
//

import Foundation
import Domain

final class MealDependencyContainer {
    private let getMealsCategoriesUseCase: GetMealCategoriesUseCase
    private let getMealsByCategoryUseCase: GetMealsByCategoryUseCase
    
    init(getMealsCategoriesUseCase: GetMealCategoriesUseCase,
         getMealsByCategoryUseCase: GetMealsByCategoryUseCase) {
        self.getMealsCategoriesUseCase = getMealsCategoriesUseCase
        self.getMealsByCategoryUseCase = getMealsByCategoryUseCase
    }
    
    func createMealsCoordinator() -> MealsCoordinator {
        let categoriesAssembler = MealsCategoriesAssembler(getMealsCategoriesUseCase: getMealsCategoriesUseCase)
        let mealsAssember = MealsAssembler(getMealsByCategoryUseCase: getMealsByCategoryUseCase)
        
        return MealsCoordinator(navigationController: .init(),
                                mealsCategoriesAssembler: categoriesAssembler,
                                mealsAssembler: mealsAssember)
    }
}
