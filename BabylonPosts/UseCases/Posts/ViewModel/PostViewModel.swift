//
//  PostViewModel.swift
//  BabylonPosts
//
//  Created by Li Linyu on 21/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import Foundation

protocol PostViewModelDelegate: class {
    func postTapped(post: Post)
}

protocol PostViewModel {
    var delegate: PostViewModelDelegate? { get set }
    var post: Post { get }
    var title: String { get }

    func postTapped()
}
