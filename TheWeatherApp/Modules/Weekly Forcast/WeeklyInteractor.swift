//
//  WeeklyInteractor.swift
//  TheWeatherApp
//
//  Created by Mehul Parmar on 1/13/18.
//  Copyright © 2018 org. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeeklyInteractorInput {
    func fetchWeatherFor5Days(currentLocation: CLLocationCoordinate2D)
}

final class WeeklyInteractor: WeeklyInteractorInput {
    weak var output: WeeklyInteractorOutput?
    let service: WeatherService

    init(service: WeatherService = WeatherServiceBuilder().build()) {
        self.service = service
    }
    
    func fetchWeatherFor5Days(currentLocation: CLLocationCoordinate2D) {
        service.fetchWeatherFor5Days(currentLocation: currentLocation, completion: { [weak self] response in
            guard let weakSelf = self else {
                return
            }
            DispatchQueue.main.async {
                switch response.status {
                case .success(listViewModel: let fiveDayResponseModel):
                    weakSelf.output?.updateForecast(weather: fiveDayResponseModel)
                case .failure(error: let error):
                    weakSelf.output?.showError(message: error.localizedDescription)
                }
            }
        })
    }
}
