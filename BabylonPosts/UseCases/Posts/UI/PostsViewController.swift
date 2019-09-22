//
//  PostsViewController.swift
//  BabylonPosts
//
//  Created by Li Linyu on 21/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    var viewModel: PostsViewModel?
    var navigator: PostsNavigator?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: String(describing: PostCell.self), bundle: nil),
                           forCellReuseIdentifier: PostCell.identifier)
        //TODO: need to separate those out
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension

        self.navigationItem.title = "Posts"

        viewModel?.fetchPosts()
    }

    func bindViewModel() {
        viewModel?.postsUpdated = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension PostsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let posts = viewModel?.posts {
            navigator?.navigate(to: .postDetail(post: posts[indexPath.row]))
        }
    }
}

extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let posts = viewModel?.posts {
            return posts.count
        }

        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.identifier) as? PostCell else {
            fatalError("Failed to dequeue PostCell with identifier \(PostCell.identifier)")
        }

        if let posts = viewModel?.posts {
            cell.configure(viewModel: DefaultPostViewModel(post: posts[indexPath.row]))
        }

        return cell
    }
}
