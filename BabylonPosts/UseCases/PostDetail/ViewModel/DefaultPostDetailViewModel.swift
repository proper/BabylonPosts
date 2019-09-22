//
//  DefaultPostDetailViewModel.swift
//  BabylonPosts
//
//  Created by Li Linyu on 22/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import PromiseKit

final class DefaultPostDetailViewModel: PostDetailViewModel {
    var description: String?
    var author: String?
    var numberOfComments: Int?
    var title: String?

    var isLoading: Bool {
        didSet {
            self.onLoadingStateChanged?()
        }
    }

    // Binding
    var onLoadingStateChanged: (() -> Void)?
    var onPostDetailUpdated: (() -> Void)?

    let post: Post
    private let dataCoordinator: DataCoordinator
    private let navigator: PostsNavigator

    init(post: Post, dataCoordinator: DataCoordinator, navigator: PostsNavigator) {
        self.post = post
        self.description = post.body
        self.title = post.title
        self.dataCoordinator = dataCoordinator
        self.navigator = navigator
        self.isLoading = false
    }

    func fetchPostDetail() {
        isLoading = true

        // Demo the synchronization
        firstly {
            when(fulfilled: dataCoordinator.fetchUser(for: post.userId), dataCoordinator.fetchComments(for: post.id))
        }.done { (user, comments) in
            self.isLoading = false
            self.author = user.name
            self.numberOfComments = comments.count
            self.onPostDetailUpdated?()
        }.catch { error in
            self.isLoading = false
            self.handleError(error: error)
        }
    }

    private func handleError(error: Error) {
        DispatchQueue.main.async {
            self.navigator.navigate(to: .error(error: error))
        }
    }
}
