//
//  FeedViewController.swift
//  InteractiveNavigationController
//
//  Created by Omar Albeik on 4/24/17.
//  Copyright © 2017 Omar Albeik. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
		
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupViews()
		setupGestureRecognizer()
	}
	
}


extension FeedViewController {
	
	func setupViews() {
		view.backgroundColor = .gray

		let label = UILabel(frame: view.bounds)
		label.textAlignment = .center
		label.text = "FEED"
		label.font = UIFont.systemFont(ofSize: 75, weight: UIFontWeightUltraLight)
		label.textColor = .white
		view.addSubview(label)
	}
	
	func setupGestureRecognizer() {
		let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(recognizer:)))
		view.addGestureRecognizer(pan)
	}
	
	func handlePan(recognizer: UIPanGestureRecognizer) {
		switch recognizer.state {
		case .began:
			feedNavigationController?.animator.isInteractive = true
			
			if recognizer.velocity(in: view).x > 0 {
				showCamVC()
			} else {
				showUserVC()
			}
			
		default:
			feedNavigationController?.animator.handlePan(recognizer: recognizer)
		}
	}
	
	func setupNavigationItem() {
		self.title = "Feed"
		
		let camButton = UIBarButtonItem(title: "Cam", style: .plain, target: self, action: #selector(showCamVC))
		navigationItem.leftBarButtonItem = camButton
		
		let userButton = UIBarButtonItem(title: "User", style: .plain, target: self, action: #selector(showUserVC))
		navigationItem.rightBarButtonItem = userButton
	}
	
	func showCamVC() {
		feedNavigationController?.pushViewController(CamViewController(), direction: .leftToRight, animated: true)
	}
	
	func showUserVC() {
		feedNavigationController?.pushViewController(UserViewController(), direction: .rightToLeft, animated: true)
	}
	
}
