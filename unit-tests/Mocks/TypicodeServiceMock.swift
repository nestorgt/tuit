//
//  TypicodeServiceMock.swift
//  unit-tests
//
//  Created by Nestor Garcia on 18/06/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import Foundation
@testable import tuit

final class TypicodeServiceMock: TypicodeServiceProtocol {
    
    var nextFetchPostsResult: Result<[Post], TypicodeError>?
    var nextFetchCommentsResult: Result<[Comment], TypicodeError>?
    
    // MARK: - TypicodeServiceProtocol
    
    func fetchPosts(completion: @escaping (Result<[Post], TypicodeError>) -> Void) {
        guard let result = nextFetchPostsResult else {
            completion(.failure(.generic(message: "nextFetchPostsResult is nil")))
            return
        }
        completion(result)
    }
    
    func fetchComments(for postId: UInt, completion: @escaping (Result<[Comment], TypicodeError>) -> Void) {
        guard let result = nextFetchCommentsResult else {
            completion(.failure(.generic(message: "nextFetchCommentsResult is nil")))
            return
        }
        completion(result)
    }
}
