//
//  PostDetailNavigator.swift
//  BabylonPosts
//
//  Created by Li Linyu on 25/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import Foundation

enum PostDetailNavigatorDestination {
    case back
    case error(error: Error, mainAction: ErrorAction?, cancelAction: ErrorAction)
}

protocol PostDetailNavigator {
    func navigate(to destination: PostDetailNavigatorDestination)
}
