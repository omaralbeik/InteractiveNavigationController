//
//  FeedNavigationController.swift
//  InteractiveNavigationController
//
//  Created by Omar Albeik on 4/27/17.
//  Copyright © 2017 Omar Albeik. All rights reserved.
//

import UIKit

class FeedNavigationController: UINavigationController, UINavigationControllerDelegate {

	let animator = SlideAnimator()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		delegate = self
    }

	func pushViewController(_ viewController: UIViewController, direction: SlideAnimator.slideDirection, animated: Bool) {
		animator.direction = direction
		pushViewController(viewController, animated: true)
	}
	
	func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		animator.operation = operation
		return animator
	}
	
	func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
		guard animator.isInteractive else {
			return nil
		}
		return animator
	}
	
	func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
		viewController.navigationItem.hidesBackButton = true
	}
	
	func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
		
		if let feedVC = viewController as? FeedViewController {
			feedVC.setupNavigationItem()
		}
		
		if let camVC = viewController as? CamViewController {
			camVC.setupNavigationItem()
		}
		
		if let userVC = viewController as? UserViewController {
			userVC.setupNavigationItem()
		}
	}
	
}
