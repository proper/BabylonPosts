//
//  PostsViewController.swift
//  BabylonPosts
//
//  Created by Li Linyu on 21/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import UIKit
import JGProgressHUD

final class PostsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    private lazy var refreshControl = UIRefreshControl()
    private var hud: JGProgressHUD?

    var viewModel: PostsViewModel?

    static func make(with viewModel: PostsViewModel) -> PostsViewController {
        let vc: PostsViewController = PostsViewController.fromNib()
        vc.viewModel = viewModel
        vc.bindViewModel()
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupTableView()
        addRefreshControl()

        fetchPosts()
    }

    private func setupUI() {
        navigationItem.title = NSLocalizedString("posts_navigation_title", comment: "")
    }

    private func setupTableView() {
        tableView.register(UINib(nibName: String(describing: PostCell.self), bundle: nil),
                           forCellReuseIdentifier: PostCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension

        tableView.delegate = self
        tableView.dataSource = self
    }

    private func addRefreshControl() {
        refreshControl.addTarget(self, action: #selector(fetchPosts), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    @objc private func fetchPosts() {
        viewModel?.fetchPosts()
    }
}

// MARK: - View binding
extension PostsViewController {
    func bindViewModel() {
        viewModel?.onPostsUpdated = {
            DispatchQueue.main.async {
                self.onPostsUpdated()
            }
        }

        viewModel?.onLoadingStateChanged = {
            DispatchQueue.main.async {
                self.onLoadingStateChanged()
            }
        }
    }

    private func onPostsUpdated() {
        tableView.reloadData()
    }

    private func onLoadingStateChanged() {
        if viewModel?.isLoading ?? false {
            startLoading()
        } else {
            stopLoading()
        }
    }

    private func startLoading() {
        hud?.dismiss()
        hud = JGProgressHUD(style: .light)
        hud?.textLabel.text = NSLocalizedString("posts_hud_loading", comment: "")
        hud?.show(in: view)
    }

    private func stopLoading() {
        hud?.dismiss()
        refreshControl.endRefreshing()
    }
}

// MARK: - UITableViewDelegate
extension PostsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? CellTappable {
            cell.tapped()
        }
    }
}

// MARK: - UITableViewDataSource
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
            cell.viewModel = posts[indexPath.row]
        }

        return cell
    }
}
