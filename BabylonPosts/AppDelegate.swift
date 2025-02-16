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

        // The main services are injected.
        let defaultNetworkService = DefaultNetworkService(serviceUrl: ServiceURL.base.rawValue)
        let defaultStorageService = DefaultStorageService()
        let defaultDataCoordinator = DefaultDataCoordinator(networkService: defaultNetworkService,
                                                            storageService: defaultStorageService)
        let appNavigator = DefaultAppNavigator(navigationController: navigationViewController,
                                                   dataCoordinator: defaultDataCoordinator)
        appNavigator.navigate(to: .posts)

        return true
    }
}
