//
//  PostsNavigator.swift
//  BabylonPosts
//
//  Created by Li Linyu on 21/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import Foundation

struct ErrorAction {
    let title: String
    var action: (() -> Void)?
}

enum PostsNavigatorDestination {
    case back
    case error(error: Error, mainAction: ErrorAction?, cancelAction: ErrorAction)
    case posts
    case postDetail(post: Post)
}

protocol PostsNavigator {
    func navigate(to destination: PostsNavigatorDestination)
}
