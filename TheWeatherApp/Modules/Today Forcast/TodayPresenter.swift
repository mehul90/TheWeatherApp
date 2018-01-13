//
//  TodayPresenter.swift
//  TheWeatherApp
//
//  Created by Mehul Parmar on 1/13/18.
//  Copyright © 2018 org. All rights reserved.
//

import Foundation

protocol TodayViewOutput {
    
}

protocol TodayInteractorOutput: class {
    
}

final class TodayPresenter: TodayViewOutput, TodayInteractorOutput {
    weak var view: TodayViewInput?
    var interactor: TodayInteractorInput!
    var coordinator: TodayCoordinatorInput!

    
}
