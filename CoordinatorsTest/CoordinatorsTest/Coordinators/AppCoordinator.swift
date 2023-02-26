//
//  AppCoordinator.swift
//  CoordinatorsTest
//
//  Created by Dmytro Yurchenko on 03.02.2022.
//

import UIKit

class BaseCoordinator: Coordinator {
    var navigationController: UINavigationController?
    var childs: [Coordinator] = []
    var parent: WeakRefCoordinatorWrapper?
    
    init(navigationController: BaseNavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {}
}

final class AppCoordinator: BaseCoordinator {
    init() {
        super.init(navigationController: nil)
    }
}
