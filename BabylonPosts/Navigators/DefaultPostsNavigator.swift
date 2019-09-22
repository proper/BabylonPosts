//
//  DefaultPostsNavigator.swift
//  BabylonPosts
//
//  Created by Li Linyu on 21/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import UIKit

class DefaultPostsNavigator: PostsNavigator {
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
        case .error(let error):
            //TODO: handle errors
            _ = error
        case .posts:
            let postsViewController = PostsViewController.fromNib() as PostsViewController
            postsViewController.viewModel = DefaultPostsViewModel(networkService: networkService)
            postsViewController.navigator = self
            postsViewController.bindViewModel()
            navigationController?.pushViewController(postsViewController, animated: true)
        case .postDetail(let post):
            let postDetailViewController = PostDetailViewController.fromNib() as PostDetailViewController
            postDetailViewController.viewModel = DefaultPostDetailViewModel(post: post, networkService: networkService)
            postDetailViewController.bindViewModel()
            navigationController?.pushViewController(postDetailViewController, animated: true)
        }
    }
}
