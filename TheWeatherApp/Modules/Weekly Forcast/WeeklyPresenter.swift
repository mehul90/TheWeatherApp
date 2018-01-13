//
//  WeeklyPresenter.swift
//  TheWeatherApp
//
//  Created by Mehul Parmar on 1/13/18.
//  Copyright © 2018 org. All rights reserved.
//

import Foundation

protocol WeeklyViewOutput {
    
}

protocol WeeklyInteractorOutput: class {
    
}

final class WeeklyPresenter: WeeklyViewOutput, WeeklyInteractorOutput {
    weak var view: WeeklyViewInput?
    var interactor: WeeklyInteractorInput!
    var coordinator: WeeklyCoordinatorInput!

}
