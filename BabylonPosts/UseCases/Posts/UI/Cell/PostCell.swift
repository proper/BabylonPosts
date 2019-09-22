//
//  PostCell.swift
//  BabylonPosts
//
//  Created by Li Linyu on 21/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import UIKit

final class PostCell: UITableViewCell {
    static let identifier = "PostCell"

    @IBOutlet weak var postTitle: UILabel!

    var viewModel: PostViewModel? {
        didSet {
            self.updateUI()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        configureUIStyle()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        postTitle.text = nil
    }

    private func updateUI() {
        postTitle.text = viewModel?.title
    }

    private func configureUIStyle() {
        backgroundColor = .white
        postTitle.backgroundColor = .white
    }

    func tapped() {
        viewModel?.postTapped()
    }
}
