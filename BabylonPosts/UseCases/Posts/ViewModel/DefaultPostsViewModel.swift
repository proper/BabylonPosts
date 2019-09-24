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
    let dataCoordinator: PostsDataCoordinator
    let navigator: PostsNavigator

    var posts: [PostViewModel]? {
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

    init(dataCoordinator: PostsDataCoordinator, navigator: PostsNavigator) {
        self.dataCoordinator = dataCoordinator
        self.navigator = navigator
        self.isLoading = false
    }

    func viewDidLoad() {
        fetchPosts()
    }

    func refreshStarted() {
        fetchPosts()
    }

    private func fetchPosts() {
        guard !isLoading else {
            return
        }

        isLoading = true

        firstly {
            dataCoordinator.fetchPosts()
        }.done { posts in
            self.isLoading = false
            self.posts = self.createPostViewModels(from: posts)
        }.catch { error in
            self.isLoading = false
            self.handleError(error: error)
        }
    }

    func postTapped(post: Post) {
        navigator.navigate(to: .postDetail(post: post))
    }

    private func handleError(error: Error) {
        let mainAction = ErrorAction(title: NSLocalizedString("error_button_retry", comment: "")) { [weak self] in
            self?.fetchPosts()
        }
        let cancelAction = ErrorAction(title: NSLocalizedString("ok", comment: ""), action: nil)
        navigator.navigate(to: .error(error: error, mainAction: mainAction, cancelAction: cancelAction))
    }

    private func createPostViewModels(from posts: [Post]) -> [PostViewModel] {
        return posts.map {
            var postViewModel = DefaultPostViewModel(post: $0)
            postViewModel.delegate = self
            return postViewModel
        }
    }
}
