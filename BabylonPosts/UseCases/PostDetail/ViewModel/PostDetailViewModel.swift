//
//  PostDetailViewModel.swift
//  BabylonPosts
//
//  Created by Li Linyu on 21/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import Foundation

protocol PostDetailViewModel {
    var post: Post { get }
    var description: String? { get }
    var author: String? { get }
    var numberOfComments: Int? { get }
    var title: String? { get }

    // Simple binding
    var postDetailUpdated: (() -> Void)? { get set }

    func fetchPostDetail()
}
