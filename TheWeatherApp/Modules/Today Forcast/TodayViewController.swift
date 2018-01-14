//
//  TodayController.swift
//  TheWeatherApp
//
//  Created by Mehul Parmar on 1/13/18.
//  Copyright © 2018 org. All rights reserved.
//

import UIKit

protocol TodayViewInput: class {
    func showLoadingIndicator()
    func hideLoadingIndicator()
    
    //TODO: inject both with a TodayViewModel instead.
    func updateWithData(weather: TodayResponseModel)
    func showPermissionDeniedError()
    func showErrorMesage(message: String)
}

final class TodayViewController: UIViewController, TodayViewInput {
    var output: TodayViewOutput!

    @IBOutlet weak var weatherTitleLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var windSpeedTitleLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Today"
        loadingIndicator.hidesWhenStopped = true
        output.viewDidLoad()
    }
        
    // MARK:- TodayViewInput
    func showLoadingIndicator() {
        loadingIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        loadingIndicator.stopAnimating()
    }
    
    func updateWithData(weather: TodayResponseModel) {
        weatherTitleLabel.text = "Weather today is " + weather.weather[0].main
        weatherDescriptionLabel.text = weather.weather[0].description
        
        windSpeedTitleLabel.text = "Wind speed is " + String(weather.wind.speed)
        windDirectionLabel.text = "Direction: " + String(weather.wind.deg) + " ° North"
    }
    
    func showPermissionDeniedError() {
        weatherTitleLabel.text = "Inadequate permissons"
        weatherDescriptionLabel.text = "Please allow the app to access your location"
        windSpeedTitleLabel.text = ""
        windDirectionLabel.text = ""
    }
    
    func showErrorMesage(message: String) {
        weatherTitleLabel.text = ""
        weatherDescriptionLabel.text = ""
        windSpeedTitleLabel.text = message
        windDirectionLabel.text = ""
    }
}
