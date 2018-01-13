//
//  WeeklyCoordinator.swift
//  TheWeatherApp
//
//  Created by Mehul Parmar on 1/13/18.
//  Copyright © 2018 org. All rights reserved.
//

import UIKit

protocol WeeklyCoordinatorInput {
    
}

final class WeeklyCoordinator: Coordinator<DeepLink> {
    
    lazy var viewController: WeeklyViewController = {
        
        let controller = WeeklyViewController()
        let presenter = WeeklyPresenter()
        presenter.view = controller
        presenter.coordinator = self
        let interactor = WeeklyInteractor()
        interactor.output = presenter
        presenter.interactor = interactor
        controller.output = presenter
        
        controller.view.backgroundColor = UIColor.green
        return controller
        
    }()
    
    override func toPresentable() -> UIViewController {
        return viewController
    }
}

extension WeeklyCoordinator: WeeklyCoordinatorInput {}
