//
//  ViewControllerTransitionManager.swift
//  CoordinatorsTest
//
//  Created by Dmitriy Yurchenko on 20.06.2022.
//

import UIKit

final class ViewControllerTransitionManager: NSObject, UIViewControllerTransitioningDelegate {
    private let viewControllerTransitionAnimationType: ViewControllerTransitionAnimation.Type
    private let animationDuration: TimeInterval
    
    init(viewControllerTransitionAnimationType: ViewControllerTransitionAnimation.Type, animationDuration: TimeInterval) {
        self.viewControllerTransitionAnimationType = viewControllerTransitionAnimationType
        self.animationDuration = animationDuration
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        DimmingTransitionPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        ViewControllerTransitionAnimator(mode: .presenting, animationDuration: animationDuration) { [unowned self] settings in
            viewControllerTransitionAnimationType.init(animationSettings: settings)
        }
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        ViewControllerTransitionAnimator(mode: .dismissing, animationDuration: animationDuration) { [unowned self] settings in
            viewControllerTransitionAnimationType.init(animationSettings: settings)
        }
    }
}
