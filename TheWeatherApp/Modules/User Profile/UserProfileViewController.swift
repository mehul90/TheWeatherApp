//
//  UserProfileViewController.swift
//  TheWeatherApp
//
//  Created by Mehul Parmar on 1/14/18.
//  Copyright © 2018 org. All rights reserved.
//

import UIKit

protocol UserProfileViewInput: class {
    func showAsLoggedIn(withUserName name: String)
    func allowUserToLogin()
}

final class UserProfileViewController: UIViewController, UserProfileViewInput {
    
    var output: UserProfileViewOutput!

    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var guestLoginLogoutButton: UIButton!
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        output.userTappedLoginAsGuest()
    }
    
    func showAsLoggedIn(withUserName name: String) {
        self.userNameLabel.text = name
    }
    
    func allowUserToLogin() {
        //
    }
}
