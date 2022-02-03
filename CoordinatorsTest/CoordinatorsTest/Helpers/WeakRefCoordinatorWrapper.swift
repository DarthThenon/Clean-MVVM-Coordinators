//
//  WeakRefCoordinatorWrapper.swift
//  CoordinatorsTest
//
//  Created by Dmytro Yurchenko on 03.02.2022.
//

import Foundation

final class WeakRefCoordinatorWrapper {
    private(set) weak var weakReference: Coordinator?
    
    init(coordinator: Coordinator) {
        self.weakReference = coordinator
    }
}
