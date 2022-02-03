//
//  MealsCategoriesViewController.swift
//  CoordinatorsTest
//
//  Created by Dmytro Yurchenko on 03.02.2022.
//

import UIKit
import Domain
import Combine

final class MealsCategoriesViewController: UITableViewController {
    private let viewModel: MealsCategoriesViewModel
    private var categories: [MealCategory] = []
    private var cancellable: AnyCancellable?
    
    init(viewModel: MealsCategoriesViewModel) {
        self.viewModel = viewModel
        
        super.init(style: .plain)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        navigationItem.title = "Categories"
        
        tableView.register(UINib(nibName: "MealCategoryTableViewCell", bundle: .main), forCellReuseIdentifier: "MealCategoryTableViewCell")
        
        cancellable = viewModel.categoriesPublisher
            .sink(receiveValue: { [unowned self] categories in
                self.categories = categories
                self.tableView.reloadData()
            })
        
        viewModel.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = categories[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealCategoryTableViewCell", for: indexPath) as! MealCategoryTableViewCell
        
        cell.selectionStyle = .gray
        cell.setup(with: MealCategoryCellViewModel(category: category))
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let category = categories[indexPath.row]
        
        viewModel.selectCategory(category.title)
    }
}

private extension MealCategoryCellViewModel {
    init(category: MealCategory) {
        title = category.title
        description = category.description
        imageUrl = category.imageURL
    }
}
