//
//  MealsOutput.swift
//  CoordinatorsTest
//
//  Created by Dmytro Yurchenko on 03.02.2022.
//

import Foundation

protocol MealsOutput: ModuleOutput {
    var onShowDetails: ((String) -> Void)? { get set }
}
