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
    
    init(getMealsCategoriesUseCase: GetMealCategoriesUseCase) {
        self.getMealsCategoriesUseCase = getMealsCategoriesUseCase
    }
    
    func createMealsCoordinator() -> MealsCoordinator {
        let assembler = MealsCategoriesAssembler(getMealsCategoriesUseCase: getMealsCategoriesUseCase)
        
        return MealsCoordinator(navigationController: .init(),
                                mealsCategoriesAssembler: assembler)
    }
}
