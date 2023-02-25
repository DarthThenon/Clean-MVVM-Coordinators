//
//  MealsCategoriesViewModelProtocol.swift
//  CoordinatorsTest
//
//  Created by Dmytro Yurchenko on 03.02.2022.
//

import Foundation
import Domain
import Combine

protocol MealsCategoriesViewModelProtocol {
    var categoriesPublisher: AnyPublisher<[MealCategory], Never> { get }
    
    func viewDidLoad()
    func selectCategory(_ category: String)
}

final class MealsCategoriesViewModel: MealsCategoriesViewModelProtocol, MealsCategoriesOutput {
    private let categoriesSubject: CurrentValueSubject<[MealCategory], Never> = .init([])
    private let getMealsCategoriesUseCase: GetMealCategoriesUseCase
    private let getMealCategoriesBySearchQueryUseCase: GetMealCategoriesBySearchQueryUseCaseProtocol
    private var cancellable: AnyCancellable?
    
    var onFinish: (() -> Void)?
    var onSelectCategory: ((String) -> Void)?
    var categoriesPublisher: AnyPublisher<[MealCategory], Never> {
        categoriesSubject.eraseToAnyPublisher()
    }
    
    init(getMealsCategoriesUseCase: GetMealCategoriesUseCase,
         getMealCategoriesBySearchQueryUseCase: GetMealCategoriesBySearchQueryUseCaseProtocol) {
        self.getMealsCategoriesUseCase = getMealsCategoriesUseCase
        self.getMealCategoriesBySearchQueryUseCase = getMealCategoriesBySearchQueryUseCase
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
