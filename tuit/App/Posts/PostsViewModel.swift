//
//  PostsViewModel.swift
//  tuit
//
//  Created by Nestor Garcia on 17/06/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import UIKit
import Combine

final class PostsViewModel {

    enum Mode {
        case normal
        case filtered(userId: UInt)
    }
    
    @Published var isLoading: Bool = true
    @Published var errorMessage: String? = nil
    @Published var cellViewModels: [PostCellViewModel]?
    private var posts = CurrentValueSubject<[Post], Never>([])
    private var cancelables = Set<AnyCancellable>()
    private let mode: Mode
    
    var screenTitle: String {
        switch mode {
        case .normal:
            return NSLocalizedString("posts-navigation-bar-title")
        case .filtered(let userId):
            return "\(userId)" + " " + NSLocalizedString("posts-navigation-bar-title")
        }
    }
    var alertErrorTitle: String { NSLocalizedString("alert-error-title") }
    var loadingMessage: String { NSLocalizedString("posts-loading") }
    
    private let typicodeService: TypicodeServiceProtocol
    
    init(mode: Mode, typicodeService: TypicodeServiceProtocol = DI.typicodeService) {
        self.mode = mode
        self.typicodeService = typicodeService
        setupBindings()
        fetchPosts()
    }
    
    func refresh() {
        guard !isLoading else { return }
        cellViewModels = []
        fetchPosts()
    }
    
    func post(at index: Int) -> Post? {
        guard let cellViewModel = cellViewModels?[safe: index] else { return nil }
        return posts.value.first(where: { $0.id == cellViewModel.id })
    }
}

// MARK: - Private

private extension PostsViewModel {
    
    func setupBindings() {
        posts
            .sink { [weak self] posts in
                var filteredPosts = posts
                if case .filtered(let userId) = self?.mode {
                    filteredPosts = posts.filter { $0.userId == userId }
                }
                self?.cellViewModels = filteredPosts.map {
                    PostCellViewModel(id: $0.id, title: $0.title, subtitle: $0.body) } }
            .store(in: &cancelables)
    }
    
    func fetchPosts() {
        isLoading = true
        typicodeService.fetchPosts { [weak self] result in
            switch result {
            case .failure(let error):
                self?.errorMessage = error.description
            case .success(let posts):
                self?.posts.send(posts)
            }
            self?.isLoading = false
        }
    }
}
