//
//  TypicodeService.swift
//  tuit
//
//  Created by Nestor Garcia on 17/06/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import Foundation

/// Fetch and decode data from Typicode.
protocol TypicodeServiceProtocol {
    
    /// Fetch all posts.
    /// - Parameter completion: A result with either an array of `Post` or an error in form of `TypicodeError`.
    func fetchPosts(completion: @escaping (Result<[Post], TypicodeError>) -> Void)
    
    /// Fetch all comments for a given post id.
    /// - Parameters:
    ///   - postId: The post id to send in the request.
    ///   - completion: A result with either an array of `Comment` or an error in form of `TypicodeError`.
    func fetchComments(for postId: UInt, completion: @escaping (Result<[Comment], TypicodeError>) -> Void)
}

final class TypicodeService: TypicodeServiceProtocol {

    private var posts: [Post] = []

    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = DI.apiService) {
        self.apiService = apiService
    }
    
    func fetchPosts(completion: @escaping (Result<[Post], TypicodeError>) -> Void) {
        guard let request = TypicodeRouter.posts() else {
            completion(.failure(.generic(message: "Can't build request for posts")))
            return
        }
        apiService.perform(urlRequest: request, completion: { [weak self] result in
            switch result {
            case .failure(let apiError):
                completion(.failure(.api(apiError)))
            case .success(let data):
                guard let posts = try? JSONDecoder.tuit.decode([Post].self, from: data) else {
                    completion(.failure(.generic(message: "Can't decode posts")))
                    return
                }
                self?.posts = posts
                completion(.success(posts))
            }
        })
    }
    
    func fetchComments(for postId: UInt, completion: @escaping (Result<[Comment], TypicodeError>) -> Void) {
        guard let request = TypicodeRouter.comments(for: postId) else {
            completion(.failure(.generic(message: "Can't build request for comments")))
            return
        }
        apiService.perform(urlRequest: request, completion: { result in
            switch result {
            case .failure(let apiError):
                completion(.failure(.api(apiError)))
            case .success(let data):
                guard let comments = try? JSONDecoder.tuit.decode([Comment].self, from: data) else {
                    completion(.failure(.generic(message: "Can't decode comments")))
                    return
                }
                completion(.success(comments))
            }
        })
    }
}
