//
//  NetworkService.swift
//  BabylonPosts
//
//  Created by Li Linyu on 22/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import Foundation
import PromiseKit

protocol NetworkService {
    func fetchPosts() -> Promise<[Post]>
    func fetchUser(for userId: Int) -> Promise<User>
    func fetchComments(for postId: Int) -> Promise<[Comment]>
}
