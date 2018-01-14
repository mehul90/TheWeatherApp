//
//  WeatherService.swift
//  TheWeatherApp
//
//  Created by Mehul Parmar on 1/13/18.
//  Copyright © 2018 org. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherService {
    func fetchWeatherForToday(currentLocation: CLLocationCoordinate2D, completion: @escaping ((TodayResponse)->()))
    func fetchWeatherFor5Days(currentLocation: CLLocationCoordinate2D, completion:@escaping ((FiveDayResponse)->()))
}

//Just for unit testing
protocol URLSessionProtocol { typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}
