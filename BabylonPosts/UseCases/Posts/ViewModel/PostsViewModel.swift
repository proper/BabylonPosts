//
//  PostsViewModel.swift
//  BabylonPosts
//
//  Created by Li Linyu on 21/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import Foundation

protocol PostsViewModel: PostViewModelDelegate {
    var posts: [Post]? { get }
    var isLoading: Bool { get }

    // Simple binding
    var onLoadingStateChanged: (() -> Void)? { get set }
    var onPostsUpdated: (() -> Void)? { get set }

    func fetchPosts()
}
