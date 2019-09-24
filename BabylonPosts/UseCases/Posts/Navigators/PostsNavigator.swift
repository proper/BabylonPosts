//
//  PostsNavigator.swift
//  BabylonPosts
//
//  Created by Li Linyu on 25/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import Foundation

enum PostsNavigatorDestination {
    case error(error: Error, mainAction: ErrorAction?, cancelAction: ErrorAction)
    case postDetail(post: Post)
}

protocol PostsNavigator {
    func navigate(to destination: PostsNavigatorDestination)
}
