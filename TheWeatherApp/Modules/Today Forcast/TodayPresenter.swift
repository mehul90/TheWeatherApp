//
//  TodayPresenter.swift
//  TheWeatherApp
//
//  Created by Mehul Parmar on 1/13/18.
//  Copyright © 2018 org. All rights reserved.
//

import Foundation
import CoreLocation

protocol TodayViewOutput {
    func viewDidLoad()
}

protocol TodayInteractorOutput: class {
    func updateWeatherForToday(weather: TodayResponseModel)
    func showError(message: String)
}

final class TodayPresenter: TodayViewOutput, TodayInteractorOutput {
    weak var view: TodayViewInput?
    var interactor: TodayInteractorInput!
    var coordinator: TodayCoordinatorInput!

    func viewDidLoad() {
        LocationManager.shared.fetchCurrentLocation { [weak self] currentLocation in
            guard CLLocationCoordinate2DIsValid(currentLocation) else {
                self?.view?.hideLoadingIndicator()
                self?.view?.showPermissionDeniedError()
                return
            }
            
            self?.interactor.fetchWeatherForToday(currentLocation: currentLocation)
        }
    }
    
    //MARK:-
    func updateWeatherForToday(weather: TodayResponseModel) {
        view?.hideLoadingIndicator()
        view?.updateWithData(weather: weather)
    }
    
    func showError(message: String) {
        view?.hideLoadingIndicator()
        view?.showErrorMesage(message: message)
    }
}
