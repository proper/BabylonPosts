//
//  NetworkServiceError.swift
//  BabylonPosts
//
//  Created by Li Linyu on 22/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import Foundation

final class NetworkServiceError: NSError {
    static let domain = "NetworkServiceError"

    static func nilResponseValueError() -> NSError {
        return NSError(
            domain: NetworkServiceError.domain,
            code: 0,
            userInfo: [NSLocalizedDescriptionKey: "Nil response value returned"])
    }
}
