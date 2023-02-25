//
//  MealsCategoriesAssembler.swift
//  CoordinatorsTest
//
//  Created by Dmytro Yurchenko on 03.02.2022.
//

import Domain
import UIKit

protocol MealsCategoriesAssembable {
    func assemble() -> (UIViewController, MealsCategoriesOutput)
}

final class MealsCategoriesAssembler: MealsCategoriesAssembable {
    private let getMealsCategoriesUseCase: GetMealCategoriesUseCase
    private let getMealCategoriesBySearchQueryUseCase: GetMealCategoriesBySearchQueryUseCaseProtocol
    
    init(getMealsCategoriesUseCase: GetMealCategoriesUseCase,
         getMealCategoriesBySearchQueryUseCase: GetMealCategoriesBySearchQueryUseCaseProtocol) {
        self.getMealsCategoriesUseCase = getMealsCategoriesUseCase
        self.getMealCategoriesBySearchQueryUseCase = getMealCategoriesBySearchQueryUseCase
    }
    
    func assemble() -> (UIViewController, MealsCategoriesOutput) {
        let viewModel = MealsCategoriesViewModel(
            getMealsCategoriesUseCase: getMealsCategoriesUseCase,
            getMealCategoriesBySearchQueryUseCase: getMealCategoriesBySearchQueryUseCase
        )
        let viewController = MealsCategoriesViewController(viewModel: viewModel)
        
        return (viewController, viewModel)
    }
}
