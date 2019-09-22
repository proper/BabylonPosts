//
//  PostsNavigator.swift
//  BabylonPosts
//
//  Created by Li Linyu on 21/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import Foundation

enum PostsNavigatorDestination {
    case back
    case error(error: NSError)
    case posts
    case postDetail(post: Post)
}

protocol PostsNavigator {
    func navigate(to destination: PostsNavigatorDestination)
}
