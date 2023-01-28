//
//  MealsViewModelProtocol.swift
//  CoordinatorsTest
//
//  Created by Dmytro Yurchenko on 03.02.2022.
//

import Foundation
import Domain
import Combine

protocol MealsViewModelProtocol: ViewModel {
    var mealsPublisher: AnyPublisher<[Meal], Never> { get }
    var title: String { get }
    
    func selectMeal(with id: String)
    func goBack()
}

final class MealsViewModel: BaseViewModel, MealsViewModelProtocol, MealsOutput {
    private let mealsSubject: CurrentValueSubject<[Meal], Never> = .init([])
    private let getMealByCategoryUseCase: GetMealsByCategoryUseCase
    private let category: String
    private var cancellable: AnyCancellable?
    
    let title: String
    
    var onFinish: (() -> Void)?
    var onShowDetails: ((String) -> Void)?
    
    var mealsPublisher: AnyPublisher<[Meal], Never> {
        mealsSubject.eraseToAnyPublisher()
    }
    
    init(category: String, getMealByCategoryUseCase: GetMealsByCategoryUseCase) {
        self.title = category
        self.getMealByCategoryUseCase = getMealByCategoryUseCase
        self.category = category
    }
    
    func viewDidLoad() {
        cancellable = getMealByCategoryUseCase.execute(from: category)
            .receive(on: OperationQueue.main)
            .sink(receiveCompletion: { [unowned self] completion in
                guard case .failure(let error) = completion
                else { return }
                
                self.error = error
            }, receiveValue: { [unowned self] meals in
                self.mealsSubject.send(meals)
            })
    }
    
    func selectMeal(with id: String) {
        onShowDetails?(id)
    }
    
    func goBack() {
        onFinish?()
    }
}
