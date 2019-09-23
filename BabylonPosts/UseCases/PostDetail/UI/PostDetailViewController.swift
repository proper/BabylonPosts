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

        viewModel?.viewDidLoad()
    }
}

// MARK: View binding
extension PostDetailViewController {
    func bindViewModel() {
        viewModel?.onPostDetailUpdated = { [weak self] in
            self?.onPostDetailUpdated()
        }

        viewModel?.onLoadingStateChanged = {
            // A JGProgressHUD bug requires the hub's update to be added later
            DispatchQueue.main.async {
                self.onLoadingStateChanged()
            }
        }
    }

    private func onPostDetailUpdated() {
        textView.attributedText = attributedTextViewString
        navigationItem.title = viewModel?.title ?? ""
    }

    private func onLoadingStateChanged() {
        hud?.dismiss()

        if viewModel?.isLoading ?? false {
            hud = JGProgressHUD(style: .light)
            hud?.textLabel.text = NSLocalizedString("post_detail_hud_loading", comment: "")
            hud?.show(in: view)
        }
    }
}

// MARK: Attributed strings
extension PostDetailViewController {
    private var attributedTextViewString: NSAttributedString {
        let str = NSMutableAttributedString()
        if let author = attributedAuthorString {
            str.append(author)
        }
        if let comments = attributedCommentsString {
            str.append(comments)
        }
        if let description = attributedDescriptionString {
            str.append(description)
        }
        return str
    }

    private var attributedAuthorString: NSAttributedString? {
        guard let authorString = viewModel?.author else { return nil }

        let authorFormat = NSLocalizedString("post_detail_author", comment: "")
        let formattedAuthorString = String(format: authorFormat, authorString)

        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        let attridutes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 20),
                                                         .paragraphStyle: paragraph]

        return NSAttributedString(string: formattedAuthorString, attributes: attridutes)
    }

    private var attributedCommentsString: NSAttributedString? {
        guard let numberOfComments = viewModel?.numberOfComments else { return nil }

        let numberOfCommentsFormat = NSLocalizedString("post_detail_comments", comment: "")
        let numberOfCommentsString = String(format: numberOfCommentsFormat, numberOfComments)

        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        let attridutes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 14),
                                                         .paragraphStyle: paragraph]
        return NSAttributedString(string: numberOfCommentsString, attributes: attridutes)
    }

    private var attributedDescriptionString: NSAttributedString? {
        guard let descriptionString = viewModel?.description else { return nil }

        let descriptionFormat = NSLocalizedString("post_detail_description", comment: "")
        let formattedDescriptionString = String(format: descriptionFormat, descriptionString)

        let attridutes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 16)]
        return NSAttributedString(string: formattedDescriptionString, attributes: attridutes)
    }
}
