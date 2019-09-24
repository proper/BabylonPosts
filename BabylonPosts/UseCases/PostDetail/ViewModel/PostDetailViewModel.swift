//
//  PostDetailViewModel.swift
//  BabylonPosts
//
//  Created by Li Linyu on 21/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import Foundation
import PromiseKit

protocol PostDetailDataCoordinator {
    func fetchUser(for userId: Int) -> Promise<User>
    func fetchComments(for postId: Int) -> Promise<[Comment]>
}

protocol PostDetailViewModel {
    var dataCoordinator: PostDetailDataCoordinator { get }
    var navigator: PostDetailNavigator { get }
    var post: Post { get }
    var description: String? { get }
    var author: String? { get }
    var numberOfComments: Int? { get }
    var title: String? { get }
    var isLoading: Bool { get }

    // Simple binding
    var onLoadingStateChanged: (() -> Void)? { get set }
    var onPostDetailUpdated: (() -> Void)? { get set }

    // View events
    func viewDidLoad()
}
