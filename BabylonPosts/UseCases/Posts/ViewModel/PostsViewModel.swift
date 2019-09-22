//
//  PostsViewModel.swift
//  BabylonPosts
//
//  Created by Li Linyu on 21/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import Foundation

protocol PostsViewModel {
    var posts: [Post]? { get }

    // Simple binding
    var postsUpdated: (() -> Void)? { get set }

    func fetchPosts()
}
