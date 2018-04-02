//
//  MockForecastSession.swift
//  OutlookAssignmentTests_iOS
//
//  Created by Robin Malhotra on 02/04/18.
//

import Foundation

class MockForecastSession: URLSession {
	override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
		if request.url?.pathComponents.contains("forecast") ?? false {
			let response = URLResponse.init(url: request.url!, mimeType: "application/json", expectedContentLength: 513, textEncodingName: "utf-8")
			completionHandler(sampleResponse.data(using: .utf8), response, nil)
		}
		return URLSessionDataTask()
	}
}
