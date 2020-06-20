//
//  PostsViewController.swift
//  tuit
//
//  Created by Nestor Garcia on 17/06/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import UIKit
import Combine

final class PostsViewController: UITableViewController {
    
    private lazy var loadingView = LoadingView.standard
    private let viewModel: PostsViewModel
    private var cancelables = Set<AnyCancellable>()
    
    init(viewModel: PostsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
        setupViewModel()
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension PostsViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cellViewModels?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: PostCell.identifier) as? PostCell
            else { return UITableViewCell() }
        cell.setup(with: viewModel.cellViewModels?[safe: indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let post = viewModel.post(at: indexPath.row) else {
            Log.message("No post for index: \(indexPath.row)", level: .error, type: .posts)
            return
        }
        Log.message("Post selected: \(post)", level: .info, type: .posts)
        let vm = PostDetailsViewModel(post: post)
        let vc = PostDetailsViewController(viewModel: vm)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Private

private extension PostsViewController {
    
    func setupNavigationBar() {
        title = viewModel.screenTitle
    }
    
    func setupViews() {
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.identifier)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc func refresh() {
        viewModel.refresh()
    }
    
    func setupViewModel() {
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.loadingView.present(in: UIApplication.shared.windows.first,
                                              message: self?.viewModel.loadingMessage)
                } else {
                    self?.refreshControl?.endRefreshing()
                    self?.loadingView.dismiss()
                }}
            .store(in: &cancelables)
        
        viewModel.$errorMessage
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] message in
                let alert = Alerts.standard(title: self?.viewModel.alertErrorTitle, message: message)
                self?.navigationController?.present(alert, animated: true) }
            .store(in: &cancelables)
        
        viewModel.$cellViewModels
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] cellViewModels in
                Log.message("New data received: \(cellViewModels?.count ?? 0) cells",
                    level: .debug, type: .posts)
                self?.tableView.reloadData() }
            .store(in: &cancelables)
    }
}
