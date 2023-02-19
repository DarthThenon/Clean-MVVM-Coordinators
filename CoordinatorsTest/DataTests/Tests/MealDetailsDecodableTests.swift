//
//  MealDetailsDecodableTests.swift
//  DataTests
//
//  Created by Dmitriy Yurchenko on 19.02.2023.
//

import XCTest
import Domain
@testable import Data

final class MealDetailsDecodableTests: XCTestCase {
    func test_mappedSuccessfully_intoADomainModel() {
        let sut = makeMealDetails()
        let mappedMeal = sut.toDomainModel()
        
        XCTAssertEqual(sut.idMeal, mappedMeal.id)
        XCTAssertEqual(sut.strMeal, mappedMeal.title)
        XCTAssertEqual(sut.strCategory, mappedMeal.category)
        XCTAssertEqual(sut.strArea, mappedMeal.nationality)
        XCTAssertEqual(sut.strInstructions, mappedMeal.instruction)
        XCTAssertEqual(sut.strMealThumb, mappedMeal.imageUrl?.absoluteString)
        XCTAssertEqual(sut.strTags, mappedMeal.tags)
        XCTAssertEqual(sut.strYoutube, mappedMeal.link?.absoluteString)
        XCTAssertEqual(sut.strIngredient1, mappedMeal.ingredients[0].title)
        XCTAssertEqual(sut.strMeasure1, mappedMeal.ingredients[0].measure)
        XCTAssertEqual(sut.strIngredient2, mappedMeal.ingredients[1].title)
        XCTAssertEqual(sut.strMeasure2, mappedMeal.ingredients[1].measure)
        XCTAssertEqual(sut.strIngredient3, mappedMeal.ingredients[2].title)
        XCTAssertEqual(sut.strMeasure3, mappedMeal.ingredients[2].measure)
        XCTAssertEqual(sut.strIngredient4, mappedMeal.ingredients[3].title)
        XCTAssertEqual(sut.strMeasure4, mappedMeal.ingredients[3].measure)
        XCTAssertEqual(sut.strIngredient5, mappedMeal.ingredients[4].title)
        XCTAssertEqual("", mappedMeal.ingredients[4].measure)
    }
}

func makeMealDetails() -> MealDetailsDecodable {
    MealDetailsDecodable(
        idMeal: UUID().uuidString,
        strMeal: "Test Meal",
        strCategory: "Test Category",
        strArea: "Test Area",
        strInstructions: "Test Instructions",
        strMealThumb: makeGoogleURL().absoluteString,
        strYoutube: makeGoogleURL().absoluteString,
        strTags: "Tags",
        strIngredient1: "In 1",
        strIngredient2: "In 2",
        strIngredient3: "In 3",
        strIngredient4: "In 4",
        strIngredient5: "In 5",
        strIngredient6: nil,
        strIngredient7: nil,
        strIngredient8: nil,
        strIngredient9: nil,
        strIngredient10: nil,
        strIngredient11: nil,
        strIngredient12: nil,
        strIngredient13: nil,
        strIngredient14: nil,
        strIngredient15: nil,
        strIngredient16: nil,
        strIngredient17: nil,
        strIngredient18: nil,
        strIngredient19: nil,
        strIngredient20: nil,
        strMeasure1: "M 1",
        strMeasure2: "M 2",
        strMeasure3: "M 3",
        strMeasure4: "M 4",
        strMeasure5: nil,
        strMeasure6: nil,
        strMeasure7: nil,
        strMeasure8: nil,
        strMeasure9: nil,
        strMeasure10: nil,
        strMeasure11: nil,
        strMeasure12: nil,
        strMeasure13: nil,
        strMeasure14: nil,
        strMeasure15: nil,
        strMeasure16: nil,
        strMeasure17: nil,
        strMeasure18: nil,
        strMeasure19: nil,
        strMeasure20: nil
    )
}
