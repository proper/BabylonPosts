//
//  DefaultPostDetailViewModelTests.swift
//  BabylonPostsTests
//
//  Created by Li Linyu on 24/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import XCTest
@testable import BabylonPosts

class DefaultPostDetailViewModelTests: XCTestCase {
    func test_ViewDidLoadToFetchPostDetail_Successfully() {
        let post = Post(userId: 1, id: 1, title: "TestTitle", body: "TestBody")
        
        let dataCoordinator = MockPostDetailDataCoordinator()
        let comments: [Comment] = getAsset(from: "comments_1", ofType: "json")!
        dataCoordinator.commentsToReturn = comments
        let user: User = getAsset(from: "user_1", ofType: "json")!
        dataCoordinator.userToReturn = user
        
        let navigator = MockPostDetailNavigator()
        
        let sut = DefaultPostDetailViewModel(post: post,
                                             dataCoordinator: dataCoordinator,
                                             navigator: navigator)
        
        let loadingStartedExpectation = expectation(description: "Loading should be started")
        let loadingEndedExpectation = expectation(description: "Loading ended expectation")
        sut.onLoadingStateChanged = {
            if sut.isLoading {
                loadingStartedExpectation.fulfill()
            } else {
                loadingEndedExpectation.fulfill()
            }
        }
        
        let postDetailUpdatedExpectation = expectation(description: "Post detail should be updated")
        sut.onPostDetailUpdated = {
            postDetailUpdatedExpectation.fulfill()
        }
        
        sut.viewDidLoad()
        
        waitForExpectations(timeout: 0.5) { handler in
            XCTAssertEqual(sut.author, user.name)
            XCTAssertEqual(sut.description, post.body)
            XCTAssertEqual(sut.numberOfComments, comments.count)
            XCTAssertEqual(sut.title, post.title)
            XCTAssertFalse(sut.isLoading)
        }
    }
    
    func test_ViewDidLoadToFetchPostDetail_FailedWithError() {
        let post = Post(userId: 1, id: 1, title: "TestTitle", body: "TestBody")
        
        let dataCoordinator = MockPostDetailDataCoordinator()
        let error = NSError(domain: "", code: -1009, userInfo: nil)
        dataCoordinator.errorToReturn = error
        
        let navigator = MockPostDetailNavigator()
        navigator.errorNavigatedExpectation = expectation(description: "Should navigate to show the error")
        navigator.errorToCompare = error
        navigator.mainErrorActionToCompare = ErrorAction(title: "Retry", action: nil)
        navigator.cancelErrorActionToCompare = ErrorAction(title: "OK", action: nil)
        
        let sut = DefaultPostDetailViewModel(post: post,
                                             dataCoordinator: dataCoordinator,
                                             navigator: navigator)
        
        let loadingStartedExpectation = expectation(description: "Loading should be started")
        let loadingEndedExpectation = expectation(description: "Loading ended expectation")
        sut.onLoadingStateChanged = {
            if sut.isLoading {
                loadingStartedExpectation.fulfill()
            } else {
                loadingEndedExpectation.fulfill()
            }
        }
        
        sut.onPostDetailUpdated = {
            XCTFail("onPostDetailUpdated should not be called")
        }
        
        sut.viewDidLoad()
        
        waitForExpectations(timeout: 0.5) { handler in
            XCTAssertFalse(sut.isLoading)
            XCTAssertNil(sut.author)
            XCTAssertNil(sut.numberOfComments)
            XCTAssertEqual(sut.description, post.body)
            XCTAssertEqual(sut.title, post.title)
        }
    }
}
