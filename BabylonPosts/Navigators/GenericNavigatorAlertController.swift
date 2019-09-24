//
//  GenericNavigatorAlertController.swift
//  BabylonPosts
//
//  Created by Li Linyu on 25/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import UIKit

class GenericNavigatorAlertController {
    static func create(with error: Error,
                       mainAction: ErrorAction?, cancelAction: ErrorAction) -> UIAlertController {
        let title = NSLocalizedString("error_generic_title", comment: "")
        let message = NSLocalizedString("error_generic_message", comment: "")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        if let mainAction = mainAction {
            let action = UIAlertAction(title: mainAction.title, style: .default) { _ in
                mainAction.action?()
            }
            alert.addAction(action)
        }

        let cancel = UIAlertAction(title: cancelAction.title, style: .cancel) { _ in
            cancelAction.action?()
        }
        alert.addAction(cancel)

        return alert
    }
}
