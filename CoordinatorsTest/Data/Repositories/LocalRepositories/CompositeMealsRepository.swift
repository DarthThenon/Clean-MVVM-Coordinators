//
//  CompositeMealsRepository.swift
//  Data
//
//  Created by Dmitriy Yurchenko on 25.02.2023.
//

import Foundation
import Combine
import Domain

public final class CompositeMealsRepository {
    private let localRepository: LocalMealsRepository
    private let networkRepository: NetworkMealsRepository
    
    public init(localRepository: LocalMealsRepository, networkRepository: NetworkMealsRepository) {
        self.localRepository = localRepository
        self.networkRepository = networkRepository
    }
}

extension CompositeMealsRepository: MealCategoriesRepository {
    public func getCategories() -> AnyPublisher<[MealCategory], Error> {
        let localPublisher = localRepository.getCategories()
        let networkPublisher = networkRepository.getCategories()
            .flatMap { [unowned localRepository] categories in
                localRepository.save(categories: categories)
                return localRepository.getCategories()
            }.eraseToAnyPublisher()
        
        return localPublisher
            .prefix(untilOutputFrom: networkPublisher)
            .merge(with: networkPublisher)
            .eraseToAnyPublisher()
    }
}
