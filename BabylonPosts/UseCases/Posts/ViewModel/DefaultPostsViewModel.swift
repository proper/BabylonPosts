//
//  DefaultPostsViewModel.swift
//  BabylonPosts
//
//  Created by Li Linyu on 21/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import Alamofire
import PromiseKit

class DefaultPostsViewModel: PostsViewModel {
    private let networkService: NetworkService

    var posts: [Post]?

    var postsUpdated: (() -> Void)?

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func fetchPosts() {
        firstly {
            networkService.fetchPosts()
        }.done { posts in
            self.posts = posts
            self.postsUpdated?()
        }.catch { error in
            let _ = error
        }
    }
}
