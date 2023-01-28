//
//  ViewControllerTransitionAnimator.swift
//  CoordinatorsTest
//
//  Created by Dmitriy Yurchenko on 20.06.2022.
//

import UIKit

struct ViewControllerAnimationSettings {
    let mode: ViewControllerTransitionMode
    let animationDuration: TimeInterval
    let transitionContext: UIViewControllerContextTransitioning
}

final class ViewControllerTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private let mode: ViewControllerTransitionMode
    private let animationDuration: TimeInterval
    private let animationFactory: (ViewControllerAnimationSettings) -> ViewControllerTransitionAnimation
    
    init(mode: ViewControllerTransitionMode,
         animationDuration: TimeInterval,
         animationFactory: @escaping (ViewControllerAnimationSettings) -> ViewControllerTransitionAnimation) {
        self.mode = mode
        self.animationDuration = animationDuration
        self.animationFactory = animationFactory
        
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let settings = ViewControllerAnimationSettings(
            mode: mode,
            animationDuration: transitionDuration(using: transitionContext),
            transitionContext: transitionContext
        )
        let animation = animationFactory(settings)
        
        animation.animate()
    }

}

enum ViewControllerTransitionMode {
    case presenting, dismissing
    
    var isPresenting: Bool { self == .presenting }
}
