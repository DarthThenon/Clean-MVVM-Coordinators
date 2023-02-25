//
//  MealsRepositoryTests.swift
//  DataTests
//
//  Created by Dmitriy Yurchenko on 19.02.2023.
//

import XCTest
@testable import Data

final class MealsRepositoryTests: XCTestCase {
    func test() {
        let (sut, repository) = makeCategoriesSut()
    }
}

private extension MealsRepositoryTests {
    typealias MealCategoryRepository = MockNetworkRepository<MealCategoryContainerCodable>
    
    func makeCategoriesSut(file: StaticString = #file,
                           line: UInt = #line) -> (NetworkMealsRepository, MealCategoryRepository) {
        
        let repository = MealCategoryRepository()
        let sut = makeSut(networkRepository: repository)
        
        return (sut, repository)
    }
    
    func makeSut<T: Decodable>(networkRepository: MockNetworkRepository<T>,
                               file: StaticString = #file,
                               line: UInt = #line) -> NetworkMealsRepository {
        
        let sut = NetworkMealsRepository(networkRepository: networkRepository)
        
        deallocationCheck(sut, file: file, line: line)
        
        return sut
    }
}
