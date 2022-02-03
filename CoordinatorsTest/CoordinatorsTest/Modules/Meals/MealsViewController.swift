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
        UITableViewCell()
    }
}
