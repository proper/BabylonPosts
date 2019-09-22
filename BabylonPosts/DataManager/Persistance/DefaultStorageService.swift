//
//  DefaultStorageService.swift
//  BabylonPosts
//
//  Created by Li Linyu on 22/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import Foundation

class DefaultStorageService: StorageService {
    private enum FileName {
        case posts
        case user(userId: Int)
        case comments(postId: Int)

        var jsonFileName: String {
            switch self {
            case .posts:
                return "posts.json"
            case .user(let userId):
                return "user_\(userId).json"
            case .comments(let postId):
                return "comments_\(postId).json"
            }
        }
    }

    func storePosts(posts: [Post]) {
        Storage.store(posts, to: .caches, as: FileName.posts.jsonFileName)
    }

    func storeUser(user: User) {
        Storage.store(user, to: .caches, as: FileName.user(userId: user.id).jsonFileName)
    }

    func storeComments(comments: [Comment], for postId: Int) {
        Storage.store(comments, to: .caches, as: FileName.comments(postId: postId).jsonFileName)
    }

    func getPosts() -> [Post]? {
        return Storage.retrieve(FileName.posts.jsonFileName, from: .caches, as: [Post].self)
    }

    func getUser(for userId: Int) -> User? {
        return Storage.retrieve(FileName.user(userId: userId).jsonFileName, from: .caches, as: User.self)
    }

    func getComments(for postId: Int) -> [Comment]? {
        return Storage.retrieve(FileName.comments(postId: postId).jsonFileName, from: .caches, as: [Comment].self)
    }
}
