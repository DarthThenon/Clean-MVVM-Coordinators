//
//  MealsCategoriesViewModel.swift
//  CoordinatorsTest
//
//  Created by Dmytro Yurchenko on 03.02.2022.
//

import Foundation
import Domain
import Combine

protocol MealsCategoriesViewModel {
    var categoriesPublisher: AnyPublisher<[MealCategory], Never> { get }
    
    func viewDidLoad()
    func selectCategory(_ category: String)
}

final class MealsCategoriesViewModelImpl: MealsCategoriesViewModel, MealsCategoriesOutput {
    private let categoriesSubject: CurrentValueSubject<[MealCategory], Never> = .init([])
    private let getMealsCategoriesUseCase: GetMealCategoriesUseCase
    private var cancellable: AnyCancellable?
    
    var onFinish: (() -> Void)?
    var onSelectCategory: ((String) -> Void)?
    var categoriesPublisher: AnyPublisher<[MealCategory], Never> {
        categoriesSubject.eraseToAnyPublisher()
    }
    
    init(getMealsCategoriesUseCase: GetMealCategoriesUseCase) {
        self.getMealsCategoriesUseCase = getMealsCategoriesUseCase
    }
    
    func viewDidLoad() {
        cancellable = getMealsCategoriesUseCase.execute()
            .receive(on: OperationQueue.main)
            .sink(receiveCompletion: { completion in
                guard case .failure(let error) = completion
                else { return }
                
                assertionFailure(error.localizedDescription)
                
            }, receiveValue: { [unowned self] categories in
                self.categoriesSubject.send(categories)
            })
    }
    
    func selectCategory(_ category: String) {
        onSelectCategory?(category)
    }
}
