//
//  MockPostDetailNavigator.swift
//  BabylonPostsTests
//
//  Created by Li Linyu on 25/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import XCTest
@testable import BabylonPosts

class MockPostDetailNavigator: PostDetailNavigator {
    var backNavigatedExpectation: XCTestExpectation?
    var errorNavigatedExpectation: XCTestExpectation?
    var errorToCompare: NSError?
    var mainErrorActionToCompare: ErrorAction?
    var cancelErrorActionToCompare: ErrorAction?
    
    func navigate(to destination: PostDetailNavigatorDestination) {
        switch destination {
        case .back:
            backNavigatedExpectation?.fulfill()
        case .error(let error, let mainAction, let cancelAction):
            XCTAssertEqual(error as NSError, errorToCompare)
            XCTAssertEqual(mainAction, mainErrorActionToCompare)
            XCTAssertEqual(cancelAction, cancelErrorActionToCompare)
            errorNavigatedExpectation?.fulfill()
        }
    }
}
