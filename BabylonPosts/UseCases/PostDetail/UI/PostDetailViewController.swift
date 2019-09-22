//
//  PostDetailViewController.swift
//  BabylonPosts
//
//  Created by Li Linyu on 22/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import UIKit

class PostDetailViewController: UIViewController {
    var viewModel: PostDetailViewModel?
    var navigator: PostsNavigator?

    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.fetchPostDetail()
    }

    func bindViewModel() {
        viewModel?.postDetailUpdated = {
            DispatchQueue.main.async {
                if let viewModel = self.viewModel {
                    self.textView.text = (viewModel.author ?? "") + (viewModel.description ?? "") + "\(viewModel.numberOfComments ?? 0)"
                    self.navigationItem.title = viewModel.title ?? ""
                }
            }
        }
    }
}
