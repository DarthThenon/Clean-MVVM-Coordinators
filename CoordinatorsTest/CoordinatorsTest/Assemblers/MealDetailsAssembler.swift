//
//  MealDetailsAssembler.swift
//  CoordinatorsTest
//
//  Created by Dmitriy Yurchenko on 03.02.2022.
//

import UIKit
import Domain

protocol MealDetailsAssembable {
    func assemble(withMealId id: String) -> (UIViewController, MealDetailsOutput)
}

final class MealDetailsAssembler: MealDetailsAssembable {
    private let getMealDetailsByIdUseCase: GetMealDetailsByIdUseCase
    
    init(getMealDetailsByIdUseCase: GetMealDetailsByIdUseCase) {
        self.getMealDetailsByIdUseCase = getMealDetailsByIdUseCase
    }
    
    func assemble(withMealId id: String) -> (UIViewController, MealDetailsOutput) {
        let viewModel = MealDetailsViewModel(mealID: id,
                                                getMealDetailsByIdUseCase: getMealDetailsByIdUseCase)
        let viewController = MealDetailsViewController(viewModel: viewModel)
        
        return (viewController, viewModel)
    }
}
