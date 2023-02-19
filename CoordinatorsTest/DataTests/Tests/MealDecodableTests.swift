//
//  MealDecodableTests.swift
//  DataTests
//
//  Created by Dmitriy Yurchenko on 19.02.2023.
//

import XCTest
import Domain
@testable import Data

final class MealDecodableTests: XCTestCase {
    func test_mappedSuccessfully_intoADomainModel() {
        let sut = makeMealDecodable()
        let mappedMeal = sut.toDomainModel()
        
        XCTAssertEqual(sut.idMeal, mappedMeal.id)
        XCTAssertEqual(sut.strMeal, mappedMeal.title)
        XCTAssertEqual(sut.strMealThumb, mappedMeal.imageURL?.absoluteString)
    }
}
