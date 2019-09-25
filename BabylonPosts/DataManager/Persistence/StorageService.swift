//
//  StorageService.swift
//  BabylonPosts
//
//  Created by Li Linyu on 22/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import Foundation

protocol StorageService {
    func storePosts(posts: [Post])
    func getPosts() -> [Post]?
    func storeUser(user: User)
    func getUser(for userId: Int) -> User?
    func storeComments(comments: [Comment], for postId: Int)
    func getComments(for postId: Int) -> [Comment]?
}
