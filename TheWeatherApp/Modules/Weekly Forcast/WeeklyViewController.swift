//
//  WeeklyViewController.swift
//  TheWeatherApp
//
//  Created by Mehul Parmar on 1/13/18.
//  Copyright © 2018 org. All rights reserved.
//

import UIKit

protocol WeeklyViewInput: class {
    
}

final class WeeklyViewController: UIViewController, WeeklyViewInput {
    
    var output: WeeklyViewOutput!

    override func viewDidLoad() {
        title = "Weekly"
    }
}
