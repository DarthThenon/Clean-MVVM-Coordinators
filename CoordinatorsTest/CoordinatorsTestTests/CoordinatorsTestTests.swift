//
//  CoordinatorsTestTests.swift
//  CoordinatorsTestTests
//
//  Created by Dmytro Yurchenko on 03.02.2022.
//

import XCTest
import Domain
import Combine
@testable import CoordinatorsTest

class CoordinatorsTestTests: XCTestCase {
    func test_mealsCategoriesViewController_deallocation() {
        let viewModel = MockMealsCategoriesViewModel()
        let mealsCategoriesViewController = MealsCategoriesViewController(viewModel: viewModel)
        
        checkDeallocation(of: mealsCategoriesViewController)
    }
    
    func test_deallocation_ofAllSequence() {
        let appCoordinator = AppCoordinator()
        
        checkDeallocation(of: appCoordinator)
        
        let depContainer = MealDependencyContainer(getMealsCategoriesUseCase: MockGetMealsCategoriesUseCase(),
                                                   getMealsByCategoryUseCase: MockGetMealsByCategoryUseCase())
        
        checkDeallocation(of: depContainer)
        
        let coordinator = depContainer.createMealsCoordinator()
        
        checkDeallocation(of: coordinator)
        
        appCoordinator.addChild(coordinator)
        
        coordinator.start()
        
        coordinator.showMeals(byCategory: "asfas")
    }
}

private final class MockGetMealsByCategoryUseCase: GetMealsByCategoryUseCase {
    func execute(from category: String) -> AnyPublisher<[Meal], Error> {
        Just([Meal]())
            .mapError({ _ in
                NSError()
            })
            .eraseToAnyPublisher()
    }
}

private final class MockGetMealsCategoriesUseCase: GetMealCategoriesUseCase {
    func execute() -> AnyPublisher<[MealCategory], Error> {
        Just([MealCategory]())
            .mapError({ _ in
                NSError()
            })
            .eraseToAnyPublisher()
    }
}

private final class MockMealsCategoriesViewModel: MealsCategoriesViewModel, MealsCategoriesOutput {
    var categoriesPublisher: AnyPublisher<[MealCategory], Never> = Just([MealCategory]()).eraseToAnyPublisher()
    
    func viewDidLoad() {}
    func selectCategory(_ category: String) {}
    
    var onSelectCategory: ((String) -> Void)?
    var onFinish: (() -> Void)?
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
