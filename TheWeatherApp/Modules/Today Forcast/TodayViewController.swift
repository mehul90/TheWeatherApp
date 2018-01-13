//
//  TodayController.swift
//  TheWeatherApp
//
//  Created by Mehul Parmar on 1/13/18.
//  Copyright © 2018 org. All rights reserved.
//

import UIKit

protocol TodayViewInput: class {
    
}

final class TodayViewController: UIViewController, TodayViewInput {
    var output: TodayViewOutput!

    override func viewDidLoad() {
        title = "Today"
        
    }
}
