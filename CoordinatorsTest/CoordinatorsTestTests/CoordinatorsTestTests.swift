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
                                                   getMealsByCategoryUseCase: MockGetMealsByCategoryUseCase(),
                                                   getMealDetailsByIdUseCase: MockGetMealDetailsUseCase())
        
        let coordinator = depContainer.createMealsCoordinator()
        
        checkDeallocation(of: coordinator)
        
        appCoordinator.addChild(coordinator)
        
        coordinator.start()
        
        coordinator.showMeals(byCategory: "asfas")
    }
    
    func test_coordinator_deletedFromParent() {
        let depContainer = MealDependencyContainer(getMealsCategoriesUseCase: MockGetMealsCategoriesUseCase(),
                                                   getMealsByCategoryUseCase: MockGetMealsByCategoryUseCase(),
                                                   getMealDetailsByIdUseCase: MockGetMealDetailsUseCase())
        
        let coordinator1 = depContainer.createMealsCoordinator()
        let coordinator2 = depContainer.createMealDetailsCoordinator(id: UUID().uuidString)
        
        checkDeallocation(of: coordinator1)
        checkDeallocation(of: coordinator2)
        
        coordinator1.addChild(coordinator2)
        
        coordinator2.removeFromParent()
        
        XCTAssertTrue(coordinator1.childs.isEmpty)
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

private final class MockGetMealDetailsUseCase: GetMealDetailsByIdUseCase {
    func execute(with id: String) -> AnyPublisher<MealDetails, Error> {
        Just(createMealDetails())
            .mapError({ _ in
                NSError()
            })
            .eraseToAnyPublisher()
    }
}

private final class MockMealsCategoriesViewModel: MealsCategoriesViewModelProtocol, MealsCategoriesOutput {
    var categoriesPublisher: AnyPublisher<[MealCategory], Never> = Just([MealCategory]()).eraseToAnyPublisher()
    
    func viewDidLoad() {}
    func selectCategory(_ category: String) {}
    
    var onSelectCategory: ((String) -> Void)?
    var onFinish: (() -> Void)?
}

private func createMealDetails() -> MealDetails {
    MealDetails(id: UUID().uuidString,
                title: "Test",
                category: "Test",
                nationality: "Test",
                instruction: "Test Instruction",
                imageUrl: nil,
                ingredients: [],
                tags: nil,
                link: nil)
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
