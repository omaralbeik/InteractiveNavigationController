//
//  UserViewController.swift
//  InteractiveNavigationController
//
//  Created by Omar Albeik on 4/24/17.
//  Copyright © 2017 Omar Albeik. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

		setupViews()
		setupGestureRecognizer()
		
    }
	
}


extension UserViewController {
	
	func setupGestureRecognizer() {
		let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(recognizer:)))
		view.addGestureRecognizer(pan)
	}
	
	func handlePan(recognizer: UIPanGestureRecognizer) {
		
		guard recognizer.velocity(in: view).x > 0 else {
			return
		}
		
		switch recognizer.state {
		case .began:
			feedNavigationController?.popToRootViewController(animated: true)
			
		default:
			feedNavigationController?.animator.handlePan(recognizer: recognizer)
		}
	}
	
	func setupViews() {
		view.backgroundColor = .blue
		
		let label = UILabel(frame: view.bounds)
		label.textAlignment = .center
		label.text = "USER"
		label.font = UIFont.systemFont(ofSize: 75, weight: UIFontWeightUltraLight)
		label.textColor = .white
		view.addSubview(label)
	}
	
	func setupNavigationItem() {
		self.title = "User"

		let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "NavArrowLeft"), style: .plain, target: feedNavigationController, action: #selector(feedNavigationController?.popViewController(animated:)))
		navigationItem.leftBarButtonItem = backButton
	}

}
