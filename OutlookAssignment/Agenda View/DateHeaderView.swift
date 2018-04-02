//
//  DateHeaderView.swift
//  TestingStackViewCells
//
//  Created by Robin Malhotra on 27/03/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

import UIKit

class DateHeaderView: UITableViewHeaderFooterView {
	let titleLabel = UILabel()

	// Insets are kept separately in each view for now. Given a style guide from a designer, I'd like to move them to Styles.swift
	let titleInsets = UIEdgeInsets(top: 6, left: 16, bottom: 6, right: 16)

	let stackView = UIStackView()

	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)

		// A value of 0 means no limit on the number of lines
		titleLabel.numberOfLines = 0
		stackView.translatesAutoresizingMaskIntoConstraints = false
		self.contentView.addSubview(stackView)
		stackView.addArrangedSubview(titleLabel)
		stackView.alignEdges(to: self.contentView, insets: titleInsets)
	}

	func configure(title: String, shouldHighlight: Bool) {
		// https://stackoverflow.com/questions/15604900/uitableviewheaderfooterview-unable-to-change-background-color
		self.backgroundView = UIView(frame: self.bounds)
		if shouldHighlight {
			titleLabel.attributedText = NSAttributedString(string: title, attributes: Styles.Text.HighlightedDateHeaderStyle)
			self.backgroundView?.backgroundColor = Styles.Colors.Today.highlightBackgroundColor.color
		} else {
			titleLabel.attributedText = NSAttributedString(string: title, attributes: Styles.Text.DateHeaderStyle)
			self.backgroundView?.backgroundColor = Styles.Colors.contrastBackgroundColor.color
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
