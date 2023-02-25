//
//  BaseTableViewController.swift
//  CoordinatorsTest
//
//  Created by Dmitriy Yurchenko on 28.01.2023.
//

import UIKit
import Combine

class BaseTableViewController: UITableViewController {
    private(set) var errorPublisher: AnyPublisher<Error, Never>
    
    var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        errorPublisher = PassthroughSubject<Error, Never>().eraseToAnyPublisher()
        
        super.init(style: .plain)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        printDeinit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorPublisher.sink { [unowned self] error in
            showAlert(error: error.localizedDescription)
        }
        .store(in: &cancellableSet)
    }
    
    func onError() {}
}

private extension BaseTableViewController {
    func showAlert(error: String) {
        let alert = UIAlertController(
            title: error,
            message: nil,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
            onError()
        }
        
        alert.addAction(okAction)
        
        showDetailViewController(alert, sender: self)
    }
}
