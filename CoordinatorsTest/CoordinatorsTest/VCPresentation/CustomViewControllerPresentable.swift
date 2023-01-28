//
//  CustomViewControllerPresentable.swift
//  CoordinatorsTest
//
//  Created by Dmitriy Yurchenko on 20.06.2022.
//

import UIKit

protocol CustomViewControllerPresentable: AnyObject {
    var transitionDelegate: UIViewControllerTransitioningDelegate? { get set }
    
    func present(_ viewController: UIViewController,
                 duration: TimeInterval,
                 withAnimationType animationType: ViewControllerTransitionAnimation.Type)
}

extension CustomViewControllerPresentable where Self: UIViewController {
    func present(_ viewController: UIViewController,
                 duration: TimeInterval,
                 withAnimationType animationType: ViewControllerTransitionAnimation.Type) {
        transitionDelegate = ViewControllerTransitionManager(
            viewControllerTransitionAnimationType: animationType,
            animationDuration: duration
        )
        
        viewController.transitioningDelegate = transitionDelegate
        viewController.modalPresentationStyle = .custom
        
        present(viewController, animated: true)
    }
}
