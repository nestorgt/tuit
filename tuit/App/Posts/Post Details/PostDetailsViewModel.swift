//
//  PostDetailsViewModel.swift
//  tuit
//
//  Created by Nestor Garcia on 17/06/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import UIKit
import Combine

final class PostDetailsViewModel {
    
    @Published var isLoading: Bool = true
    @Published var errorMessage: String? = nil
    @Published var cellViewModels: [PostDetailsCellViewModel]?
    private let post: Post
    private var comments: [Comment] = []
    private var cancelables = Set<AnyCancellable>()
    
    var screenTitle: String { NSLocalizedString("post-details-navigation-bar-title") }
    var alertErrorTitle: String { NSLocalizedString("alert-error-title") }
    var loadingMessage: String { NSLocalizedString("post-details-loading") }
    var moreLikeThisTitle: String { NSLocalizedString("post-details-more-like-this-button-title") }
    var postTitle: String { post.title }
    var postSubtitle: String { post.body }
    
    private let typicodeService: TypicodeServiceProtocol
    
    init(post: Post, typicodeService: TypicodeServiceProtocol = DI.typicodeService) {
        self.post = post
        self.typicodeService = typicodeService
        fetchComments()
    }
    
    func refresh() {
        guard !isLoading else { return }
        cellViewModels = []
        fetchComments()
    }
    
    func name(for index: Int) -> String? {
        cellViewModels?[safe: index]?.name
    }
    
    func body(for index: Int) -> String? {
        cellViewModels?[safe: index]?.body
    }
    
    var postUserId: UInt {
        post.userId
    }
}

// MARK: - Private

private extension PostDetailsViewModel {
    
    func fetchComments() {
        isLoading = true
        typicodeService.fetchComments(for: post.id) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.errorMessage = error.description
            case .success(let comments):
                self?.cellViewModels = comments.map { PostDetailsCellViewModel(name: $0.name, body: $0.body) }
            }
            self?.isLoading = false
        }
    }
}
