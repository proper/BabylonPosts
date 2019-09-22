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
}

// MARK: View binding
extension PostDetailViewController {
    func bindViewModel() {
        viewModel?.onPostDetailUpdated = {
            DispatchQueue.main.async {
                self.onPostDetailUpdated()
            }
        }

        viewModel?.onLoadingStateChanged = {
            DispatchQueue.main.async {
                self.onLoadingStateChanged()
            }
        }
    }

    private func onPostDetailUpdated() {
        textView.attributedText = self.attributedTextViewString
        navigationItem.title = viewModel?.title ?? ""
    }

    private func onLoadingStateChanged() {
        hud?.dismiss()

        if viewModel?.isLoading ?? false {
            hud = JGProgressHUD(style: .light)
            hud?.textLabel.text = "Loading"
            hud?.show(in: view)
        }
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
        let attridutes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 20),
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
        let attridutes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 14),
                                                         .paragraphStyle: paragraph]
        return NSAttributedString(string: "\(viewModel?.numberOfComments ?? 0) comments\n\n", attributes: attridutes)
    }
}
