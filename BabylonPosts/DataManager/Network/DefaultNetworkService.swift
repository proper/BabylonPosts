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
        let url = "\(serviceUrl)\(resource.route)"

        return Promise { seal in
            AF.request(url,
                       method: resource.method,
                       headers: DefaultNetworkService.defaultHeader)
                .responseDecodable(of: [Post].self) { response in
                    if let error = response.error {
                        seal.reject(error)
                        return
                    }

                    if let posts = response.value {
                        seal.fulfill(posts)
                    } else {
                        seal.reject(NetworkServiceError.nilResponseValueError())
                    }
            }
        }
    }

    func fetchUser(for userId: Int) -> Promise<User> {
        let resource = Resource.user(userId: userId).resource
        let url = "\(serviceUrl)\(resource.route)"

        return Promise { seal in
            AF.request(url,
                       method: resource.method,
                       headers: DefaultNetworkService.defaultHeader)
                .responseDecodable(of: [User].self) { response in
                    if let error = response.error {
                        seal.reject(error)
                        return
                    }

                    if let user = response.value?.first {
                        seal.fulfill(user)
                    } else {
                        seal.reject(NetworkServiceError.nilResponseValueError())
                    }
            }
        }
    }

    func fetchComments(for postId: Int) -> Promise<[Comment]> {
        let resource = Resource.comments(postId: postId).resource
        let url = "\(serviceUrl)\(resource.route)"

        return Promise { seal in
            AF.request(url,
                       method: resource.method,
                       headers: DefaultNetworkService.defaultHeader)
                .responseDecodable(of: [Comment].self) { response in
                    if let error = response.error {
                        seal.reject(error)
                        return
                    }

                    if let comments = response.value {
                        seal.fulfill(comments)
                    } else {
                        seal.reject(NetworkServiceError.nilResponseValueError())
                    }
            }
        }
    }
}
