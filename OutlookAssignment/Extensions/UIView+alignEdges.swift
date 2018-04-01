//
//  UIView+alignEdges.swift
//  TestingStackViewCells
//
//  Created by Robin Malhotra on 01/04/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

import UIKit

extension UIView {
	func alignEdges(to otherView: UIView, insets: UIEdgeInsets = .zero) {
		self.topAnchor.constraint(equalTo: otherView.topAnchor, constant: insets.top).isActive = true
		self.bottomAnchor.constraint(equalTo: otherView.bottomAnchor, constant: -insets.bottom).isActive = true
		self.leftAnchor.constraint(equalTo: otherView.leftAnchor, constant: insets.left).isActive = true
		self.rightAnchor.constraint(equalTo: otherView.rightAnchor, constant: -insets.right).isActive = true
	}
}
