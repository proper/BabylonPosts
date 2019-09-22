//
//  AppDelegate.swift
//  BabylonPosts
//
//  Created by Li Linyu on 21/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Launch the app without main storyboard
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else {
            fatalError("No window available")
        }

        let navigationViewController = UINavigationController()
        window.rootViewController = navigationViewController
        window.makeKeyAndVisible()

        let defaultNetworkService = DefaultNetworkService(serviceUrl: ServiceURL.base.rawValue)
        let postsNavigator = DefaultPostsNavigator(navigationController: navigationViewController,
                                                   networkService: defaultNetworkService)
        postsNavigator.navigate(to: .posts)

        return true
    }
}
