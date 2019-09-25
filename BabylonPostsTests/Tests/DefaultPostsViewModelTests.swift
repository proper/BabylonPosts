//
//  DefaultPostsViewModelTests.swift
//  BabylonPostsTests
//
//  Created by Li Linyu on 25/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import XCTest
@testable import BabylonPosts
import PromiseKit

class DefaultPostsViewModelTests: XCTestCase {
    private var dataCoordinator: MockPostsDataCoordinator!
    private var navigator: MockPostsNavigator!

    override func setUp() {
        super.setUp()

        dataCoordinator = MockPostsDataCoordinator()
        navigator = MockPostsNavigator()
    }

    override func tearDown() {
        dataCoordinator = nil
        navigator = nil

        super.tearDown()
    }

    func test_ViewDidLoadToFetchPosts_Successfully() {
        // GIVEN The sut is created with a dataCoordinator and a navigator
        let posts: [Post] = getAsset(from: "posts", ofType: "json")!
        dataCoordinator.postsToReturn = posts
        let sut = DefaultPostsViewModel(dataCoordinator: dataCoordinator, navigator: navigator)

        // GIVEN we expect the posts to be updated
        let postsUpdatedExpectation = expectation(description: "Posts should be updated")
        sut.onPostsUpdated = {
            // THEN the posts updated and the loading stopped
            XCTAssertFalse(sut.isLoading)
            postsUpdatedExpectation.fulfill()
        }

        // GIVEN we expect the loading state to be changed
        let loadingStartedExpectation = expectation(description: "Loading should be started")
        let loadingEndedExpectation = expectation(description: "Loading ended expectation")
        sut.onLoadingStateChanged = {
            if sut.isLoading {
                // THEN the loading should start
                loadingStartedExpectation.fulfill()
            } else {
                // THEN the loading should end
                loadingEndedExpectation.fulfill()
            }
        }

        // WHEN viewDidLoad is called on sut
        sut.viewDidLoad()
        
        waitForExpectations(timeout: 0.5) { handler in
            // THEN the loading should end
            XCTAssertFalse(sut.isLoading)
            // THEN the total number of posts is set correctly
            XCTAssertEqual(sut.posts?.count, 100)
        }
    }
    
    func test_ViewDidLoadToFetchPosts_FailedWithError() {
        // GIVEN The dataCoordinator will return an error
        let error = NSError(domain: "", code: -1009, userInfo: nil)
        dataCoordinator.errorToReturn = error

        // GIVEN The navigator has some expected elements to compare
        navigator.errorNavigatedExpectation = expectation(description: "Should navigate to show the error")
        navigator.errorToCompare = error
        navigator.mainErrorActionToCompare = ErrorAction(title: "Retry", action: nil)
        navigator.cancelErrorActionToCompare = ErrorAction(title: "OK", action: nil)

        // GIVEN The sut is created with a dataCoordinator and a navigator
        let sut = DefaultPostsViewModel(dataCoordinator: dataCoordinator, navigator: navigator)
        
        sut.onPostsUpdated = {
            // TEHN the posts should not be updated
            XCTFail("onPostsUpdated should not be called")
        }

        // GIVEN we expect the loading state to be changed
        let loadingStartedExpectation = expectation(description: "Loading should be started")
        let loadingEndedExpectation = expectation(description: "Loading ended expectation")
        sut.onLoadingStateChanged = {
            if sut.isLoading {
                // THEN the loading should start
                loadingStartedExpectation.fulfill()
            } else {
                // THEN the loading should end
                loadingEndedExpectation.fulfill()
            }
        }

        // WHEN viewDidLoad is called on sut
        sut.viewDidLoad()
        
        waitForExpectations(timeout: 0.5) { handler in
            // THEN the loading should end
            XCTAssertFalse(sut.isLoading)
            // THEN there should be no posts set
            XCTAssertNil(sut.posts)
        }
    }
    
