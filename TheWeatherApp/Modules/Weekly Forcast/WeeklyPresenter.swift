//
//  WeeklyPresenter.swift
//  TheWeatherApp
//
//  Created by Mehul Parmar on 1/13/18.
//  Copyright © 2018 org. All rights reserved.
//

import UIKit
import CoreLocation

protocol WeeklyViewOutput {
    func viewDidLoad()
}

protocol WeeklyInteractorOutput: class {
    func updateForecast(weather: FiveDayResponseModel)
    func showError(message: String)
}

final class WeeklyPresenter: WeeklyViewOutput, WeeklyInteractorOutput {
    weak var view: WeeklyViewInput?
    var interactor: WeeklyInteractorInput!
    var coordinator: WeeklyCoordinatorInput!
    
    func viewDidLoad() {
        LocationManager.shared.fetchCurrentLocation { [weak self] currentLocation in
            guard CLLocationCoordinate2DIsValid(currentLocation) else {
                self?.view?.hideLoadingIndicator()
                self?.view?.showPermissionDeniedError()
                return
            }
            
            self?.interactor.fetchWeatherFor5Days(currentLocation: currentLocation)
        }
    }
    
    func updateForecast(weather: FiveDayResponseModel) {
        view?.hideLoadingIndicator()
        
        var mappedForecast: [NSMutableAttributedString] = []
        let forecastCount = weather.list.count

        for i in 0..<forecastCount where i%(forecastCount/5) == 0 {
            //TODO: move to ViewModel or CellViewModel.
            let item = weather.list[i]
            
            let dateAttributes: [NSAttributedStringKey: Any] = [
                .foregroundColor : UIColor.lightGray,
                .font : UIFont.boldSystemFont(ofSize: 14)
            ]

            let weatherAttributes: [NSAttributedStringKey: Any] = [
                .foregroundColor : UIColor.black,
                .strokeWidth : -2.0,
                .font : UIFont.boldSystemFont(ofSize: 20)
            ]
            
            let windAttributes: [NSAttributedStringKey: Any] = [
                .foregroundColor : UIColor.darkGray,
                .strokeWidth : 0,
                .font : UIFont.boldSystemFont(ofSize: 16)
            ]
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MMM"
            let dateString = formatter.string(from: Date(timeIntervalSince1970: item.dt))

            let dateAttributedString = NSMutableAttributedString(string: "Forecast for " + dateString + "\n", attributes: dateAttributes)
            let weatherAttributedString = NSMutableAttributedString(string: "Weather forecast: " + item.weather[0].main + "\n", attributes: weatherAttributes)
            let windAttributedString = NSMutableAttributedString(string: "Wind speed is \(item.wind.speed), in direction \(String(format: "%.1f", item.wind.deg)) ° North", attributes: windAttributes)
            
            let mts = NSMutableAttributedString()
            mts.append(dateAttributedString)
            mts.append(weatherAttributedString)
            mts.append(windAttributedString)
            mappedForecast.append(mts)
        }
        
        view?.updateWithData(weather: mappedForecast)
    }
    
    func showError(message: String) {
        view?.hideLoadingIndicator()
        view?.showErrorMesage(message: message)
    }
}
