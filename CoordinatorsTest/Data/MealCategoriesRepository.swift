//
//  MealCategoriesRepository.swift
//  Data
//
//  Created by Dmytro Yurchenko on 03.02.2022.
//

import Foundation
import Domain
import Combine

public final class MealCategoriesRepositoryImpl: MealCategoriesRepository {
    let networkRepository: NetworkRepository
    
    public init(networkRepository: NetworkRepository) {
        self.networkRepository = networkRepository
    }
    
    public func getCategories() -> AnyPublisher<[MealCategory], Error> {
        let url = URL(string: "https://themealdb.com/api/json/v1/1/categories.php")!
        let requestPublisher: AnyPublisher<MealCategoryContainerDecodable, Error> = networkRepository.executeRequest(for: url)
         
        return requestPublisher
            .map { $0.categories.map { $0.toDomainModel() } }
            .eraseToAnyPublisher()
    }
}

private extension MealCategoryDecodable {
    func toDomainModel() -> MealCategory {
        MealCategory.init(id: idCategory,
                          title: strCategory,
                          description: strCategoryDescription,
                          imageURL: strCategoryThumb.flatMap(URL.init))
    }
}
