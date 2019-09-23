//
//  DefaultNetworkService.swift
//  BabylonPosts
//
//  Created by Li Linyu on 22/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire

final class DefaultNetworkService: NetworkService {
    private static let defaultHeader: HTTPHeaders = ["Content-Type": "application/json"]

    private let serviceUrl: String

    init(serviceUrl: String) {
        self.serviceUrl = serviceUrl
    }

    func fetchPosts() -> Promise<[Post]> {
        let resource = Resource.posts.resource
        return fetchData(method: resource.method, route: resource.route)
    }

    func fetchUser(for userId: Int) -> Promise<User> {
        let resource = Resource.user(userId: userId).resource
        return fetchData(method: resource.method, route: resource.route)
    }

    func fetchComments(for postId: Int) -> Promise<[Comment]> {
        let resource = Resource.comments(postId: postId).resource
        return fetchData(method: resource.method, route: resource.route)
    }

    private func fetchData<T: Codable>(method: HTTPMethod, route: String) -> Promise<T> {
        let url = "\(serviceUrl)\(route)"

        return Promise { seal in
            AF.request(url,
                       method: method,
                       headers: DefaultNetworkService.defaultHeader)
                .responseDecodable(of: T.self) { response in
                    if let error = response.error {
                        seal.resolve(nil, error)
                        return
                    }

                    if let data = response.value {
                        seal.resolve(data, nil)
                    } else {
                        seal.resolve(nil, NetworkServiceError.nilResponseValueError())
                    }
            }
        }
    }
}
