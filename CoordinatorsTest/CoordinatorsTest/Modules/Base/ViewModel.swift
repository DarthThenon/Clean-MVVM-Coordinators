//
//  ViewModel.swift
//  CoordinatorsTest
//
//  Created by Dmitriy Yurchenko on 28.01.2023.
//

import Foundation
import Combine

protocol ViewModel: AnyObject {
    var errorPublisher: AnyPublisher<Error, Never> { get }
    
    func viewDidLoad()
}

extension ViewModel {
    func viewDidLoad() {}
}

class BaseViewModel: ObservableObject {
    @Published var error: Error?
    
    var errorPublisher: AnyPublisher<Error, Never> {
        $error
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }
}
