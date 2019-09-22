//
//  PostsViewController.swift
//  BabylonPosts
//
//  Created by Li Linyu on 21/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import UIKit

final class PostsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private lazy var refreshControl = UIRefreshControl()

    var viewModel: PostsViewModel?

    static func make(with viewModel: PostsViewModel) -> PostsViewController {
        let vc: PostsViewController = PostsViewController.fromNib()
        vc.viewModel = viewModel
        vc.bindViewModel()
        return vc
    }

    func bindViewModel() {
        viewModel?.onPostsUpdated = {
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: String(describing: PostCell.self), bundle: nil),
                           forCellReuseIdentifier: PostCell.identifier)
        //TODO: need to separate those out
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension

        self.navigationItem.title = "Posts"

        addRefreshControl()
        fetchPosts()
    }

    private func addRefreshControl() {
        refreshControl.addTarget(self, action: #selector(fetchPosts), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    @objc private func fetchPosts() {
        viewModel?.fetchPosts()
    }
}

extension PostsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? PostCell {
            cell.tapped()
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
            var postViewModel = DefaultPostViewModel(post: posts[indexPath.row])
            postViewModel.delegate = viewModel
            cell.viewModel = postViewModel
        }

        return cell
    }
}
