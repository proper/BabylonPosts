//
//  DefaultPostViewModel.swift
//  BabylonPosts
//
//  Created by Li Linyu on 21/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import Foundation

struct DefaultPostViewModel: PostViewModel {
    weak var delegate: PostViewModelDelegate?

    var post: Post
    var title: String

    init(post: Post) {
        self.post = post
        self.title = post.title
    }

    func postTapped() {
        delegate?.postTapped(post: post)
    }
}
