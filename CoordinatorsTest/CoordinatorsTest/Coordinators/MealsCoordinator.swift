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
    private let mealDetailsCoordinatorFactory: (String) -> Coordinator
    
    init(navigationController: UINavigationController,
         mealsCategoriesAssembler: MealsCategoriesAssembable,
         mealsAssembler: MealsAssembable,
         mealDetailsCoordinatorFactory: @escaping (String) -> Coordinator) {
        
        self.mealsCategoriesAssembler = mealsCategoriesAssembler
        self.mealsAssembler = mealsAssembler
        self.mealDetailsCoordinatorFactory = mealDetailsCoordinatorFactory
        
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
        let (vc, output) = mealsAssembler.assemble(with: category)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showMealDetails(mealID: String) {
        let coordinator = mealDetailsCoordinatorFactory(mealID)
        
        addChild(coordinator, animated: true)
    }
}
