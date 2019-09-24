//
//  AppNavigator.swift
//  BabylonPosts
//
//  Created by Li Linyu on 25/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import Foundation

enum AppNavigatorDesination {
    case posts
}

protocol AppNavigator {
    func navigate(to destination: AppNavigatorDesination)
}
