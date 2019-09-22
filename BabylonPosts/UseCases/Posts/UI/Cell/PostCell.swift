//
//  PostCell.swift
//  BabylonPosts
//
//  Created by Li Linyu on 21/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    static let identifier = "PostCell"

    @IBOutlet weak var postTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        configureUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        postTitle.text = nil
    }

    func configure(viewModel: PostViewModel) {
        postTitle.text = viewModel.title
    }

    private func configureUI() {
        backgroundColor = .white
        postTitle.backgroundColor = .white
    }
}
