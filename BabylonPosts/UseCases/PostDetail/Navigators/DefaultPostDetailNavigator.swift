//
//  DefaultPostDetailNavigator.swift
//  BabylonPosts
//
//  Created by Li Linyu on 25/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import UIKit

final class DefaultPostDetailNavigator: PostDetailNavigator {
    private weak var navigationController: UINavigationController?
    private let dataCoordinator: DataCoordinator

    init(navigationController: UINavigationController?, dataCoordinator: DataCoordinator) {
        self.navigationController = navigationController
        self.dataCoordinator = dataCoordinator
    }

    func navigate(to destination: PostDetailNavigatorDestination) {
        switch destination {
        case .back:
            navigationController?.popViewController(animated: true)
        case .error(let error, let mainAction, let cancelAction):
            // Simple error handling here, can be extened to perform actions such as refresh if needed
            let alert = GenericNavigatorAlertController.create(with: error,
                                                               mainAction: mainAction, cancelAction: cancelAction)
            navigationController?.present(alert, animated: true, completion: nil)
        }
    }
}
