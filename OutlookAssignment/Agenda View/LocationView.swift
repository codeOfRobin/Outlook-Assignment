//
//  LocationView.swift
//  TestingStackViewCells
//
//  Created by Robin Malhotra on 27/03/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {

	let locationView = LocationView(frame: .zero)

	init() {
		super.init(nibName: nil, bundle: nil)
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		self.view.addSubview(locationView)
		locationView.configure(locationName: "Sample Location")
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		locationView.frame = locationView.intrinsicContentSize.centeredVertically(in: self.view.bounds)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

class LocationView: UIView {
	let label = UILabel()
	let image = UIImageView()

	let margin: CGFloat = 8

	override init(frame: CGRect) {
		super.init(frame: frame)

		self.addSubview(label)
		self.addSubview(image)


		label.translatesAutoresizingMaskIntoConstraints = false
		image.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 1

		image.contentMode = .scaleAspectFit
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		var labelFrameWithMargin = CGRect.zero
		(image.frame, labelFrameWithMargin) = self.bounds.divided(atDistance: self.frame.height, from: .minXEdge)
		(_, label.frame) = labelFrameWithMargin.divided(atDistance: margin, from: .minXEdge)
	}

	override var intrinsicContentSize: CGSize {
		return sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
	}

	override func sizeThatFits(_ size: CGSize) -> CGSize {
		let labelSize = label.sizeThatFits(CGSize(width: size.width, height: size.height))
		let imageEdge = labelSize.height
		return CGSize(width: imageEdge + margin + labelSize.width, height: imageEdge)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(locationName: String) {
		label.attributedText = NSAttributedString(string: locationName, attributes: Styles.Text.LocationStyle)
		// Location by Ralf Schmitzer from the Noun Project
		image.image = #imageLiteral(resourceName: "Pin")
	}
}
