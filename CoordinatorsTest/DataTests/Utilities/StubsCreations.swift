//
//  StubsCreations.swift
//  DataTests
//
//  Created by Dmitriy Yurchenko on 19.02.2023.
//

import Foundation
@testable import Data

func makeCategoriesContainerStub() throws -> MealCategoryContainerCodable {
    try StubProvider.makeStubObject(jsonFileName: "CategoriesStub")
}
