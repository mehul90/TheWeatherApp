//
//  WeeklyViewController.swift
//  TheWeatherApp
//
//  Created by Mehul Parmar on 1/13/18.
//  Copyright © 2018 org. All rights reserved.
//

import UIKit

protocol WeeklyViewInput: class {
    func showLoadingIndicator()
    func hideLoadingIndicator()
    
    func updateWithData(weather: [NSAttributedString])
    func showPermissionDeniedError()
    func showErrorMesage(message: String)
}

final class WeeklyViewController: UIViewController, WeeklyViewInput {
    
    var output: WeeklyViewOutput!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var stackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator.hidesWhenStopped = true
        output.viewDidLoad()
    }
    
    //MARK:-
    func updateWithData(weather: [NSAttributedString]) {
        guard weather.count >= stackView.arrangedSubviews.count else {
            return
        }
        for (index, view) in stackView.arrangedSubviews.enumerated() {
            if let label = view as? UILabel {
                label.attributedText = weather[index]
            }
        }
    }
    
    func showPermissionDeniedError() {
        if let label = view.viewWithTag(1024) as? UILabel {
            label.text = "Inadequate permissons \n Please allow the app to access your location"
        }
    }
    
    func showErrorMesage(message: String) {
        if let label = view.viewWithTag(1024) as? UILabel {
            label.text = message
        }
    }
    
    func showLoadingIndicator() {
        loadingIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        loadingIndicator.stopAnimating()
    }
}
