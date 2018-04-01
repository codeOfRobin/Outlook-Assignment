//
//  CircularAvatar.swift
//  TestingStackViewCells
//
//  Created by Robin Malhotra on 16/03/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

import UIKit

class CircularAvatar: UIImageView {

	let defaultAvatarSize: CGFloat = 30.0

	override init(image: UIImage?) {
		super.init(image: image)

		self.clipsToBounds = true
		self.translatesAutoresizingMaskIntoConstraints = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		layer.cornerRadius = bounds.height / 2
	}

	override func sizeThatFits(_ size: CGSize) -> CGSize {
		let edge = min(size.width, size.height)
		return CGSize(width: edge, height: edge)
	}

	override var intrinsicContentSize: CGSize {
		return CGSize(width: defaultAvatarSize, height: defaultAvatarSize)
	}
}
