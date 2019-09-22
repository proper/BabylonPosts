//
//  DefaultPostViewModel.swift
//  BabylonPosts
//
//  Created by Li Linyu on 21/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import Foundation

struct DefaultPostViewModel: PostViewModel {
    var title: String

    init(post: Post) {
        self.title = post.title
    }
}
