//
//  MealsCoordinator.swift
//  CoordinatorsTest
//
//  Created by Dmytro Yurchenko on 03.02.2022.
//

import UIKit

final class MealsCoordinator: Coordinator {
    private let mealsCategoriesAssembler: MealsCategoriesAssembable
    let navigationController: UINavigationController
    var childs: [Coordinator] = []
    var parent: WeakRefCoordinatorWrapper?
    
    init(navigationController: UINavigationController,
         mealsCategoriesAssembler: MealsCategoriesAssembable) {
        
        self.navigationController = navigationController
        self.mealsCategoriesAssembler = mealsCategoriesAssembler
    }
    
    func start() {
        let (vc, _) = mealsCategoriesAssembler.assemble()
        
        navigationController.setViewControllers([vc], animated: false)
    }
}
