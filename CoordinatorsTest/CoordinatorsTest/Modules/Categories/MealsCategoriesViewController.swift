//
//  MealsCategoriesViewController.swift
//  CoordinatorsTest
//
//  Created by Dmytro Yurchenko on 03.02.2022.
//

import UIKit
import Domain
import Combine

final class MealsCategoriesViewController: UITableViewController, CustomViewControllerPresentable {
    var transitionDelegate: UIViewControllerTransitioningDelegate?
    
    private typealias DataSource = UITableViewDiffableDataSource<Int, MealCategory>
    
    private let viewModel: MealsCategoriesViewModelProtocol
    private var categories: [MealCategory] = []
    private var cancellable: AnyCancellable?
    private lazy var dataSource: DataSource = createDataSource()
    
    init(viewModel: MealsCategoriesViewModelProtocol) {
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
                self.reloadTable()
            })
        
        viewModel.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        let vc = UIViewController()
//        
//        vc.view.backgroundColor = .purple
//        
//        present(vc, duration: 10, withAnimationType: ViewControllerRoundedPresentingAnimation.self)
    }
    
    private func createDataSource() -> DataSource {
        DataSource(tableView: tableView) { tableView, indexPath, mealCategory in
            let cell = tableView.dequeueReusableCell(withIdentifier: "MealCategoryTableViewCell", for: indexPath) as! MealCategoryTableViewCell
            
            cell.selectionStyle = .gray
            cell.setup(with: MealCategoryCellViewModel(category: mealCategory))
            
            return cell
        }
    }
    
    private func reloadTable() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, MealCategory>()
        
        snapshot.appendSections([0])
        snapshot.appendItems(categories)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension MealsCategoriesViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectCategory(categories[indexPath.row].title)
    }
}

private extension MealCategoryCellViewModel {
    init(category: MealCategory) {
        title = category.title
        description = category.description
        imageUrl = category.imageURL
    }
}
