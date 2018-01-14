//
//  AppDelegate.swift
//  TheWeatherApp
//
//  Created by Mehul Parmar on 1/13/18.
//  Copyright © 2018 org. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?
    
    private let config: ConfigType = Config(bundle: .main, locale: .current)
    lazy var appStore: StoreType = Store(config: self.config)
    lazy var appNavigationController: UINavigationController = UINavigationController()
    lazy var appRouter: RouterType = Router(navigationController: self.appNavigationController)
    lazy var appCoordinator: AppCoordinator = AppCoordinator(router: self.appRouter, store: self.appStore)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = appCoordinator.toPresentable()
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        
        // or get notification from launch options and convert it to a deep link
        appCoordinator.start()
        
        GIDSignIn.sharedInstance().clientID = "378824460495-lr0eqgd3velj97qts0v1gruad92qar44.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self

        return true
    }

    func application(_ application: UIApplication,
                     open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: sourceApplication,
                                                 annotation: annotation)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard error == nil else {
            //only way it come here is when user cancels... thus, no need for any alerts, etc.
            print("\(error.localizedDescription)")
            return
        }
        
        let idToken = user.authentication.idToken // Safe to send to the server
        let fullName = user.profile.name
        appStore.update(userName: fullName ?? "", token: idToken ?? "")
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        //TODO: sogn-out.
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}
