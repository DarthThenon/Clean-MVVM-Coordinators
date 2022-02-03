//
//  CoordinatorsTestTests.swift
//  CoordinatorsTestTests
//
//  Created by Dmytro Yurchenko on 03.02.2022.
//

import XCTest
@testable import CoordinatorsTest

class CoordinatorsTestTests: XCTestCase {
    func test_RecipeCoordinator_storesParent_asWeakRef() {
        let recipesCoordinator = RecipesCoordinator(navigationController: UINavigationController(),
                                                    coordinatorsFactory: .init())
        
        checkDeallocation(of: recipesCoordinator)
        
        recipesCoordinator.start()
        
        let recipeCoordinator = RecipeCoordinator(navigationController: .init(),
                                                  coordinatorsFactory: .init())
        
        checkDeallocation(of: recipeCoordinator)
        
        recipeCoordinator.start()
        
        recipesCoordinator.addChild(recipeCoordinator)
    }
    
    func test_RecipesCoordinator_storesParent_asWeakRef() {
        let recipeCoordinator = RecipeCoordinator(navigationController: UINavigationController(),
                                                    coordinatorsFactory: .init())
        
        checkDeallocation(of: recipeCoordinator)
        
        recipeCoordinator.start()
        
        let recipesCoordinator = RecipesCoordinator(navigationController: .init(),
                                                  coordinatorsFactory: .init())
        
        checkDeallocation(of: recipesCoordinator)
        
        recipesCoordinator.start()
        
        recipeCoordinator.addChild(recipesCoordinator)
    }
}

extension XCTestCase {
    func checkDeallocation(of object: AnyObject,
                           file: StaticString = #file,
                           line: UInt = #line) {
        addTeardownBlock { [weak object] in
            XCTAssertNil(object, "Object have to been deallocated",
                         file: file,
                         line: line)
        }
    }
}
