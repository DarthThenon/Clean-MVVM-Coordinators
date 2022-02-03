//
//  MealsViewController.swift
//  CoordinatorsTest
//
//  Created by Dmytro Yurchenko on 03.02.2022.
//

import UIKit
import Combine
import Domain

final class MealsViewController: UITableViewController {
    private let viewModel: MealsViewModel
    private var cancellable: AnyCancellable?
    private var meals: [Meal] = []
    
    init(viewModel: MealsViewModel) {
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
        
        navigationItem.title = viewModel.title
        
        tableView.register(UINib(nibName: "MealTableViewCell", bundle: .main), forCellReuseIdentifier: "MealTableViewCell")
        
        cancellable = viewModel.mealsPublisher
            .sink { [unowned self] meals in
                self.meals = meals
                self.tableView.reloadData()
            }
        
        viewModel.viewDidLoad()
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
}

private extension MealCellViewModel {
    init(from meal: Meal) {
        title = meal.title
        imageUrl = meal.imageURL
    }
}
