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

    init(post: Post, networkService: NetworkService) {
        self.post = post
        self.description = post.body
        self.title = post.title
        self.networkService = networkService
    }

    func fetchPostDetail() {
        // To demo the synchronization
        firstly {
            when(fulfilled: networkService.fetchUser(for: post.userId), networkService.fetchComments(for: post.id))
        }.done { (user, comments) in
            self.author = user.name
            self.numberOfComments = comments.count
            self.postDetailUpdated?()
        }.catch { error in
            let _ = error
        }
    }
}
