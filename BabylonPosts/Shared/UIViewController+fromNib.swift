//
//  UIViewController+fromNib.swift
//  BabylonPosts
//
//  Created by Li Linyu on 21/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import UIKit

extension UIViewController {
    class func fromNib<T: UIViewController>() -> T {
         return T(nibName: String(describing: self), bundle: nil)
    }
}
