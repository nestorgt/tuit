//
//  PostMock.swift
//  unit-tests
//
//  Created by Nestor Garcia on 17/06/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import Foundation
@testable import tuit

struct PostMock {
    
    static var make: Post {
        Post(userId: UInt.random(in: 0...9999999),
             id: UInt.random(in: 0...9999999),
             title: String.random(length: 10),
             body: String.random(length: 100))
    }
    
    static var sample1: Post {
        Post(userId: 1, id: 11, title: "A title 1", body: "A body 1")
    }
    
    static var sample2: Post {
        Post(userId: 2, id: 22, title: "A title 2", body: "A body 2")
    }
    
    static var sample3: Post {
        Post(userId: 3, id: 33, title: "A title 3", body: "A body 3")
    }
    
    static var sampleStringResponse: String {
        """
        [{
        "userId": 1,
        "id": 1,
        "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
        "body": "quia et suscipit\\nsuscipit recusandae consequuntur expedita et cum\\nreprehenderit molestiae ut ut quas totam\\nnostrum rerum est autem sunt rem eveniet architecto"
        }, {
        "userId": 1,
        "id": 2,
        "title": "qui est esse",
        "body": "est rerum tempore vitae\\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\\nqui aperiam non debitis possimus qui neque nisi nulla"
        }, {
        "userId": 1,
        "id": 3,
        "title": "ea molestias quasi exercitationem repellat qui ipsa sit aut",
        "body": "et iusto sed quo iure\\nvoluptatem occaecati omnis eligendi aut ad\\nvoluptatem doloribus vel accusantium quis pariatur\\nmolestiae porro eius odio et labore et velit aut"
        }]
        """
    }
    
    static var sampleDataResponse: Data {
        Parser.JSONData(from: sampleStringResponse)!
    }
}
