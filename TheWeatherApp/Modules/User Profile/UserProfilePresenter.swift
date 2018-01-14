//
//  UserProfilePresenter.swift
//  TheWeatherApp
//
//  Created by Mehul Parmar on 1/14/18.
//  Copyright © 2018 org. All rights reserved.
//

import Foundation

protocol UserProfileViewOutput {
    func viewDidLoad()
    func userTappedLoginAsGuest()
}

protocol UserProfileInteractorOutput: class {
    //
}

final class UserProfilePresenter: UserProfileViewOutput, UserProfileInteractorOutput {
    
    weak var view: UserProfileViewInput?
    var interactor: UserProfileInteractorInput!
    var coordinator: UserProfileCoordinatorInput!
    
    func viewDidLoad() {
        //
    }
    
    func userTappedLoginAsGuest() {
        view?.showAsLoggedIn(withUserName: "Guest")
        coordinator.updateStore(name: "Guest", token: "1234")
    }
}
