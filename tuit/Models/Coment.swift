//
//  Coment.swift
//  tuit
//
//  Created by Nestor Garcia on 17/06/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import Foundation

/// Model representing a comment of a `Post`.
struct Comment: Equatable, CustomStringConvertible {
    let postId: UInt
    let id: UInt
    let name: String
    let email: String
    let body: String
    
    var description: String {
        "id: \(id), postId: \(postId), name: \(name), body: \(body.prefix(20))..."
    }
}

// MARK: - Decodable

/*
 {
 "postId": 2,
 "id": 6,
 "name": "et fugit eligendi deleniti quidem qui sint nihil autem",
 "email": "Presley.Mueller@myrl.com",
 "body": "doloribus at sed quis culpa deserunt consectetur qui praesentium\naccusamus fugiat dicta\nvoluptatem rerum ut voluptate autem\nvoluptatem repellendus aspernatur dolorem in"
 }
*/

extension Comment: Decodable { }
