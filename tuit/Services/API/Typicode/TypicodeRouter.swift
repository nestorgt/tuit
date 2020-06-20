//
//  TypicodeRouter.swift
//  tuit
//
//  Created by Nestor Garcia on 17/06/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import Foundation

/// Builds URLRequests for TypicodeService.
struct TypicodeRouter {
    
    private static let cachePolicy = NSURLRequest.CachePolicy.useProtocolCachePolicy
    private static let timeoutInterval = 60.0
    
    private static let scheme = "https"
    private static let host = "jsonplaceholder.typicode.com"
    private static let postsPath = "/posts"
    private static let commentPath = "/comments"
    
    /// Returns an URLRequest to retrieve posts.
    static func posts() -> URLRequest? {
        var components = commonComponents
        components.path = Self.postsPath
        
        guard let url = components.url else { return nil }
        var urlRequest = URLRequest(url: url,
                                    cachePolicy: Self.cachePolicy,
                                    timeoutInterval: Self.timeoutInterval)
        urlRequest.httpMethod = "GET"
        return urlRequest
    }
    
    /// Returns an URLRequest to comments for a post.
    /// - Parameter postId: The id of the post to retrieve comments.
    static func comments(for postId: UInt) -> URLRequest? {
        var components = commonComponents
        components.path = Self.postsPath + "/\(postId)" + Self.commentPath
        
        guard let url = components.url else { return nil }
        var urlRequest = URLRequest(url: url,
                                    cachePolicy: Self.cachePolicy,
                                    timeoutInterval: Self.timeoutInterval)
        urlRequest.httpMethod = "GET"
        return urlRequest
    }
}

// MARK: - Private

extension TypicodeRouter {
    
    static var commonComponents: URLComponents {
        var components = URLComponents()
        components.scheme = Self.scheme
        components.host = Self.host
        return components
    }
}
