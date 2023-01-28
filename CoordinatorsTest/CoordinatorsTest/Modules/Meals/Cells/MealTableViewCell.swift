//
//  MealTableViewCell.swift
//  CoordinatorsTest
//
//  Created by Dmytro Yurchenko on 03.02.2022.
//

import UIKit
import Combine

final class MealTableViewCell: UITableViewCell {
    @IBOutlet private weak var mealImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    private var cancellable: AnyCancellable?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        mealImageView.image = nil
        titleLabel.text = ""
    }
    
    func setup(with viewModel: MealCellViewModel) {
        titleLabel.text = viewModel.title
        cancellable = mealImageView.fetchImage(from: viewModel.imageUrl)
    }
    
    func cancelPrefetching() {
        cancellable?.cancel()
        cancellable = nil
    }
}

struct MealCellViewModel {
    let imageUrl: URL?
    let title: String
}
