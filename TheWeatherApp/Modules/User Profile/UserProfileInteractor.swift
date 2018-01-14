//
//  UserProfileInteractor.swift
//  TheWeatherApp
//
//  Created by Mehul Parmar on 1/14/18.
//  Copyright © 2018 org. All rights reserved.
//

import Foundation

protocol UserProfileInteractorInput {
    func isUserLoggedIn() -> Bool
    func getUserName() -> String
    func userLoggedInAsGuest()
    func userLoggedOut()
}

final class UserProfileInteractor: UserProfileInteractorInput {

    weak var output: UserProfileInteractorOutput?
    private let store: StoreType

    init(store: StoreType) {
        self.store = store
    }
    
    func isUserLoggedIn() -> Bool {
        return store.isLoggedIn
    }
    
    func getUserName() -> String {
        return store.userName ?? ""
    }
    
    func userLoggedInAsGuest() {
        store.update(userName: "Guest", token: "")
    }
    
    func userLoggedOut() {
        store.update(userName: nil, token: nil)
    }
}
