//
//  MealDetailsViewController.swift
//  CoordinatorsTest
//
//  Created by Dmitriy Yurchenko on 03.02.2022.
//

import UIKit
import Domain
import Combine

final class MealDetailsViewController: UIViewController {
    @IBOutlet private weak var mealImageView: UIImageView!
    @IBOutlet private weak var mealTitleLabel: UILabel!
    
    private let viewModel: MealDetailsViewModel
    private var cancellableSet: Set<AnyCancellable> = []
    
    init(viewModel: MealDetailsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: "MealDetailsViewController", bundle: .main)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close,
                                                           target: self,
                                                           action: #selector(closeAction))
        
        viewModel.mealDetailsPublisher
            .sink { [unowned self] mealDetails in
                setupUI(details: mealDetails)
            }
            .store(in: &cancellableSet)
        
        viewModel.viewDidLoad()
    }
    
    private func setupUI(details: MealDetails) {
        mealTitleLabel.text = details.title
        mealImageView.fetchImage(from: details.imageUrl)
            .flatMap { $0.store(in: &cancellableSet) }
    }
    
    @objc private func closeAction() {
        viewModel.close()
    }
}
