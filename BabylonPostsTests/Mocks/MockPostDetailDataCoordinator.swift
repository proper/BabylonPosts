//
//  MockPostDetailDataCoordinator.swift
//  BabylonPostsTests
//
//  Created by Li Linyu on 25/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import XCTest
@testable import BabylonPosts
import PromiseKit

class MockPostDetailDataCoordinator: PostDetailDataCoordinator {
    var errorToReturn: Error?
    var userToReturn: User?
    var commentsToReturn: [Comment]?
    
    func fetchUser(for userId: Int) -> Promise<User> {
        return Promise { seal in
            if let errorToReturn = errorToReturn {
                seal.resolve(nil, errorToReturn)
            } else if let userToReturn = userToReturn {
                seal.resolve(userToReturn, nil)
            }
        }
    }
    
    func fetchComments(for postId: Int) -> Promise<[Comment]> {
        return Promise { seal in
            if let errorToReturn = errorToReturn {
                seal.resolve(nil, errorToReturn)
            } else if let commentsToReturn = commentsToReturn {
                seal.resolve(commentsToReturn, nil)
            }
        }
    }
}
