//
//  DefaultPostsNavigator.swift
//  BabylonPosts
//
//  Created by Li Linyu on 21/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import UIKit

final class DefaultPostsNavigator: PostsNavigator {
    private weak var navigationController: UINavigationController?
    private let dataCoordinator: DataCoordinator

    init(navigationController: UINavigationController, dataCoordinator: DataCoordinator) {
        self.navigationController = navigationController
        self.dataCoordinator = dataCoordinator
    }

    func navigate(to destination: PostsNavigatorDestination) {
        switch destination {
        case .back:
            navigationController?.popViewController(animated: true)
        case .error(let error, let mainAction, let cancelAction):
            // Simple error handling here, can be extened to perform actions such as refresh if needed
            let alert = createAlertController(error: error, mainAction: mainAction, cancelAction: cancelAction)
            navigationController?.present(alert, animated: true, completion: nil)
        case .posts:
            let viewModel = DefaultPostsViewModel(dataCoordinator: dataCoordinator, navigator: self)
            let postsViewController = PostsViewController.make(with: viewModel)
            navigationController?.pushViewController(postsViewController, animated: true)
        case .postDetail(let post):
            let viewModel = DefaultPostDetailViewModel(post: post,
                                                       dataCoordinator: dataCoordinator,
                                                       navigator: self)
            let postDetailViewController = PostDetailViewController.make(with: viewModel)
            navigationController?.pushViewController(postDetailViewController, animated: true)
        }
    }

    private func createAlertController(error: Error,
                                       mainAction: ErrorAction?, cancelAction: ErrorAction) -> UIAlertController {
        let title = NSLocalizedString("error_generic_title", comment: "")
        let message = NSLocalizedString("error_generic_message", comment: "")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        if let mainAction = mainAction {
            let action = UIAlertAction(title: mainAction.title, style: .default) { _ in
                mainAction.action?()
            }
            alert.addAction(action)
        }

        let cancel = UIAlertAction(title: cancelAction.title, style: .cancel) { _ in
            cancelAction.action?()
        }
        alert.addAction(cancel)

        return alert
    }
}
