//
//  PostsViewModel.swift
//  BabylonPosts
//
//  Created by Li Linyu on 21/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import Foundation

protocol PostsViewModel: PostViewModelDelegate {
    var posts: [PostViewModel]? { get }
    var isLoading: Bool { get }

    // Simple binding
    var onLoadingStateChanged: (() -> Void)? { get set }
    var onPostsUpdated: (() -> Void)? { get set }

    // View events
    func viewDidLoad()
    func refreshStarted()
}
