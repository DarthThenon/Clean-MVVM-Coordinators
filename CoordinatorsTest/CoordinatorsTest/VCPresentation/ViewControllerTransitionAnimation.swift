//
//  ViewControllerTransitionAnimation.swift
//  CoordinatorsTest
//
//  Created by Dmitriy Yurchenko on 20.06.2022.
//

import UIKit

protocol ViewControllerTransitionAnimation: AnyObject {
    init(animationSettings: ViewControllerAnimationSettings)
    
    func animate()
}

