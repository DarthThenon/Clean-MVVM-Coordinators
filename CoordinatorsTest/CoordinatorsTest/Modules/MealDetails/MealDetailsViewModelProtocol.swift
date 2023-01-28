//
//  MealDetailsViewModelProtocol.swift
//  CoordinatorsTest
//
//  Created by Dmitriy Yurchenko on 03.02.2022.
//

import Foundation
import Combine
import Domain

protocol MealDetailsViewModelProtocol {
    var mealDetailsPublisher: AnyPublisher<MealDetails, Never> { get }
    
    func viewDidLoad()
    func close()
}

final class MealDetailsViewModel: MealDetailsViewModelProtocol, MealDetailsOutput {
    private let getMealDetailsByIdUseCase: GetMealDetailsByIdUseCase
    private let mealID: String
    private let mealDetailsSubject: PassthroughSubject<MealDetails, Never> = .init()
    private var cancellable: AnyCancellable?
    
    var onFinish: (() -> Void)?
    
    var mealDetailsPublisher: AnyPublisher<MealDetails, Never> {
        mealDetailsSubject.eraseToAnyPublisher()
    }
    
    
    init(mealID: String, getMealDetailsByIdUseCase: GetMealDetailsByIdUseCase) {
        self.mealID = mealID
        self.getMealDetailsByIdUseCase = getMealDetailsByIdUseCase
    }
    
    func viewDidLoad() {
        cancellable = getMealDetailsByIdUseCase.execute(with: mealID)
            .receive(on: OperationQueue.main)
            .sink(receiveCompletion: { completion in
                guard case .failure(let error) = completion
                else { return }
                
                assertionFailure(error.localizedDescription)
                
            }, receiveValue: { [unowned self] mealDetails in
                mealDetailsSubject.send(mealDetails)
            })
    }
    
    func close() {
        onFinish?()
    }
}
 
