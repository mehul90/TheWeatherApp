//
//  WeatherServiceImplementation.swift
//  TheWeatherApp
//
//  Created by Mehul Parmar on 1/13/18.
//  Copyright © 2018 org. All rights reserved.
//

import Foundation
import CoreLocation


enum WeatherServiceError: Error {
    case genericError
}

final class WeatherServiceImplementation: WeatherService {

    let session: URLSessionProtocol
    
    private let baseURLString: String
    private let APIKey: String
    private let APITodayEndpoint = "weather?"
    private let APIForecastEndpoint = "forecast?"

    init(baseURLString: String, APIKey: String, session: URLSessionProtocol) {
        self.baseURLString = baseURLString
        self.APIKey = APIKey
        self.session = session
    }
    
    //MARK:-
    func fetchWeatherForToday(currentLocation: CLLocationCoordinate2D, completion: @escaping ((TodayResponse) -> ())) {
        let requestURL = weatherURLFromLocation(currentLocation: currentLocation)
        let task = session.dataTask(with: requestURL) { (data, response, error) in
            
            guard let data = data else {
                completion(TodayResponse(status: .failure(error: WeatherServiceError.genericError)))
                return
            }
            
            do {
                let response: TodayResponseModel = try JSONDecoder().decode(TodayResponseModel.self, from: data)
                completion(TodayResponse(status: .success(listViewModel: response)))
            } catch {
                completion(TodayResponse(status: .failure(error: error)))
            }
        }
        task.resume()
    }
    
    private func weatherURLFromLocation(currentLocation: CLLocationCoordinate2D) -> URLRequest {
        let stringURL = baseURLString + APITodayEndpoint + "lat=\(currentLocation.latitude)&lon=\(currentLocation.longitude)&appid=" + APIKey
        let url = URL(string: stringURL)
        return URLRequest(url: url!)
    }
    
    //MARK:-
    func fetchWeatherFor5Days(currentLocation: CLLocationCoordinate2D, completion: @escaping ((FiveDayResponse) -> ())) {
        let requestURL = forecastURLFromLocation(currentLocation: currentLocation)
        let task = session.dataTask(with: requestURL) { (data, response, error) in
            
            guard let data = data else {
                completion(FiveDayResponse(status: .failure(error: WeatherServiceError.genericError)))
                return
            }
            
            do {
                let response: FiveDayResponseModel = try JSONDecoder().decode(FiveDayResponseModel.self, from: data)
                completion(FiveDayResponse(status: .success(listViewModel: response)))
            } catch {
                completion(FiveDayResponse(status: .failure(error: error)))
            }
        }
        task.resume()
    }
    
    private func forecastURLFromLocation(currentLocation: CLLocationCoordinate2D) -> URLRequest {
        let stringURL = baseURLString + APIForecastEndpoint + "lat=\(currentLocation.latitude)&lon=\(currentLocation.longitude)&appid=" + APIKey
        let url = URL(string: stringURL)
        return URLRequest(url: url!)
    }
}
