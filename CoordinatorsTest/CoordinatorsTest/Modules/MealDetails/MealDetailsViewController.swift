//
//  MealDetailsViewController.swift
//  CoordinatorsTest
//
//  Created by Dmitriy Yurchenko on 03.02.2022.
//

import UIKit
import Domain
import Combine

final class MealDetailsViewController: BaseViewController {
    @IBOutlet private weak var mealImageView: UIImageView!
    @IBOutlet private weak var mealTitleLabel: UILabel!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var tagsLabel: UILabel!
    @IBOutlet private weak var ingredientsLabel: UILabel!
    @IBOutlet private weak var linkButton: UIButton!
    
    private let viewModel: MealDetailsViewModelProtocol
    private var cancellableSet: Set<AnyCancellable> = []
    
    init(viewModel: MealDetailsViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: "MealDetailsViewController", bundle: .main)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(closeAction)
        )
        
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
        tagsLabel.text = details.tags
        ingredientsLabel.text = details.ingredients.map {
            "\($0.title) - \($0.measure)"
        }.joined(separator: "\n")
        linkButton.setTitle(details.link?.absoluteString, for: .normal)
        categoryLabel.text = details.category
    }
    
    @objc private func closeAction() {
        viewModel.close()
    }
}
