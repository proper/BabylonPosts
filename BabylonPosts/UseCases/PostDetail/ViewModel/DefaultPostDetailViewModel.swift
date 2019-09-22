//
//  DefaultPostDetailViewModel.swift
//  BabylonPosts
//
//  Created by Li Linyu on 22/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import PromiseKit

class DefaultPostDetailViewModel: PostDetailViewModel {
    var description: String?
    var author: String?
    var numberOfComments: Int?
    var title: String?

    var postDetailUpdated: (() -> Void)?

    let post: Post
    private let networkService: NetworkService
    private let navigator: PostsNavigator

    init(post: Post, networkService: NetworkService, navigator: PostsNavigator) {
        self.post = post
        self.description = post.body
        self.title = post.title
        self.networkService = networkService
        self.navigator = navigator
    }

    func fetchPostDetail() {
        // Demo the synchronization
        firstly {
            when(fulfilled: networkService.fetchUser(for: post.userId), networkService.fetchComments(for: post.id))
        }.done { (user, comments) in
            self.author = user.name
            self.numberOfComments = comments.count
            self.postDetailUpdated?()
        }.catch { error in
            self.handleError(error: error)
        }
    }

    private func handleError(error: Error) {
        DispatchQueue.main.async {
            self.navigator.navigate(to: .error(error: error))
        }
    }
}
