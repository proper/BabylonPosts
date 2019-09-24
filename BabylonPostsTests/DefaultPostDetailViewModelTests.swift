//
//  DefaultPostDetailViewModelTests.swift
//  BabylonPostsTests
//
//  Created by Li Linyu on 24/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import XCTest
@testable import BabylonPosts
import PromiseKit

class DefaultPostDetailViewModelTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_PostDetailViewDidLoad() {
        let post = Post(userId: 1, id: 1, title: "TestTitle", body: "TestBody")
        let dataCoordinator = MockPostDetailDataCoordinator()
        let navigator = MockPostDetailNavigator()
        
        let sut = DefaultPostDetailViewModel(post: post,
                                             dataCoordinator: dataCoordinator,
                                             navigator: navigator)
        
        sut.onLoadingStateChanged = {
            
        }
        
        sut.onPostDetailUpdated = {
            
        }
        
        sut.viewDidLoad()
    }

}

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

class MockPostDetailNavigator: PostDetailNavigator {
    func navigate(to destination: PostDetailNavigatorDestination) {
        
    }
}
