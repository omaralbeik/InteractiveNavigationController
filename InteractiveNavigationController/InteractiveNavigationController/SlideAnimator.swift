//
//  SlideAnimator.swift
//  InteractiveNavigationController
//
//  Created by Omar Albeik on 4/27/17.
//  Copyright © 2017 Omar Albeik. All rights reserved.
//

import UIKit

class SlideAnimator: UIPercentDrivenInteractiveTransition {
	
	var direction: slideDirection = .rightToLeft
	var transitionDuration: TimeInterval = 0.3
	var operation: UINavigationControllerOperation = .push
	
	var isInteractive = false
	
	weak var storedContext: UIViewControllerContextTransitioning?
	
	enum slideDirection {
		case rightToLeft
		case leftToRight
	}
	
	func handlePan(recognizer: UIPanGestureRecognizer) {
		
		let translation = recognizer.translation(in: recognizer.view!.superview!)
		var progress: CGFloat = abs(translation.x / 300.0)
		progress = min(max(progress, 0.01), 0.99)
		
		switch recognizer.state {
		case .changed:
			update(progress)
		case .cancelled, .ended:
			if progress < 0.5 {
				cancel()
			} else {
				finish()
			}
			isInteractive = false
		default:
			break
		}
		
	}
	
}


extension SlideAnimator: UIViewControllerAnimatedTransitioning {
	
	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return transitionDuration
	}
	
	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		storedContext = transitionContext
		
		let container = transitionContext.containerView
		
		guard let fromView = transitionContext.view(forKey: .from) else {
			return
		}
		
		guard let toView = transitionContext.view(forKey: .to) else {
			return
		}
		
		container.addSubview(fromView)
		container.addSubview(toView)
		
		var transform1: CGAffineTransform {
			let x = direction == .leftToRight ? -container.frame.width : container.frame.width
			return CGAffineTransform(translationX: x, y: 0)
		}
		
		var transform2: CGAffineTransform {
			let x = direction == .leftToRight ? container.frame.width : -container.frame.width
			return CGAffineTransform(translationX: x, y: 0)
		}
		
		if operation == .push {
			
			toView.transform = transform1
			
			UIView.animate(withDuration: transitionDuration, animations: {
				fromView.transform = transform2
				toView.transform = .identity
			}, completion: { _ in
				transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
			})
			
		} else if operation == .pop {
			
			UIView.animate(withDuration: transitionDuration, animations: {
				fromView.transform = transform1
				toView.transform = .identity
			}, completion: { _ in
				transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
			})
			
		}
		
	}
	
}
