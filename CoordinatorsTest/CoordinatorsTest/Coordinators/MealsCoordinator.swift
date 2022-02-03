//
//  MealsCoordinator.swift
//  CoordinatorsTest
//
//  Created by Dmytro Yurchenko on 03.02.2022.
//

import UIKit

final class MealsCoordinator: BaseCoordinator {
    private let mealsCategoriesAssembler: MealsCategoriesAssembable
    private let mealsAssembler: MealsAssembable
    
    init(navigationController: UINavigationController,
         mealsCategoriesAssembler: MealsCategoriesAssembable,
         mealsAssembler: MealsAssembable) {
        
        self.mealsCategoriesAssembler = mealsCategoriesAssembler
        self.mealsAssembler = mealsAssembler
        
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        let (vc, output) = mealsCategoriesAssembler.assemble()
        
        output.onSelectCategory = { [unowned self] category in
            showMeals(byCategory: category)
        }
        
        navigationController?.setViewControllers([vc], animated: false)
    }
    
    func showMeals(byCategory category: String) {
        let (vc, _) = mealsAssembler.assemble(with: category)
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
