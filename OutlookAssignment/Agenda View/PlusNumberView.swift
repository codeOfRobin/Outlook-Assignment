//
//  PlusNumberView.swift
//  TestingStackViewCells
//
//  Created by Robin Malhotra on 16/03/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

import UIKit

func fontWithMonospacedNumbers(_ font: UIFont) -> UIFont {
	let features = [
		[
			UIFontDescriptor.FeatureKey.featureIdentifier: kNumberSpacingType,
			UIFontDescriptor.FeatureKey.typeIdentifier: kMonospacedNumbersSelector
		]
	]

	let fontDescriptor = font.fontDescriptor.addingAttributes(
		[UIFontDescriptor.AttributeName.featureSettings: features]
	)

	return UIFont(descriptor: fontDescriptor, size: font.pointSize)
}

class PlusNumberView: UIView {
	let label = UILabel()

	let xMargin: CGFloat = 6
	let yMargin: CGFloat = 7

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.addSubview(label)
		label.attributedText = NSAttributedString(string: "+0", attributes: Styles.Text.PlusNumberStyle)
		self.backgroundColor = .darkGray
		self.clipsToBounds = true
	}

	func configure(with number: Int) {

		self.label.attributedText = NSAttributedString.init(string: "+\(number)", attributes: Styles.Text.PlusNumberStyle)
	}

	override var intrinsicContentSize: CGSize {
		let maxSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
		let size = label.sizeThatFits(maxSize)
		return CGSize(width: size.width + xMargin * 2, height: size.height + yMargin * 2)
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		let maxSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
		let size = label.sizeThatFits(maxSize)
		self.label.frame = size.centered(in: self.bounds)
		self.layer.cornerRadius = self.frame.height/2
	}

	override func sizeThatFits(_ size: CGSize) -> CGSize {
		let size = label.sizeThatFits(_: size)
		return CGSize(width: size.width + xMargin * 2, height: size.height + yMargin * 2)
	}


	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
