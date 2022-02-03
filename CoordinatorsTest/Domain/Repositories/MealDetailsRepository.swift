//
//  MealDetailsRepository.swift
//  Domain
//
//  Created by Dmitriy Yurchenko on 03.02.2022.
//

import Foundation
import Combine

public protocol MealDetailsRepository {
    func getMealDetails(by id: String) -> AnyPublisher<MealDetails, Error>
}
