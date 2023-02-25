//
//  LocalMealsRepository.swift
//  Data
//
//  Created by Dmitriy Yurchenko on 25.02.2023.
//

import Foundation
import Domain
import Combine

final class LocalMealsRepository {
    private let databaseService: DatabaseServiceProtocol
    
    init(databaseService: DatabaseServiceProtocol) {
        self.databaseService = databaseService
    }
}

extension LocalMealsRepository: MealCategoriesRepository {
    func getCategories() -> AnyPublisher<[MealCategory], Error> {
        Future { [weak self] promise in
            self?.databaseService.readInBackground { context in
                let request = MealCategoryEntity.fetchRequest()
                let sortDescriptor = NSSortDescriptor(keyPath: \MealCategoryEntity.title, ascending: false)
                
                do {
                    let result = try context.fetch(request)
                    
                    promise(.success(result.compactMap { $0.toDomainModel() }))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
