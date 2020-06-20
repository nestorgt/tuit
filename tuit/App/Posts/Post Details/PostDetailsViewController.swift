//
//  PostDetailsViewController.swift
//  tuit
//
//  Created by Nestor Garcia on 17/06/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import UIKit
import Combine

final class PostDetailsViewController: UIViewController {
    
    static let cellIdentifier = "post-details-cell-identifier"
    
    private lazy var postView = PostView()
    private lazy var tableView = UITableView(frame: .zero, style: .plain)
    private lazy var loadingView = LoadingView.standard
    private lazy var refreshControl = UIRefreshControl()
    private let viewModel: PostDetailsViewModel
    private var cancelables = Set<AnyCancellable>()
    
    init(viewModel: PostDetailsViewModel) {
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

// MARK: - UITableViewDataSource

extension PostDetailsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cellViewModels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle , reuseIdentifier: Self.cellIdentifier)
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.numberOfLines = 0
        cell.textLabel?.text = viewModel.name(for: indexPath.row)
        cell.detailTextLabel?.text = viewModel.body(for: indexPath.row)
        return cell
    }
}

// MARK: - Private

private extension PostDetailsViewController {
    
    func setupNavigationBar() {
        title = viewModel.screenTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: viewModel.moreLikeThisTitle,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didPressMoreLikeThis))
    }
    
    func setupViews() {
        view.backgroundColor = .tuitGray4
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Self.cellIdentifier)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.dataSource = self
        tableView.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        tableView.layer.borderWidth = 2
        
        
        postView.title = viewModel.postTitle
        postView.subtitle = viewModel.postSubtitle

        view.addSubviewForAutoLayout(postView)
        view.addSubviewForAutoLayout(tableView)
        NSLayoutConstraint.activate([
            postView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Metrics.margin),
            postView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            postView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            postView.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -Metrics.margin),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    func setupViewModel() {
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.loadingView.present(in: self?.view,
                                              message: self?.viewModel.loadingMessage)
                } else {
                    self?.refreshControl.endRefreshing()
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
                    level: .debug, type: .postDetails)
                self?.tableView.reloadData() }
            .store(in: &cancelables)
    }
    
    @objc func refresh() {
        viewModel.refresh()
    }
    
    @objc func didPressMoreLikeThis() {
        let vm = PostsViewModel(mode: .filtered(userId: viewModel.postUserId))
        let vc = PostsViewController(viewModel: vm)
        navigationController?.pushViewController(vc, animated: true)
    }
}
