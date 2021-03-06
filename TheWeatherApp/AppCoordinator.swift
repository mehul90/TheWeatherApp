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
    
    lazy var userProfileCoordinator: UserProfileCoordinator = {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        let router = Router(navigationController: navigationController)
        let coordinator = UserProfileCoordinator(router: router, store: store)
        return coordinator
    }()
    
    private let store: StoreType
    
    init(router: RouterType, store: StoreType) {
        self.store = store
        super.init(router: router)
        router.setRootModule(tabBarController, hideBar: true)
        self.store.delegate = self
        tabBarController.delegate = self
        if store.isLoggedIn {
            setTabs([todayCoordinator, weeklyCoordinator, userProfileCoordinator])
        } else {
            setTabs([userProfileCoordinator])
        }
    }
    
    func setTabs(_ coordinators: [Coordinator<DeepLink>], animated: Bool = false) {
        
        tabs = [:]
        
        // Store view controller to coordinator mapping
        let vcs = coordinators.map { coordinator -> UIViewController in
            let viewController = coordinator.toPresentable()
            viewController.tabBarItem.selectedImage = #imageLiteral(resourceName: "selected")
            viewController.tabBarItem.image = #imageLiteral(resourceName: "nonSelected")
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

extension AppCoordinator: StoreDelegate {
    func store(_ store: StoreType, didChangeLogginState isLoggedIn: Bool) {
        userProfileCoordinator.refreshLoginData()
        if isLoggedIn {
            setTabs([todayCoordinator, weeklyCoordinator, userProfileCoordinator])
        } else {
            setTabs([userProfileCoordinator])
        }
    }
}
