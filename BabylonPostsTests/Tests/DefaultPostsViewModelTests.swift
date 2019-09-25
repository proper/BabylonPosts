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
    func test_ViewDidLoadToFetchPosts_Successfully() {
        let posts: [Post] = getAsset(from: "posts", ofType: "json")!
        
        let dataCoordinator = MockPostsDataCoordinator()
        dataCoordinator.postsToReturn = posts
        
        let navigator = MockPostsNavigator()
        
        let sut = DefaultPostsViewModel(dataCoordinator: dataCoordinator, navigator: navigator)
        
        let postsUpdatedExpectation = expectation(description: "Posts should be updated")
        sut.onPostsUpdated = {
            XCTAssertFalse(sut.isLoading)
            postsUpdatedExpectation.fulfill()
        }
        
        let loadingStartedExpectation = expectation(description: "Loading should be started")
        let loadingEndedExpectation = expectation(description: "Loading ended expectation")
        sut.onLoadingStateChanged = {
            if sut.isLoading {
                loadingStartedExpectation.fulfill()
            } else {
                loadingEndedExpectation.fulfill()
            }
        }
        
        sut.viewDidLoad()
        
        waitForExpectations(timeout: 0.5) { handler in
            
        }
    }
    
    func test_ViewDidLoadToFetchPosts_FailedWithError() {
        let dataCoordinator = MockPostsDataCoordinator()
        let error = NSError(domain: "", code: -1009, userInfo: nil)
        dataCoordinator.errorToReturn = error
        
        let navigator = MockPostsNavigator()
        navigator.errorNavigatedExpectation = expectation(description: "Should navigate to show the error")
        navigator.errorToCompare = error
        navigator.mainErrorActionToCompare = ErrorAction(title: "Retry", action: nil)
        navigator.cancelErrorActionToCompare = ErrorAction(title: "OK", action: nil)
        
        let sut = DefaultPostsViewModel(dataCoordinator: dataCoordinator, navigator: navigator)
        
        sut.onPostsUpdated = {
            XCTFail("onPostsUpdated should not be called")
        }
        
        let loadingStartedExpectation = expectation(description: "Loading should be started")
        let loadingEndedExpectation = expectation(description: "Loading ended expectation")
        sut.onLoadingStateChanged = {
            if sut.isLoading {
                loadingStartedExpectation.fulfill()
            } else {
                loadingEndedExpectation.fulfill()
            }
        }
        
        sut.viewDidLoad()
        
        waitForExpectations(timeout: 0.5) { handler in
            XCTAssertFalse(sut.isLoading)
        }
    }
    
    func test_RefreshStartedToFetchPosts_Successfully() {
        let posts: [Post] = getAsset(from: "posts", ofType: "json")!
        
        let dataCoordinator = MockPostsDataCoordinator()
        dataCoordinator.postsToReturn = posts
        
        let navigator = MockPostsNavigator()
        
        let sut = DefaultPostsViewModel(dataCoordinator: dataCoordinator, navigator: navigator)
        
        let postsUpdatedExpectation = expectation(description: "Posts should be updated")
        sut.onPostsUpdated = {
            XCTAssertFalse(sut.isLoading)
            postsUpdatedExpectation.fulfill()
        }
        
        let loadingStartedExpectation = expectation(description: "Loading should be started")
        let loadingEndedExpectation = expectation(description: "Loading ended expectation")
        sut.onLoadingStateChanged = {
            if sut.isLoading {
                loadingStartedExpectation.fulfill()
            } else {
                loadingEndedExpectation.fulfill()
            }
        }
        
        sut.refreshStarted()
        
        waitForExpectations(timeout: 0.5) { handler in
            
        }
    }
    
    func test_RefreshStartedToFetchPosts_FailedWithError() {
        let dataCoordinator = MockPostsDataCoordinator()
        let error = NSError(domain: "", code: -1009, userInfo: nil)
        dataCoordinator.errorToReturn = error
        
        let navigator = MockPostsNavigator()
        navigator.errorNavigatedExpectation = expectation(description: "Should navigate to show the error")
        navigator.errorToCompare = error
        navigator.mainErrorActionToCompare = ErrorAction(title: "Retry", action: nil)
        navigator.cancelErrorActionToCompare = ErrorAction(title: "OK", action: nil)
        
        let sut = DefaultPostsViewModel(dataCoordinator: dataCoordinator, navigator: navigator)
        
        sut.onPostsUpdated = {
            XCTFail("onPostsUpdated should not be called")
        }
        
        let loadingStartedExpectation = expectation(description: "Loading should be started")
        let loadingEndedExpectation = expectation(description: "Loading ended expectation")
        sut.onLoadingStateChanged = {
            if sut.isLoading {
                loadingStartedExpectation.fulfill()
            } else {
                loadingEndedExpectation.fulfill()
            }
        }
        
        sut.refreshStarted()
        
        waitForExpectations(timeout: 0.5) { handler in
            XCTAssertFalse(sut.isLoading)
        }
    }
}
