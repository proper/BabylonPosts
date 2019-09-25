//
//  Post+Equatable.swift
//  BabylonPostsTests
//
//  Created by Li Linyu on 25/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import Foundation
@testable import BabylonPosts

extension Post: Equatable {
    public static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id
            && lhs.body == rhs.body
            && lhs.title == rhs.title
            && lhs.userId == rhs.userId
    }
}
