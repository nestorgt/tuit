//
//  CommentMock.swift
//  unit-tests
//
//  Created by Nestor Garcia on 17/06/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import Foundation
@testable import tuit

struct CommentMock {
    
    static var make: Comment {
        Comment(postId: UInt.random(in: 0...9999999),
                id: UInt.random(in: 0...9999999),
                name: String.random(length: 10),
                email: String.random(length: 20),
                body: String.random(length: 100))
    }
    
    static var sample1: Comment {
        Comment(postId: 1, id: 11, name: "A name 1", email: "email1@gmail.com", body: "A body 1")
    }
    
    static var sample2: Comment {
        Comment(postId: 2, id: 22, name: "A name 2", email: "email2@gmail.com", body: "A body 2")
    }
    
    static var sample3: Comment {
        Comment(postId: 3, id: 3, name: "A name 3", email: "email3@gmail.com", body: "A body 3")
    }
    
    static var sampleStringResponse: String {
        """
        [{
            "postId": 1,
            "id": 1,
            "name": "id labore ex et quam laborum",
            "email": "Eliseo@gardner.biz",
            "body": "laudantium enim quasi est quidem magnam voluptate ipsam eos\\ntempora quo necessitatibus\\ndolor quam autem quasi\\nreiciendis et nam sapiente accusantium"
        }, {
            "postId": 1,
            "id": 2,
            "name": "quo vero reiciendis velit similique earum",
            "email": "Jayne_Kuhic@sydney.com",
            "body": "est natus enim nihil est dolore omnis voluptatem numquam\\net omnis occaecati quod ullam at\\nvoluptatem error expedita pariatur\\nnihil sint nostrum voluptatem reiciendis et"
        }, {
            "postId": 1,
            "id": 3,
            "name": "odio adipisci rerum aut animi",
            "email": "Nikita@garfield.biz",
            "body": "quia molestiae reprehenderit quasi aspernatur\\naut expedita occaecati aliquam eveniet laudantium\\nomnis quibusdam delectus saepe quia accusamus maiores nam est\\ncum et ducimus et vero voluptates excepturi deleniti ratione"
        }]
        """
    }
    
    static var sampleDataResponse: Data {
        Parser.JSONData(from: sampleStringResponse)!
    }
}
