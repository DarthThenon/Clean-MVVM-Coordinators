//
//  LocalMealsRepository.swift
//  Data
//
//  Created by Dmitriy Yurchenko on 25.02.2023.
//

import Foundation
import Domain
import Combine

public final class LocalMealsRepository {
    private let databaseService: DatabaseServiceProtocol
    
    public init(databaseService: DatabaseServiceProtocol) {
        self.databaseService = databaseService
    }
}

extension LocalMealsRepository: MealCategoriesRepository {
    public func getCategories() -> AnyPublisher<[MealCategory], Error> {
        Future { [weak self] promise in
            self?.databaseService.readInBackground { context in
                let request = MealCategoryEntity.fetchRequest()
                let sortDescriptor = NSSortDescriptor(keyPath: \MealCategoryEntity.title, ascending: true)
                
                request.sortDescriptors = [sortDescriptor]
                
                do {
                    let result = try context.fetch(request)
                    let mealCategories = result.compactMap { $0.toDomainModel() }
                    
                    promise(.success(mealCategories))
                    
                    print("❇️ Fetched \(mealCategories.count) meal categories from the database")
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func save(categories: [MealCategory]) {
        databaseService.write { moc in
            let entities = categories.map {
                $0.toEntity(inMoc: moc)
            }
            
            print("❇️ Saved \(entities.count) meal category entities to the database")
        }
    }
}
