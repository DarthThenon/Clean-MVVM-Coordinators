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
    
    func save<DomainModel: EntityMappable>(models: [DomainModel]) {
        databaseService.write { moc in
            let entities = models.map {
                $0.toEntity(in: moc)
            }
            
            print("❇️ Saved \(entities.count) \(type(of: models)) entities to the database")
        }
    }
}

extension LocalMealsRepository: MealCategoriesRepository {
    public var isSearchCategoriesByTitleEnabled: Bool {
        true
    }
    
    public func getCategories() -> AnyPublisher<[MealCategory], Error> {
        getCategories(with: nil)
    }
    
    public func getCategories(byTitle title: String) -> AnyPublisher<[MealCategory], Error> {
        getCategories(with: NSPredicate(format: "title CONTAINS[c] %@", title))
    }
    
    private func getCategories(with predicate: NSPredicate?) -> AnyPublisher<[MealCategory], Error> {
        Future { [weak self] promise in
            self?.databaseService.readInBackground { context in
                let request = MealCategoryEntity.fetchRequest()
                let sortDescriptor = NSSortDescriptor(keyPath: \MealCategoryEntity.title, ascending: true)
                
                request.predicate = predicate
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
}

extension LocalMealsRepository: MealsByCategoryRepository {
    public func getMeals(by category: String) -> AnyPublisher<[Meal], Error> {
        Future { [weak self] promise in
            self?.databaseService.readInBackground { context in
                let request = MealEntity.fetchRequest()
                let predicate = NSPredicate(format: "category == %@", category)
                let sortDescriptor = NSSortDescriptor(
                    keyPath: \MealEntity.title,
                    ascending: true
                )
                
                request.predicate = predicate
                request.sortDescriptors = [sortDescriptor]
                
                do {
                    let result = try context.fetch(request)
                    let meals = result.compactMap { $0.toDomainModel() }
                    
                    promise(.success(meals))
                    
                    print("❇️ Fetched \(meals.count) meals from the database")
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
