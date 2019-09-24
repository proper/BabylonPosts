//
//  DefaultPostDetailViewModel.swift
//  BabylonPosts
//
//  Created by Li Linyu on 22/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import Foundation
import PromiseKit

final class DefaultPostDetailViewModel: PostDetailViewModel {
    var description: String?
    var author: String?
    var numberOfComments: Int?
    var title: String?

    var isLoading: Bool {
        didSet {
            self.onLoadingStateChanged?()
        }
    }

    // Binding
    var onLoadingStateChanged: (() -> Void)?
    var onPostDetailUpdated: (() -> Void)?

    let post: Post
    let dataCoordinator: PostDetailDataCoordinator
    let navigator: PostDetailNavigator

    init(post: Post, dataCoordinator: PostDetailDataCoordinator, navigator: PostDetailNavigator) {
        self.post = post
        self.description = post.body
        self.title = post.title
        self.dataCoordinator = dataCoordinator
        self.navigator = navigator
        self.isLoading = false
    }

    func viewDidLoad() {
        fetchPostDetail()
    }

    private func fetchPostDetail() {
        isLoading = true

        // Demo the synchronization
        firstly {
            when(fulfilled: dataCoordinator.fetchUser(for: post.userId), dataCoordinator.fetchComments(for: post.id))
        }.done { (user, comments) in
            self.isLoading = false
            self.author = user.name
            self.numberOfComments = comments.count
            self.onPostDetailUpdated?()
        }.catch { error in
            self.isLoading = false
            self.handleError(error: error)
        }
    }

    private func handleError(error: Error) {
        let mainAction = ErrorAction(title: NSLocalizedString("error_button_retry", comment: "")) { [weak self] in
            self?.fetchPostDetail()
        }
        let cancelAction = ErrorAction(title: NSLocalizedString("ok", comment: "")) { [weak self] in
            self?.navigator.navigate(to: .back)
        }
        navigator.navigate(to: .error(error: error, mainAction: mainAction, cancelAction: cancelAction))
    }
}
