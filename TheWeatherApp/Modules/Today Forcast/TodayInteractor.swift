//
//  TodayInteractor.swift
//  TheWeatherApp
//
//  Created by Mehul Parmar on 1/13/18.
//  Copyright © 2018 org. All rights reserved.
//

import Foundation
import CoreLocation

protocol TodayInteractorInput {
    func fetchWeatherForToday(currentLocation: CLLocationCoordinate2D)
}

final class TodayInteractor: TodayInteractorInput {
    weak var output: TodayInteractorOutput?
    let service: WeatherService
    
    init(service: WeatherService = WeatherServiceBuilder().build()) {
        self.service = service
    }
    
    func fetchWeatherForToday(currentLocation: CLLocationCoordinate2D) {
        
        service.fetchWeatherForToday(currentLocation: currentLocation, completion: { [weak self] response in
            guard let weakSelf = self else {
                return
            }
            DispatchQueue.main.async {
                switch response.status {
                case .success(listViewModel: let todayResponseModel):
                    weakSelf.output?.updateWeatherForToday(weather: todayResponseModel)
                case .failure(error: let error):
                    weakSelf.output?.showError(message: error.localizedDescription)
                }
            }
        })
    }
}
