//
//  DotView.swift
//  TestingStackViewCells
//
//  Created by Robin Malhotra on 27/03/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

import UIKit

class DotView: UIView {

	override init(frame: CGRect) {
		super.init(frame: frame)

		self.clipsToBounds = true
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(color: UIColor) {
		self.backgroundColor = color
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		self.layer.cornerRadius = frame.height/2
	}

	override var intrinsicContentSize: CGSize {
		return CGSize(width: Constants.Sizes.dotSize, height: Constants.Sizes.dotSize)
	}

	override func sizeThatFits(_ size: CGSize) -> CGSize {
		return CGSize(width: Constants.Sizes.dotSize, height: Constants.Sizes.dotSize)
	}
}
