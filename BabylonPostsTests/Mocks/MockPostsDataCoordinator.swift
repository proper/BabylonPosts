//
//  MockPostsDataCoordinator.swift
//  BabylonPostsTests
//
//  Created by Li Linyu on 25/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import XCTest
@testable import BabylonPosts
import PromiseKit

class MockPostsDataCoordinator: PostsDataCoordinator {
    var errorToReturn: Error?
    var postsToReturn: [Post]?
    
    func fetchPosts() -> Promise<[Post]> {
        return Promise { seal in
            if let errorToReturn = errorToReturn {
                seal.resolve(nil, errorToReturn)
            } else if let postsToReturn = postsToReturn {
                seal.resolve(postsToReturn, nil)
            }
        }
    }
}
