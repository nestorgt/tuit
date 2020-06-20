//
//  PostTests.swift
//  unit-tests
//
//  Created by Nestor Garcia on 17/06/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import XCTest
@testable import tuit

final class PostTests: XCTestCase {

    func testDecoder() {
        let jsonString =
        """
        {
        "userId": 1,
        "id": 1,
        "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
        "body": "quia et suscipit\\nsuscipit recusandae."
        }
        """
        let jsonData = Parser.JSONData(from: jsonString)!
        let sut = try! JSONDecoder().decode(Post.self, from: jsonData)
        
        XCTAssertEqual(sut.userId, 1)
        XCTAssertEqual(sut.id, 1)
        XCTAssertEqual(sut.title, "sunt aut facere repellat provident occaecati excepturi optio reprehenderit")
        XCTAssertEqual(sut.body, "quia et suscipit\nsuscipit recusandae.")
    }
}
