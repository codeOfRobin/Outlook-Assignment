//
//  CGRect + Centering.swift
//  TestingStackViewCells
//
//  Created by Robin Malhotra on 16/03/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

import UIKit

extension CGSize {
	
	public func centered(in rect: CGRect) -> CGRect {
		let centeredPoint = CGPoint(x: rect.minX + fabs(rect.width - width) / 2, y: rect.minY + fabs(rect.height - height) / 2)
		let size = CGSize(width: min(self.width, rect.width), height: min(self.height, rect.height))
		let point = CGPoint(x: max(centeredPoint.x, rect.minX), y: max(centeredPoint.y, rect.minY))
		return CGRect(origin: point, size: size)
	}
	
	public func centeredVertically(in rect: CGRect, left: CGFloat = 0) -> CGRect {
		var rect = centered(in: rect)
		rect.origin.x = left
		return rect
	}
}
