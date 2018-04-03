//
//  MonthTitleView.swift
//  TestingStackViewCells
//
//  Created by Robin Malhotra on 28/03/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

import UIKit

// This was an experimental class where I was trying to figure out how the "Month overlay" was working - when you drag, the months appear in the calendar view
class MonthTitleView : UICollectionReusableView {
	let label = UILabel()

	override init(frame: CGRect) {
		super.init(frame:frame)
		label.frame = self.bounds
		self.addSubview(label)
		label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		label.font = UIFont.systemFont(ofSize: 40.0)
		label.text = "Testing"
	}	

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// Custom layout that tries to replicate the "Month Overlay" using decoration views. This does seem to work, but I couldn't quite figure out how it works exactly. Also, Decoration views usually aren't supposed to be associated with data, so maybe they're not the right solution 🤔
class MonthFlowLayout: UICollectionViewFlowLayout {
	private let titleKind = "title"
	private let titleHeight : CGFloat = 20
	private var titleRect : CGRect {
		return CGRect(x: 10, y: 0, width: 200, height: self.titleHeight)
	}

	override init() {
		super.init()
		self.sectionInset = .zero
		self.register(MonthTitleView.self, forDecorationViewOfKind:self.titleKind)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func layoutAttributesForDecorationView(
		ofKind elementKind: String, at indexPath: IndexPath)
		-> UICollectionViewLayoutAttributes? {
			if elementKind == self.titleKind {
				let atts = UICollectionViewLayoutAttributes(
					forDecorationViewOfKind:self.titleKind, with:indexPath)
				atts.frame = CGRect(x: 10, y: 10 * indexPath.row, width: 200, height: 20)
				atts.alpha = 0.0
				return atts
			}
			return nil
	}

	override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
		var arr = super.layoutAttributesForElements(in: rect)!
		if let decatts = self.layoutAttributesForDecorationView(
			ofKind:self.titleKind, at: IndexPath(item: 0, section: 0)) {
			if rect.contains(decatts.frame) {
				arr.append(decatts)
			}
		}


		if let decatts = self.layoutAttributesForDecorationView(
			ofKind:self.titleKind, at: IndexPath(item: 30, section: 0)) {
			if rect.contains(decatts.frame) {
				arr.append(decatts)
			}
		}
		return arr
	}

}
