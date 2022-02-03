//
//  MealsAssembable.swift
//  CoordinatorsTest
//
//  Created by Dmytro Yurchenko on 03.02.2022.
//

import UIKit
import Domain

protocol MealsAssembable {
    func assemble(with category: String) -> (UIViewController, MealsOutput)
}

final class MealsAssembler: MealsAssembable {
    private let getMealsByCategoryUseCase: GetMealsByCategoryUseCase
    
    init(getMealsByCategoryUseCase: GetMealsByCategoryUseCase) {
        self.getMealsByCategoryUseCase = getMealsByCategoryUseCase
    }
    
    func assemble(with category: String) -> (UIViewController, MealsOutput) {
        let viewModel = MealsViewModelImp(category: category,
                                          getMealByCategoryUseCase: getMealsByCategoryUseCase)
        let viewController = MealsViewController(viewModel: viewModel)
        
        return (viewController, viewModel)
    }
}
