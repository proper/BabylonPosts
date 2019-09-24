//
//  DefaultDataCoordinator.swift
//  BabylonPosts
//
//  Created by Li Linyu on 22/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire

class DefaultDataCoordinator: DataCoordinator {
    private let networkService: NetworkService
    private let storageService: StorageService

    init(networkService: NetworkService, storageService: StorageService) {
        self.networkService = networkService
        self.storageService = storageService
    }

    func fetchPosts() -> Promise<[Post]> {
        return Promise { seal in
            firstly {
                networkService.fetchPosts()
            }.done { posts in
                self.storageService.storePosts(posts: posts)
                seal.resolve(posts, nil)
            }.catch { error in
                if error.isOfflineError, let posts = self.storageService.getPosts() {
                    seal.resolve(posts, nil)
                } else {
                    seal.resolve(nil, error)
                }
            }
        }
    }

    func fetchUser(for userId: Int) -> Promise<User> {
        return Promise { seal in
            firstly {
                networkService.fetchUser(for: userId)
            }.done { user in
                self.storageService.storeUser(user: user)
                seal.resolve(user, nil)
            }.catch { error in
                if error.isOfflineError, let user = self.storageService.getUser(for: userId) {
                    seal.resolve(user, nil)
                } else {
                    seal.resolve(nil, error)
                }
            }

        }
    }

    func fetchComments(for postId: Int) -> Promise<[Comment]> {
        return Promise { seal in
            firstly {
                networkService.fetchComments(for: postId)
            }.done { comments in
                self.storageService.storeComments(comments: comments, for: postId)
                seal.resolve(comments, nil)
            }.catch { error in
                if error.isOfflineError, let comments = self.storageService.getComments(for: postId) {
                    seal.resolve(comments, nil)
                } else {
                    seal.resolve(nil, error)
                }
            }
        }
    }
}

// MARK: - Check if the error is an offline error
private extension Error {
    var isOfflineError: Bool {
        if let afError = self as? AFError,
            let nsError = afError.underlyingError as NSError?,
            nsError.code == NSURLErrorNotConnectedToInternet {
            return true
        }
        
        return false
    }
}
