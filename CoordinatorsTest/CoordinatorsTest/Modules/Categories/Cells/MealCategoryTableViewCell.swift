//
//  MealCategoryTableViewCell.swift
//  CoordinatorsTest
//
//  Created by Dmytro Yurchenko on 03.02.2022.
//

import UIKit
import Combine

final class MealCategoryTableViewCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    
    private var cancellable: AnyCancellable?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = ""
        descriptionLabel.text = ""
        iconImageView.image = nil
        
        cancellable?.cancel()
    }
    
    func setup(with viewModel: MealCategoryCellViewModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        cancellable = iconImageView.fetchImage(from: viewModel.imageUrl)
    }
}

struct MealCategoryCellViewModel {
    let title, description: String
    let imageUrl: URL?
}
