//
//  MealCategoryCodableTests.swift
//  DataTests
//
//  Created by Dmitriy Yurchenko on 19.02.2023.
//

import XCTest
import Domain
@testable import Data

final class MealCategoryCodableTests: XCTestCase {
    func test_mappedSuccessfully_intoADomainModel() {
        let sut = makeMealCategoryCodable()
        let mappedCategory = sut.toDomainModel()
        
        XCTAssertEqual(sut.idCategory, mappedCategory.id)
        XCTAssertEqual(sut.strCategory, mappedCategory.title)
        XCTAssertEqual(sut.strCategoryDescription, mappedCategory.description)
        XCTAssertEqual(sut.strCategoryThumb, mappedCategory.imageURL?.absoluteString)
    }
}
