//
//  Address.swift
//  BabylonPosts
//
//  Created by Li Linyu on 21/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import Foundation

struct Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
}
