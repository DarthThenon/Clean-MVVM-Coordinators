//
//  BaseNavigationController.swift
//  CoordinatorsTest
//
//  Created by Dmitriy Yurchenko on 26.02.2023.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavBarAppearance()
    }
}

private extension BaseNavigationController {
    func configureNavBarAppearance() {
        let appearance = UINavigationBarAppearance()
        
        appearance.configureWithDefaultBackground()
        
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
}
