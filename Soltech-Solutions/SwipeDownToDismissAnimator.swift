//
//  SwipeDownToDismissAnimator.swift
//  Soltech-Solutions
//
//  Created by Alexander Greene on 10/14/17.
//  Copyright © 2017 Alexander Greene. All rights reserved.
//

import UIKit

class SwipeDownToDismissAnimator: NSObject {}

extension SwipeDownToDismissAnimator: UIViewControllerAnimatedTransitioning {
	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return 0.3
	}

	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		guard
			let fromVC = transitionContext.viewController(forKey: .from),
			let toVC = transitionContext.viewController(forKey: .to)
		else { return }

		let containerView = transitionContext.containerView
		containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
		let screenBounds = UIScreen.main.bounds
		let bottomLeftCorner = CGPoint(x: 0, y: screenBounds.height)
		let finalFrame = CGRect(origin: bottomLeftCorner, size: screenBounds.size)

		UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
			fromVC.view.frame = finalFrame
		}) { (completed) in
			transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
		}
	}
}
