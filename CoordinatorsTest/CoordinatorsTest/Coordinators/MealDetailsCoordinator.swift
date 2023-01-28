//
//  MealDetailsCoordinator.swift
//  CoordinatorsTest
//
//  Created by Dmitriy Yurchenko on 03.02.2022.
//

import UIKit

final class MealDetailsCoordinator: BaseCoordinator {
    private let mealID: String
    private let mealDetailsAssembler: MealDetailsAssembable
    
    init(mealID: String,
         mealDetailsAssembler: MealDetailsAssembable,
         navigationController: UINavigationController?) {
        self.mealID = mealID
        self.mealDetailsAssembler = mealDetailsAssembler
        
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        let (vc, output) = mealDetailsAssembler.assemble(withMealId: mealID)
        
        output.onFinish = { [unowned self] in
            removeFromParent()
        }
        
        navigationController?.setViewControllers([vc], animated: false)
    }
}
