//
//  Resource.swift
//  BabylonPosts
//
//  Created by Li Linyu on 22/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import Alamofire

enum Resource {
    case posts
    case user(userId: Int)
    case comments(postId: Int)

    public var resource: (method: HTTPMethod, route: String) {
        switch self {
        case .posts:
            return (.get, "/posts")
        case .user(let userId):
            return (.get, "/users/\(userId)")
        case .comments(let postId):
            return (.get, "/comments?postId=\(postId)")
        }
    }
}
