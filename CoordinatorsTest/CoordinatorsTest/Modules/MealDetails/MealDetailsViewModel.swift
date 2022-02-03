//
//  MealDetailsViewModel.swift
//  CoordinatorsTest
//
//  Created by Dmitriy Yurchenko on 03.02.2022.
//

import Foundation
import Combine
import Domain

protocol MealDetailsViewModel {
    
}

final class MealDetailsViewModelImp: MealDetailsViewModel, MealDetailsOutput {
    private let getMealDetailsByIdUseCase: GetMealDetailsByIdUseCase
    private let mealID: String
    
    var onFinish: (() -> Void)?
    
    init(mealID: String, getMealDetailsByIdUseCase: GetMealDetailsByIdUseCase) {
        self.mealID = mealID
        self.getMealDetailsByIdUseCase = getMealDetailsByIdUseCase
    }
}
 
