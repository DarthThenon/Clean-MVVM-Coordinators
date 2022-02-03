//
//  MealsCategoriesAssembler.swift
//  CoordinatorsTest
//
//  Created by Dmytro Yurchenko on 03.02.2022.
//

import Domain
import UIKit

protocol ModuleOutput {
    var onFinish: (() -> Void)? { get set }
}

protocol MealsCategoriesOutput: ModuleOutput {
}

protocol MealsCategoriesAssembable {
    func assemble() -> (UIViewController, MealsCategoriesOutput)
}

final class MealsCategoriesAssembler: MealsCategoriesAssembable {
    private let getMealsCategoriesUseCase: GetMealCategoriesUseCase
    
    init(getMealsCategoriesUseCase: GetMealCategoriesUseCase) {
        self.getMealsCategoriesUseCase = getMealsCategoriesUseCase
    }
    
    func assemble() -> (UIViewController, MealsCategoriesOutput) {
        let viewModel = MealsCategoriesViewModelImpl(getMealsCategoriesUseCase: getMealsCategoriesUseCase)
        let viewController = MealsCategoriesViewController(viewModel: viewModel)
        
        return (viewController, viewModel)
    }
}