    func test_RefreshStartedToFetchPosts_Successfully() {
        // GIVEN dummy posts should be returned
        let posts: [Post] = getAsset(from: "posts", ofType: "json")!
        dataCoordinator.postsToReturn = posts

        // GIVEN The sut is created with a dataCoordinator and a navigator
        let sut = DefaultPostsViewModel(dataCoordinator: dataCoordinator, navigator: navigator)

        // GIVEN we expect the posts to be updated
        let postsUpdatedExpectation = expectation(description: "Posts should be updated")
        sut.onPostsUpdated = {
            // THEN the loading should end
            XCTAssertFalse(sut.isLoading)
            postsUpdatedExpectation.fulfill()
        }

        // GIVEN we expect the loading state to be changed
        let loadingStartedExpectation = expectation(description: "Loading should be started")
        let loadingEndedExpectation = expectation(description: "Loading ended expectation")
        sut.onLoadingStateChanged = {
            if sut.isLoading {
                // THEN the loading should start
                loadingStartedExpectation.fulfill()
            } else {
                // THEN the loading should end
                loadingEndedExpectation.fulfill()
            }
        }

        // WHEN refreshStarted is called on sut
        sut.refreshStarted()
        
        waitForExpectations(timeout: 0.5) { handler in
            // THEN the loading should end
            XCTAssertFalse(sut.isLoading)
            // THEN the total number of posts is set correctly
            XCTAssertEqual(sut.posts?.count, 100)
        }
    }
    
    func test_RefreshStartedToFetchPosts_FailedWithError() {
        // GIVEN The dataCoordinator will return an error
        let error = NSError(domain: "", code: -1009, userInfo: nil)
        dataCoordinator.errorToReturn = error

        // GIVEN The navigator has some expected elements to compare
        navigator.errorNavigatedExpectation = expectation(description: "Should navigate to show the error")
        navigator.errorToCompare = error
        navigator.mainErrorActionToCompare = ErrorAction(title: "Retry", action: nil)
        navigator.cancelErrorActionToCompare = ErrorAction(title: "OK", action: nil)

        // GIVEN The sut is created with a dataCoordinator and a navigator
        let sut = DefaultPostsViewModel(dataCoordinator: dataCoordinator, navigator: navigator)
        
        sut.onPostsUpdated = {
            // TEHN the posts should not be updated
            XCTFail("onPostsUpdated should not be called")
        }
        
        // GIVEN we expect the loading state to be changed
        let loadingStartedExpectation = expectation(description: "Loading should be started")
        let loadingEndedExpectation = expectation(description: "Loading ended expectation")
        sut.onLoadingStateChanged = {
            if sut.isLoading {
                // THEN the loading should start
                loadingStartedExpectation.fulfill()
            } else {
                // THEN the loading should end
                loadingEndedExpectation.fulfill()
            }
        }

        // WHEN refreshStarted is called on sut
        sut.refreshStarted()
        
        waitForExpectations(timeout: 0.5) { handler in
            // THEN the loading should end
            XCTAssertFalse(sut.isLoading)
            // THEN there should be no posts set
            XCTAssertNil(sut.posts)
        }
    }
    
    func test_PostViewModelTapped_NavigatedToPostDetail() {
        // GIVEN The posts expected to be returned are defined
        let posts: [Post] = getAsset(from: "posts", ofType: "json")!
        let post = posts[0]
        dataCoordinator.postsToReturn = posts

        // GIVEN we expect the post detail to be navigated to
        navigator.postDetailNavigatedExpectation = expectation(description: "Should be navigated to post detail")
        navigator.postToCompare = post

        // GIVEN sut is created with a dataCoordinator and a navigator
        let sut = DefaultPostsViewModel(dataCoordinator: dataCoordinator, navigator: navigator)

        // WHEN postTapped is called on sut with given post
        sut.postTapped(post: post)
        
        waitForExpectations(timeout: 0.5, handler: nil)
    }
}
