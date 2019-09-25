//
//  ErrorAction+Equatable.swift
//  BabylonPostsTests
//
//  Created by Li Linyu on 25/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import Foundation
@testable import BabylonPosts

extension ErrorAction: Equatable {
    public static func == (lhs: ErrorAction, rhs: ErrorAction) -> Bool {
        // Only compare the titles for simplicy
        return lhs.title == rhs.title
    }
}
