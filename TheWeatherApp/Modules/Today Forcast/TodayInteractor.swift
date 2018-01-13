//
//  TodayInteractor.swift
//  TheWeatherApp
//
//  Created by Mehul Parmar on 1/13/18.
//  Copyright © 2018 org. All rights reserved.
//

import Foundation

protocol TodayInteractorInput {
    
}

final class TodayInteractor: TodayInteractorInput {
    weak var output: TodayInteractorOutput?
}
