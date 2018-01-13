//
//  TodayCoordinator.swift
//  TheWeatherApp
//
//  Created by Mehul Parmar on 1/13/18.
//  Copyright © 2018 org. All rights reserved.
//

import UIKit

protocol TodayCoordinatorInput {
    
}

final class TodayCoordinator: Coordinator<DeepLink> {
    
    lazy var viewController: TodayViewController = {
        
        let controller = TodayViewController()
        let presenter = TodayPresenter()
        presenter.view = controller
        presenter.coordinator = self
        let interactor = TodayInteractor()
        interactor.output = presenter
        presenter.interactor = interactor
        controller.output = presenter

        controller.view.backgroundColor = UIColor.yellow
        return controller
        
    }()
    
    override func toPresentable() -> UIViewController {
        return viewController
    }
}

extension TodayCoordinator: TodayCoordinatorInput {}
