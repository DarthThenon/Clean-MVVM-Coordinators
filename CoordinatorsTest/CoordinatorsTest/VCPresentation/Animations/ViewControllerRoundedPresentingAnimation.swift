//
//  ViewControllerRoundedPresentingAnimation.swift
//  CoordinatorsTest
//
//  Created by Dmitriy Yurchenko on 20.06.2022.
//

import UIKit

final class ViewControllerRoundedPresentingAnimation: ViewControllerTransitionAnimation {
    private let animationSettings: ViewControllerAnimationSettings
    
    init(animationSettings: ViewControllerAnimationSettings) {
        self.animationSettings = animationSettings
    }
    
    func animate() {
        guard let viewController = animationSettings.transitionContext.viewController(forKey: animationSettings.mode.isPresenting ? .to : .from)
        else { return }

        if animationSettings.mode.isPresenting {
            animationSettings.transitionContext.containerView.addSubview(viewController.view)
        }

        let presentedFrame = animationSettings.transitionContext.finalFrame(for: viewController)
//        let dismissedFrame: CGRect = {
//            var frame = presentedFrame
//
//            frame.origin.y = transitionContext.containerView.frame.height
//
//            return frame
//        }()
//        let initialFrame = mode.isPresenting ? dismissedFrame : presentedFrame
//        let finalFrame = mode.isPresenting ? presentedFrame : dismissedFrame

        viewController.view.frame = presentedFrame
        viewController.view.layer.cornerRadius = presentedFrame.width / 2
        
        let transform = CGAffineTransform(scaleX: 0, y: 0)
        
        viewController.view.transform = transform

        UIView.animate(
            withDuration: animationSettings.animationDuration,
            delay: 1.0,
            animations: {
                viewController.view.transform = .identity
                viewController.view.layer.cornerRadius = .zero
            }, completion: { [weak self] finished in
                guard let self = self else { return }

                if !self.animationSettings.mode.isPresenting {
                    viewController.view.removeFromSuperview()
                }

                self.animationSettings.transitionContext.completeTransition(finished)
            })
    }
}
