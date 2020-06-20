//
//  Post.swift
//  tuit
//
//  Created by Nestor Garcia on 17/06/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import Foundation

/// Model representing a post.
struct Post: Equatable, CustomStringConvertible {
    let userId: UInt
    let id: UInt
    let title: String
    let body: String
    
    var description: String {
        "id: \(id), userId: \(userId), title: \(title)"
    }
}

// MARK: - Decodable

/*
 {
 "userId": 1,
 "id": 1,
 "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
 "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
 }
 */

extension Post: Decodable { }
