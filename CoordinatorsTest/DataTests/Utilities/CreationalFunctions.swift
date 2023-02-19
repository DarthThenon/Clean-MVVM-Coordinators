//
//  CreationalFunctions.swift
//  DataTests
//
//  Created by Dmitriy Yurchenko on 19.02.2023.
//

import Foundation
@testable import Data

func makeStubbedURLSession() -> URLSession {
    URLSession(configuration: .stubbed)
}

func makeGoogleURL() -> URL {
    URL(string: "https://google.com")!
}

func makeError() -> Error {
    NSError(domain: "Sample Error", code: 9)
}

func makeMealCategoryCodable() -> MealCategoryCodable {
    MealCategoryCodable(
        idCategory: UUID().uuidString,
        strCategory: "Category",
        strCategoryThumb: makeGoogleURL().absoluteString,
        strCategoryDescription: "Description"
    )
}

func makeMealDecodable() -> MealDecodable {
    MealDecodable(
        idMeal: UUID().uuidString,
        strMeal: "Test Meal",
        strMealThumb: makeGoogleURL().absoluteString
    )
}
