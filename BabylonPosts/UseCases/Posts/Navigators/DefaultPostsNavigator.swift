//
//  DefaultPostsNavigator.swift
//  BabylonPosts
//
//  Created by Li Linyu on 25/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import UIKit

final class DefaultPostsNavigator: PostsNavigator {
    private weak var navigationController: UINavigationController?
    private let dataCoordinator: DataCoordinator

    init(navigationController: UINavigationController?, dataCoordinator: DataCoordinator) {
        self.navigationController = navigationController
        self.dataCoordinator = dataCoordinator
    }

    func navigate(to destination: PostsNavigatorDestination) {
        switch destination {
        case .error(let error, let mainAction, let cancelAction):
            // Simple error handling here, can be extened to perform actions such as refresh if needed
            let alert = GenericNavigatorAlertController.create(with: error,
                                                               mainAction: mainAction, cancelAction: cancelAction)
            navigationController?.present(alert, animated: true, completion: nil)
        case .postDetail(let post):
            let navigator = DefaultPostDetailNavigator(navigationController: navigationController,
                                                       dataCoordinator: dataCoordinator)
            let viewModel = DefaultPostDetailViewModel(post: post,
                                                       dataCoordinator: dataCoordinator,
                                                       navigator: navigator)
            let postDetailViewController = PostDetailViewController.make(with: viewModel)
            navigationController?.pushViewController(postDetailViewController, animated: true)
        }
    }
}
