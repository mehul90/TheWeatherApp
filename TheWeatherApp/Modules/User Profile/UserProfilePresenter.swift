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
    func needsUpdateUserProfileData()
    func userTappedLogout()
}

protocol UserProfileInteractorOutput: class {
    //
}

final class UserProfilePresenter: UserProfileViewOutput, UserProfileInteractorOutput {
    
    weak var view: UserProfileViewInput?
    var interactor: UserProfileInteractorInput!
    var coordinator: UserProfileCoordinatorInput!
    
    func viewDidLoad() {
        needsUpdateUserProfileData()
    }
    
    func userTappedLoginAsGuest() {
        interactor.userLoggedInAsGuest()
        view?.showAsLoggedIn(withUserName: interactor.getUserName())
    }
    
    func needsUpdateUserProfileData() {
        if interactor.isUserLoggedIn() {
            view?.showAsLoggedIn(withUserName: interactor.getUserName())
        } else {
            view?.allowUserToLogin()
        }
    }
    
    func userTappedLogout() {
        interactor.userLoggedOut()
    }
}
