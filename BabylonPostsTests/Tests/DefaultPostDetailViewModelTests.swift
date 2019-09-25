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
    private var dataCoordinator: MockPostDetailDataCoordinator!
    private var navigator: MockPostDetailNavigator!

    override func setUp() {
        super.setUp()

        dataCoordinator = MockPostDetailDataCoordinator()
        navigator = MockPostDetailNavigator()
    }

    override func tearDown() {
        dataCoordinator = nil
        navigator = nil

        super.tearDown()
    }

    func test_ViewDidLoadToFetchPostDetail_Successfully() {
        // GIVEN dumpy user and comments to be returned
        let comments: [Comment] = getAsset(from: "comments_1", ofType: "json")!
        dataCoordinator.commentsToReturn = comments
        let user: User = getAsset(from: "user_1", ofType: "json")!
        dataCoordinator.userToReturn = user

        // GIVEN The sut is created with a dummy post, a dataCoordinator and a navigator
        let post = Post(userId: 1, id: 1, title: "TestTitle", body: "TestBody")
        let sut = DefaultPostDetailViewModel(post: post,
                                             dataCoordinator: dataCoordinator,
                                             navigator: navigator)

        // THEN the sut's description and title should be set
        XCTAssertEqual(sut.description, post.body)
        XCTAssertEqual(sut.title, post.title)
        // THEN the sut's author and numberOfComments should be nil
        XCTAssertNil(sut.author)
        XCTAssertNil(sut.numberOfComments)
        // THEN the sut's should not be loading
        XCTAssertFalse(sut.isLoading)
        
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

        // GIVEN we expect the post detail to be updated
        let postDetailUpdatedExpectation = expectation(description: "Post detail should be updated")
        sut.onPostDetailUpdated = {
            // THEN the sut's author and numberOfComments should be updated
            XCTAssertEqual(sut.author, user.name)
            XCTAssertEqual(sut.numberOfComments, comments.count)
            postDetailUpdatedExpectation.fulfill()
        }

        // WHEN viewDidLoad is called on sut
        sut.viewDidLoad()
        
        waitForExpectations(timeout: 0.5) { handler in
            // THEN the view model's view viriables should be set correctly
            XCTAssertEqual(sut.author, user.name)
            XCTAssertEqual(sut.description, post.body)
            XCTAssertEqual(sut.numberOfComments, comments.count)
            XCTAssertEqual(sut.title, post.title)
            XCTAssertFalse(sut.isLoading)
        }
    }
    
    func test_ViewDidLoadToFetchPostDetail_SuccessfullyNoComments() {
        // GIVEN empty comments and a user to be returned
        dataCoordinator.commentsToReturn = [Comment]()
        let user: User = getAsset(from: "user_1", ofType: "json")!
        dataCoordinator.userToReturn = user

        // GIVEN The sut is created with a post, a dataCoordinator and a navigator
        let post = Post(userId: 1, id: 1, title: "TestTitle", body: "TestBody")
        let sut = DefaultPostDetailViewModel(post: post,
                                             dataCoordinator: dataCoordinator,
                                             navigator: navigator)

        // THEN the sut's description and title should be set
        XCTAssertEqual(sut.description, post.body)
        XCTAssertEqual(sut.title, post.title)
        // THEN the sut's author and numberOfComments should be nil
        XCTAssertNil(sut.author)
        XCTAssertNil(sut.numberOfComments)
        // THEN the sut's should not be loading
        XCTAssertFalse(sut.isLoading)
        
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

        // GIVEN we expect the post detail to be updated
        let postDetailUpdatedExpectation = expectation(description: "Post detail should be updated")
        sut.onPostDetailUpdated = {
            // THEN the sut's author and numberOfComments should be updated
            XCTAssertEqual(sut.author, user.name)
            XCTAssertEqual(sut.numberOfComments, 0)
            postDetailUpdatedExpectation.fulfill()
        }

        // WHEN viewDidLoad is called on sut
        sut.viewDidLoad()

        waitForExpectations(timeout: 0.5) { handler in
            // THEN the view model's view viriables should be set correctly
            XCTAssertEqual(sut.author, user.name)
            XCTAssertEqual(sut.description, post.body)
            XCTAssertEqual(sut.numberOfComments, 0)
            XCTAssertEqual(sut.title, post.title)
            XCTAssertFalse(sut.isLoading)
        }
    }
    
    func test_ViewDidLoadToFetchPostDetail_FailedToGetBothUserAndComments() {
        // GIVEN The dataCoordinator will return an error
        let error = NSError(domain: "", code: -1009, userInfo: nil)
        dataCoordinator.errorToReturn = error

        // GIVEN The navigator has some expected elements to compare
        navigator.errorNavigatedExpectation = expectation(description: "Should navigate to show the error")
        navigator.errorToCompare = error
        navigator.mainErrorActionToCompare = ErrorAction(title: "Retry", action: nil)
        navigator.cancelErrorActionToCompare = ErrorAction(title: "OK", action: nil)

        // GIVEN The sut is created with a post, a dataCoordinator and a navigator
        let post = Post(userId: 1, id: 1, title: "TestTitle", body: "TestBody")
        let sut = DefaultPostDetailViewModel(post: post,
                                             dataCoordinator: dataCoordinator,
                                             navigator: navigator)

        // THEN the sut's description and title should be set
        XCTAssertEqual(sut.description, post.body)
        XCTAssertEqual(sut.title, post.title)
        // THEN the sut's author and numberOfComments should be nil
        XCTAssertNil(sut.author)
        XCTAssertNil(sut.numberOfComments)
        // THEN the sut's should not be loading
        XCTAssertFalse(sut.isLoading)
        
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
        
        sut.onPostDetailUpdated = {
            // TEHN the post detail should not be updated
            XCTFail("onPostDetailUpdated should not be called")
        }

        // WHEN viewDidLoad is called on sut
        sut.viewDidLoad()
        
        waitForExpectations(timeout: 0.5) { handler in
            // THEN the view model's view variables should be set correctly
            XCTAssertFalse(sut.isLoading)
            XCTAssertNil(sut.author)
            XCTAssertNil(sut.numberOfComments)
            XCTAssertEqual(sut.description, post.body)
            XCTAssertEqual(sut.title, post.title)
        }
    }
    
    func test_ViewDidLoadToFetchPostDetail_FailedToGetUser() {
        // GIVEN The dataCoordinator will return an error for fetching user
        let error = NSError(domain: "", code: -1009, userInfo: nil)
        dataCoordinator.errorToReturn = error
        let comments: [Comment] = getAsset(from: "comments_1", ofType: "json")!
        dataCoordinator.commentsToReturn = comments

        // GIVEN The navigator has some expected elements to compare
        navigator.errorNavigatedExpectation = expectation(description: "Should navigate to show the error")
        navigator.errorToCompare = error
        navigator.mainErrorActionToCompare = ErrorAction(title: "Retry", action: nil)
        navigator.cancelErrorActionToCompare = ErrorAction(title: "OK", action: nil)

        // GIVEN The sut is created with a post, a dataCoordinator and a navigator
        let post = Post(userId: 1, id: 1, title: "TestTitle", body: "TestBody")
        let sut = DefaultPostDetailViewModel(post: post,
                                             dataCoordinator: dataCoordinator,
                                             navigator: navigator)

        // THEN the sut's description and title should be set
        XCTAssertEqual(sut.description, post.body)
        XCTAssertEqual(sut.title, post.title)
        // THEN the sut's author and numberOfComments should be nil
        XCTAssertNil(sut.author)
        XCTAssertNil(sut.numberOfComments)
        // THEN the sut's should not be loading
        XCTAssertFalse(sut.isLoading)
        
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
        
        sut.onPostDetailUpdated = {
            // TEHN the post detail should not be updated
            XCTFail("onPostDetailUpdated should not be called")
        }

        // WHEN viewDidLoad is called on sut
        sut.viewDidLoad()
        
        waitForExpectations(timeout: 0.5) { handler in
            // THEN the view model's view viriables should be set correctly
            XCTAssertFalse(sut.isLoading)
            XCTAssertNil(sut.author)
            XCTAssertNil(sut.numberOfComments)
            XCTAssertEqual(sut.description, post.body)
            XCTAssertEqual(sut.title, post.title)
        }
    }
    
    func test_ViewDidLoadToFetchPostDetail_FailedToGetComments() {
        // GIVEN The dataCoordinator will return an error for fetching comments
        let error = NSError(domain: "", code: -1009, userInfo: nil)
        dataCoordinator.errorToReturn = error
        let user: User = getAsset(from: "user_1", ofType: "json")!
        dataCoordinator.userToReturn = user

        // GIVEN The navigator has some expected elements to compare
        navigator.errorNavigatedExpectation = expectation(description: "Should navigate to show the error")
        navigator.errorToCompare = error
        navigator.mainErrorActionToCompare = ErrorAction(title: "Retry", action: nil)
        navigator.cancelErrorActionToCompare = ErrorAction(title: "OK", action: nil)

        // GIVEN The sut is created with a post, a dataCoordinator and a navigator
        let post = Post(userId: 1, id: 1, title: "TestTitle", body: "TestBody")
        let sut = DefaultPostDetailViewModel(post: post,
                                             dataCoordinator: dataCoordinator,
                                             navigator: navigator)

        // THEN the sut's description and title should be set
        XCTAssertEqual(sut.description, post.body)
        XCTAssertEqual(sut.title, post.title)
        // THEN the sut's author and numberOfComments should be nil
        XCTAssertNil(sut.author)
        XCTAssertNil(sut.numberOfComments)
        // THEN the sut's should not be loading
        XCTAssertFalse(sut.isLoading)
        
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
        
        sut.onPostDetailUpdated = {
            // TEHN the post detail should not be updated
            XCTFail("onPostDetailUpdated should not be called")
        }

        // WHEN viewDidLoad is called on sut
        sut.viewDidLoad()
        
        waitForExpectations(timeout: 0.5) { handler in
            // THEN the view model's view viriables should be set correctly
            XCTAssertFalse(sut.isLoading)
            XCTAssertNil(sut.author)
            XCTAssertNil(sut.numberOfComments)
            XCTAssertEqual(sut.description, post.body)
            XCTAssertEqual(sut.title, post.title)
        }
    }
}
