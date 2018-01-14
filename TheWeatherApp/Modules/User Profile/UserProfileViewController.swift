//
//  UserProfileViewController.swift
//  TheWeatherApp
//
//  Created by Mehul Parmar on 1/14/18.
//  Copyright © 2018 org. All rights reserved.
//

import UIKit

protocol UserProfileViewInput: class {
    func refreshUserProfileData()
    func showAsLoggedIn(withUserName name: String)
    func allowUserToLogin()
}

final class UserProfileViewController: UIViewController, UserProfileViewInput, GIDSignInUIDelegate {
    
    var output: UserProfileViewOutput!

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var loginStack: UIStackView!
    @IBOutlet weak var loggedInStack: UIStackView!
    
    @IBAction func logoutButtonTapped() {
        output.userTappedLogout()
    }

    @IBAction func loginAsGuestButtonTapped(_ sender: Any) {
        output.userTappedLoginAsGuest()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginStack.isHidden = true
        loggedInStack.isHidden = true
        GIDSignIn.sharedInstance().uiDelegate = self
        output.viewDidLoad()
    }
    
    func showAsLoggedIn(withUserName name: String) {
        loggedInStack.isHidden = false
        loginStack.isHidden = true
        self.userNameLabel.text = name
    }
    
    func allowUserToLogin() {
        loginStack.isHidden = false
        loggedInStack.isHidden = true
    }
    
    func refreshUserProfileData() {
        output.needsUpdateUserProfileData()
    }
}
