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
    var isSearchAvailable: Bool { get }
    var categoriesPublisher: AnyPublisher<[MealCategory], Never> { get }
    
    func viewDidLoad()
    func selectCategory(_ category: String)
    func search(query: String)
}

final class MealsCategoriesViewModel: BaseViewModel, MealsCategoriesViewModelProtocol, MealsCategoriesOutput {
    private let categoriesSubject: CurrentValueSubject<[MealCategory], Never> = .init([])
    private let getMealsCategoriesUseCase: GetMealCategoriesUseCase
    private let getMealCategoriesBySearchQueryUseCase: GetMealCategoriesBySearchQueryUseCaseProtocol
    
    var onFinish: (() -> Void)?
    var onSelectCategory: ((String) -> Void)?
    let isSearchAvailable: Bool
    var categoriesPublisher: AnyPublisher<[MealCategory], Never> {
        categoriesSubject.eraseToAnyPublisher()
    }
    
    init(isSearchAvailable: Bool,
         getMealsCategoriesUseCase: GetMealCategoriesUseCase,
         getMealCategoriesBySearchQueryUseCase: GetMealCategoriesBySearchQueryUseCaseProtocol
    ) {
        self.isSearchAvailable = isSearchAvailable
        self.getMealsCategoriesUseCase = getMealsCategoriesUseCase
        self.getMealCategoriesBySearchQueryUseCase = getMealCategoriesBySearchQueryUseCase
    }
    
    func viewDidLoad() {
        let publisher = getMealsCategoriesUseCase.execute()
        
        invokeCategories(publisher: publisher)
    }
    
    func selectCategory(_ category: String) {
        onSelectCategory?(category)
    }
    
    func search(query: String) {
        let publisher = query.isEmpty
        ? getMealsCategoriesUseCase.execute()
        : getMealCategoriesBySearchQueryUseCase.execute(for: query)
        
        invokeCategories(publisher: publisher)
    }
}

private extension MealsCategoriesViewModel {
    func invokeCategories(publisher: AnyPublisher<[MealCategory], Error>) {
        publisher
            .receive(on: OperationQueue.main)
            .sink(receiveCompletion: { [unowned self] completion in
                guard case .failure(let error) = completion
                else { return }
                
                self.error = error
                
            }, receiveValue: { [unowned self] categories in
                self.categoriesSubject.send(categories)
            })
            .store(in: &cancellableSet)
    }
}
