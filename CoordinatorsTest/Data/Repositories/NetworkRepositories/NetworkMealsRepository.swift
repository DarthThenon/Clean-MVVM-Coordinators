//
//  NetworkMealsRepository.swift
//  Data
//
//  Created by Dmytro Yurchenko on 03.02.2022.
//

import Foundation
import Domain
import Combine

public final class NetworkMealsRepository {
    let networkRepository: NetworkRepository
    
    public init(networkRepository: NetworkRepository) {
        self.networkRepository = networkRepository
    }
}

extension NetworkMealsRepository: MealCategoriesRepository {
    public func getCategories() -> AnyPublisher<[MealCategory], Error> {
        let url = URL(string: "https://themealdb.com/api/json/v1/1/categories.php")!
        let requestPublisher: AnyPublisher<MealCategoryContainerCodable, Error> = networkRepository.executeRequest(for: url)
         
        return requestPublisher
            .map {
                let mealCategories = $0.categories.map { $0.toDomainModel() }
                
                print("❇️ Fetched \(mealCategories.count) meal categories from the server")
                
                return mealCategories
            }
            .eraseToAnyPublisher()
    }
}

extension NetworkMealsRepository: MealsByCategoryRepository {
    public func getMeals(by category: String) -> AnyPublisher<[Meal], Error> {
        let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=\(category)")!
        let requestPublisher: AnyPublisher<MealsContainerDecodable, Error> = networkRepository.executeRequest(for: url)
        
        return requestPublisher
            .map { $0.meals.map { $0.toDomainModel() } }
            .eraseToAnyPublisher()
    }
}

extension NetworkMealsRepository: MealDetailsRepository {
    public func getMealDetails(by id: String) -> AnyPublisher<MealDetails, Error> {
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(id)")!
        let requestPublisher: AnyPublisher<MealDetailsContainerDecodable, Error> = networkRepository.executeRequest(for: url)
        
        return requestPublisher
            .map { $0.meals.map { $0.toDomainModel() }.first! }
            .eraseToAnyPublisher()
    }
}
