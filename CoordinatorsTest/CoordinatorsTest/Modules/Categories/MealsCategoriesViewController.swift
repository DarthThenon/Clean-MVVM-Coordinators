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

        prepareUI()
        
        cancellable = viewModel.categoriesPublisher
            .sink(receiveValue: { [unowned self] categories in
                self.categories = categories
                self.reloadTable()
            })
        
        viewModel.viewDidLoad()
    }
}

private extension MealsCategoriesViewController {
    func prepareUI() {
        view.backgroundColor = .white
        
        navigationItem.title = "Categories"
        
        tableView.register(UINib(nibName: "MealCategoryTableViewCell", bundle: .main), forCellReuseIdentifier: "MealCategoryTableViewCell")
        tableView.keyboardDismissMode = .onDrag
        
        if viewModel.isSearchAvailable {
            addSearchBar()
        }
    }
    
    func addSearchBar() {
        let barSize = CGSize(width: view.bounds.width, height: 40)
        let searchBar = UISearchBar(frame: CGRect(origin: .zero, size: barSize))
        
        searchBar.placeholder = "Search category"
        searchBar.delegate = self
        
        tableView.tableHeaderView = searchBar
    }
    
    private func createDataSource() -> DataSource {
        DataSource(tableView: tableView) { tableView, indexPath, mealCategory in
            let cell = tableView.dequeueReusableCell(withIdentifier: "MealCategoryTableViewCell", for: indexPath) as! MealCategoryTableViewCell
            
            cell.selectionStyle = .gray
            cell.setup(with: MealCategoryCellViewModel(category: mealCategory))
            
            return cell
        }
    }
    
    func reloadTable() {
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

extension MealsCategoriesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(query: searchText)
    }
}

private extension MealCategoryCellViewModel {
    init(category: MealCategory) {
        title = category.title
        description = category.description
        imageUrl = category.imageURL
    }
}
