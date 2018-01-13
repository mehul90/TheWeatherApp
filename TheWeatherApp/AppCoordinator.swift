//
//  AppCoordinator.swift
//  TheWeatherApp
//
//  Created by Mehul Parmar on 1/13/18.
//  Copyright © 2018 org. All rights reserved.
//

import UIKit

enum DeepLink {
    case today
    case weekly
}

class AppCoordinator: Coordinator<DeepLink>, UITabBarControllerDelegate {    
    let tabBarController = UITabBarController()
    var tabs: [UIViewController: Coordinator<DeepLink>] = [:]
    
    lazy var todayCoordinator: TodayCoordinator = {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        let router = Router(navigationController: navigationController)
        let coordinator = TodayCoordinator(router: router)
        return coordinator
    }()
    
    lazy var weeklyCoordinator: WeeklyCoordinator = {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        let router = Router(navigationController: navigationController)
        let coordinator = WeeklyCoordinator(router: router)
        return coordinator
    }()
    
    private let store: StoreType
    
    init(router: RouterType, store: StoreType) {
        self.store = store
        super.init(router: router)
        router.setRootModule(tabBarController, hideBar: true)
        tabBarController.delegate = self
        setTabs([todayCoordinator, weeklyCoordinator])
    }
    
    func setTabs(_ coordinators: [Coordinator<DeepLink>], animated: Bool = false) {
        
        tabs = [:]
        
        // Store view controller to coordinator mapping
        let vcs = coordinators.map { coordinator -> UIViewController in
            let viewController = coordinator.toPresentable()
            tabs[viewController] = coordinator
            return viewController
        }
        
        tabBarController.setViewControllers(vcs, animated: animated)
    }
    
    // MARK: UITabBarControllerDelegate
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

    }
}
