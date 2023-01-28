//
//  DimmingTransitionPresentationController.swift
//  CoordinatorsTest
//
//  Created by Dmitriy Yurchenko on 20.06.2022.
//

import UIKit

final class DimmingTransitionPresentationController: UIPresentationController {
    private lazy var dimmingView: UIView = createDimmingView()
    private var transitionCoordinator: UIViewControllerTransitionCoordinator? {
        presentedViewController.transitionCoordinator
    }
    
    override func presentationTransitionWillBegin() {
        addDimmingViewToContainer()
        
        showDimmingViewAnimatedly()
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        guard completed else { return }
        
        dimmingView.removeFromSuperview()
    }
    
    override func dismissalTransitionWillBegin() {
        hideDimmingViewAnimatedly()
    }
    
    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        parentSize
    }
    
    private func addDimmingViewToContainer() {
        guard let containerView = containerView else { return }
        
        containerView.insertSubview(dimmingView, at: 0)
        
        NSLayoutConstraint.activate([
            dimmingView.topAnchor.constraint(equalTo: containerView.topAnchor),
            dimmingView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            dimmingView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    private func showDimmingViewAnimatedly() {
        transitionCoordinator?.animate { [weak self] _ in
            self?.dimmingView.alpha = 1.0
        }
    }
    
    private func hideDimmingViewAnimatedly() {
        transitionCoordinator?.animate { _ in
            self.dimmingView.alpha = .zero
        }
    }

    private func createDimmingView() -> UIView {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        view.alpha = .zero
        view.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(dimmingViewTapAction))
        )
        
        return view
    }
    
    @objc private func dimmingViewTapAction() {
        presentingViewController.dismiss(animated: true)
    }
}
