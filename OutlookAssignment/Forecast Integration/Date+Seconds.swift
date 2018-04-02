//
//  Date+Seconds.swift
//  OutlookAssignment_iOS
//
//  Created by Robin Malhotra on 02/04/18.
//

import Foundation

extension Date {
	var secondsSinceEpoch: Int {
		return Int(self.timeIntervalSince1970.rounded())
	}
}
