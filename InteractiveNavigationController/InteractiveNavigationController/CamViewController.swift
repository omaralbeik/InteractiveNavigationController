//
//  CamViewController.swift
//  InteractiveNavigationController
//
//  Created by Omar Albeik on 4/24/17.
//  Copyright © 2017 Omar Albeik. All rights reserved.
//

import UIKit

class CamViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
		setupGestureRecognizer()
	}
	
}


extension CamViewController {
	
	func setupGestureRecognizer() {
		let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(recognizer:)))
		view.addGestureRecognizer(pan)
	}
	
	func handlePan(recognizer: UIPanGestureRecognizer) {
		
		guard recognizer.velocity(in: view).x < 0 else {
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
		view.backgroundColor = .red

		let label = UILabel(frame: view.bounds)
		label.textAlignment = .center
		label.text = "CAM"
		label.font = UIFont.systemFont(ofSize: 75, weight: UIFontWeightUltraLight)
		label.textColor = .white
		view.addSubview(label)
	}
	
	func setupNavigationItem() {
		self.title = "Cam"

		let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "NavArrowRight"), style: .plain, target: feedNavigationController	, action: #selector(feedNavigationController?.popViewController(animated:)))
		navigationItem.rightBarButtonItem = backButton
		
	}

}
