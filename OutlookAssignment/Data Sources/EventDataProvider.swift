//
//  EventDataProvider.swift
//  TestingStackViewCells
//
//  Created by Robin Malhotra on 31/03/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

import Foundation

protocol EventDataProvider {
	func loadEvents(from startDate: Date, to endDate: Date, completion: @escaping ([(Date, [EventViewModel])]) -> Void)
}

