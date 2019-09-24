//
//  DefaultAppNavigator.swift
//  BabylonPosts
//
//  Created by Li Linyu on 25/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import UIKit

final class DefaultAppNavigator: AppNavigator {
    private weak var navigationController: UINavigationController?
    private let dataCoordinator: DataCoordinator

    init(navigationController: UINavigationController?, dataCoordinator: DataCoordinator) {
        self.navigationController = navigationController
        self.dataCoordinator = dataCoordinator
    }

    func navigate(to destination: AppNavigatorDesination) {
        switch destination {
        case .posts:
            let navigator = DefaultPostsNavigator(navigationController: navigationController,
                                                  dataCoordinator: dataCoordinator)
            let viewModel = DefaultPostsViewModel(dataCoordinator: dataCoordinator, navigator: navigator)
            let postsViewController = PostsViewController.make(with: viewModel)
            navigationController?.pushViewController(postsViewController, animated: true)
        }
    }
}
