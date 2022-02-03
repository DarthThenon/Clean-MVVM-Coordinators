//
//  ModuleOutput.swift
//  CoordinatorsTest
//
//  Created by Dmytro Yurchenko on 03.02.2022.
//

import Foundation

protocol ModuleOutput {
    var onFinish: (() -> Void)? { get set }
}
