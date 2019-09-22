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
                    self.textView.attributedText = self.attributedTextViewString
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

// MARK: Attributed strings
extension PostDetailViewController {
    private var attributedTextViewString: NSAttributedString {
        let str = NSMutableAttributedString()
        str.append(attributedAuthorString)
        str.append(attributedCommentsString)
        str.append(attributedDescriptionString)
        return str
    }

    private var attributedAuthorString: NSAttributedString {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        let attridutes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 26),
                                                         .paragraphStyle: paragraph]
        return NSAttributedString(string: "\(viewModel?.author ?? "")\n\n", attributes: attridutes)
    }

    private var attributedDescriptionString: NSAttributedString {
        let attridutes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 16)]
        return NSAttributedString(string: "\(viewModel?.description ?? "")\n\n", attributes: attridutes)
    }

    private var attributedCommentsString: NSAttributedString {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        let attridutes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 18),
                                                         .paragraphStyle: paragraph]
        return NSAttributedString(string: "\(viewModel?.numberOfComments ?? 0) comments\n\n", attributes: attridutes)
    }
}
