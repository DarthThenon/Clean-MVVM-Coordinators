//
//  GetMealDetailsByIdUseCase.swift
//  Domain
//
//  Created by Dmitriy Yurchenko on 03.02.2022.
//

import Foundation
import Combine

public protocol GetMealDetailsByIdUseCase {
    func execute(with id: String) -> AnyPublisher<MealDetails, Error>
}

public final class GetMealDetailsByIdUseCaseImp: GetMealDetailsByIdUseCase {
    let repository: MealDetailsRepository
    
    public init(repository: MealDetailsRepository) {
        self.repository = repository
    }
    
    public func execute(with id: String) -> AnyPublisher<MealDetails, Error> {
        repository.getMealDetails(by: id)
    }
}
