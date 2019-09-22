//
//  DefaultPostsViewModel.swift
//  BabylonPosts
//
//  Created by Li Linyu on 21/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import Alamofire
import PromiseKit

final class DefaultPostsViewModel: PostsViewModel {
    private let networkService: NetworkService
    private let navigator: PostsNavigator

    var posts: [Post]? {
        didSet {
            self.onPostsUpdated?()
        }
    }
    var isLoading: Bool {
        didSet {
            self.onLoadingStateChanged?()
        }
    }

    // View binding
    var onLoadingStateChanged: (() -> Void)?
    var onPostsUpdated: (() -> Void)?

    init(networkService: NetworkService, navigator: PostsNavigator) {
        self.networkService = networkService
        self.navigator = navigator
        self.isLoading = false
    }

    func fetchPosts() {
        guard !isLoading else {
            return
        }

        isLoading = true

        firstly {
            networkService.fetchPosts()
        }.done { posts in
            self.isLoading = false
            self.posts = posts
        }.catch { error in
            self.isLoading = false
            self.handleError(error: error)
        }
    }

    func postTapped(post: Post) {
        DispatchQueue.main.async {
            self.navigator.navigate(to: .postDetail(post: post))
        }
    }

    func handleError(error: Error) {
        DispatchQueue.main.async {
            self.navigator.navigate(to: .error(error: error))
        }
    }
}
