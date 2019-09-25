//
//  MockPostsNavigator.swift
//  BabylonPostsTests
//
//  Created by Li Linyu on 25/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import XCTest
@testable import BabylonPosts

class MockPostsNavigator: PostsNavigator {
    var postDetailNavigatedExpectation: XCTestExpectation?
    var postToCompare: Post?
    var errorNavigatedExpectation: XCTestExpectation?
    var errorToCompare: NSError?
    var mainErrorActionToCompare: ErrorAction?
    var cancelErrorActionToCompare: ErrorAction?
    
    func navigate(to destination: PostsNavigatorDestination) {
        switch destination {
        case .postDetail(let post):
            XCTAssertEqual(post, postToCompare)
            postDetailNavigatedExpectation?.fulfill()
        case .error(let error, let mainAction, let cancelAction):
            XCTAssertEqual(error as NSError, errorToCompare)
            XCTAssertEqual(mainAction, mainErrorActionToCompare)
            XCTAssertEqual(cancelAction, cancelErrorActionToCompare)
            errorNavigatedExpectation?.fulfill()
        }
    }
}
