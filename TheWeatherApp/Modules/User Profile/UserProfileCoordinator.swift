//
//  UserProfileCoordinator.swift
//  TheWeatherApp
//
//  Created by Mehul Parmar on 1/14/18.
//  Copyright © 2018 org. All rights reserved.
//

import UIKit

protocol UserProfileCoordinatorInput {
    func refreshLoginData()
}

final class UserProfileCoordinator: Coordinator<DeepLink> {
    
    private let store: StoreType
    //weak var delegate: AppCoordinatorUserProfileInput?

    lazy var viewController: UserProfileViewController = {
        let controller = UserProfileViewController()
        controller.title = "Profile"
        let presenter = UserProfilePresenter()
        presenter.view = controller
        presenter.coordinator = self
        let interactor = UserProfileInteractor(store: store)
        interactor.output = presenter
        presenter.interactor = interactor
        controller.output = presenter
        return controller
    }()
    
    
    init(router: RouterType, store: StoreType) {
        self.store = store
        super.init(router: router)
    }
    
    override func toPresentable() -> UIViewController {
        return viewController
    }
}

extension UserProfileCoordinator: UserProfileCoordinatorInput {
    
    func refreshLoginData() {
        viewController.refreshUserProfileData()
    }
}
