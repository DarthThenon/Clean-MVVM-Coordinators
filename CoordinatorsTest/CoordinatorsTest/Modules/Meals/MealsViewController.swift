//
//  MealsViewController.swift
//  CoordinatorsTest
//
//  Created by Dmytro Yurchenko on 03.02.2022.
//

import UIKit
import Combine
import Domain

final class MealsViewController: BaseTableViewController {
    private let viewModel: MealsViewModelProtocol
    private var meals: [Meal] = []
    
    override var errorPublisher: AnyPublisher<Error, Never> {
        viewModel.errorPublisher
    }
    
    init(viewModel: MealsViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        navigationItem.title = viewModel.title
        
        tableView.register(UINib(nibName: "MealTableViewCell", bundle: .main), forCellReuseIdentifier: "MealTableViewCell")
        
        viewModel.mealsPublisher
            .sink { [unowned self] meals in
                self.meals = meals
                self.tableView.reloadData()
            }
            .store(in: &cancellableSet)
        
        viewModel.viewDidLoad()
    }
    
    override func onError() {
        viewModel.goBack()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let meal = meals[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealTableViewCell", for: indexPath) as! MealTableViewCell
        
        cell.setup(with: MealCellViewModel(from: meal))
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        viewModel.selectMeal(with: meals[indexPath.row].id)
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? MealTableViewCell
        else { return }
        
        cell.cancelPrefetching()
    }
}

private extension MealCellViewModel {
    init(from meal: Meal) {
        title = meal.title
        imageUrl = meal.imageURL
    }
}
