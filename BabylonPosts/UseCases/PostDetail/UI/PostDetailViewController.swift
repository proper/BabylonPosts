//
//  PostDetailViewController.swift
//  BabylonPosts
//
//  Created by Li Linyu on 22/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import UIKit
import JGProgressHUD

final class PostDetailViewController: UIViewController {
    var viewModel: PostDetailViewModel?
    var navigator: PostsNavigator?

    @IBOutlet weak var textView: UITextView!

    private var hud: JGProgressHUD?

    static func make(with viewModel: PostDetailViewModel) -> PostDetailViewController {
        let vc: PostDetailViewController = PostDetailViewController.fromNib()
        vc.viewModel = viewModel
        vc.bindViewModel()
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.fetchPostDetail()
    }

    func bindViewModel() {
        viewModel?.onPostDetailUpdated = {
            DispatchQueue.main.async {
                if let viewModel = self.viewModel {
                    self.textView.text = (viewModel.author ?? "") + (viewModel.description ?? "") + "\(viewModel.numberOfComments ?? 0)"
                    self.navigationItem.title = viewModel.title ?? ""
                }
            }
        }

        viewModel?.onLoadingStateChanged = {
            DispatchQueue.main.async {
                guard let viewModel = self.viewModel else {
                    return
                }

                if viewModel.isLoading {
                    self.startLoading()
                } else {
                    self.stopLoading()
                }
            }
        }
    }

    private func startLoading() {
        hud?.dismiss()
        hud = JGProgressHUD(style: .light)
        hud?.textLabel.text = "Loading"
        hud?.show(in: view)
    }

    private func stopLoading() {
        hud?.dismiss()
    }
}
