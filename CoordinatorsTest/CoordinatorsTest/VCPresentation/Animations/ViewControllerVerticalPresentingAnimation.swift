//
//  ViewControllerVerticalPresentingAnimation.swift
//  CoordinatorsTest
//
//  Created by Dmitriy Yurchenko on 20.06.2022.
//

import UIKit

final class ViewControllerVerticalPresentingAnimation: ViewControllerTransitionAnimation {
    private let mode: ViewControllerTransitionMode
    private let animationDuration: TimeInterval
    private let transitionContext: UIViewControllerContextTransitioning
    
    init(animationSettings: ViewControllerAnimationSettings) {
        self.mode = animationSettings.mode
        self.animationDuration = animationSettings.animationDuration
        self.transitionContext = animationSettings.transitionContext
    }
    
    func animate() {
        guard let viewController = transitionContext.viewController(forKey: mode.isPresenting ? .to : .from)
        else { return }

        if mode.isPresenting {
            transitionContext.containerView.addSubview(viewController.view)
        }

        let presentedFrame = transitionContext.finalFrame(for: viewController)
        let dismissedFrame: CGRect = {
            var frame = presentedFrame

            frame.origin.y = transitionContext.containerView.frame.height

            return frame
        }()
        let initialFrame = mode.isPresenting ? dismissedFrame : presentedFrame
        let finalFrame = mode.isPresenting ? presentedFrame : dismissedFrame

        viewController.view.frame = initialFrame

        UIView.animate(
            withDuration: animationDuration,
            animations: {
                viewController.view.frame = finalFrame
            }, completion: { [weak self] finished in
                guard let self = self else { return }

                if !self.mode.isPresenting {
                    viewController.view.removeFromSuperview()
                }

                self.transitionContext.completeTransition(finished)
            })
    }
}
