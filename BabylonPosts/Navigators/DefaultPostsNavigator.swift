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
    private let networkService: NetworkService

    init(navigationController: UINavigationController, networkService: NetworkService) {
        self.navigationController = navigationController
        self.networkService = networkService
    }

    func navigate(to destination: PostsNavigatorDestination) {
        switch destination {
        case .back:
            navigationController?.popViewController(animated: true)
        case .error(let _):
            let alert = UIAlertController(title: "Error", message: "Generic error", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            navigationController?.present(alert, animated: true, completion: nil)
        case .posts:
            let viewModel = DefaultPostsViewModel(networkService: networkService, navigator: self)
            let postsViewController = PostsViewController.make(with: viewModel)
            navigationController?.pushViewController(postsViewController, animated: true)
        case .postDetail(let post):
            let viewModel = DefaultPostDetailViewModel(post: post,
                                                       networkService: networkService,
                                                       navigator: self)
            let postDetailViewController = PostDetailViewController.make(with: viewModel)
            navigationController?.pushViewController(postDetailViewController, animated: true)
        }
    }
}
