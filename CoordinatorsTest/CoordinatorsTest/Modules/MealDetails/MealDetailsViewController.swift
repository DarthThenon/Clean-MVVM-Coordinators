//
//  MealDetailsViewController.swift
//  CoordinatorsTest
//
//  Created by Dmitriy Yurchenko on 03.02.2022.
//

import UIKit

final class MealDetailsViewController: UIViewController {
    private let viewModel: MealDetailsViewModel
    
    init(viewModel: MealDetailsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: "MealDetailsViewController", bundle: .main)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
