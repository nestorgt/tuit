//
//  CommentTests.swift
//  unit-tests
//
//  Created by Nestor Garcia on 17/06/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import XCTest
@testable import tuit

final class CommentTests: XCTestCase {

    func testDecoder() {
        let jsonString =
        """
        {
        "postId": 2,
        "id": 6,
        "name": "et fugit eligendi deleniti quidem qui sint nihil autem",
        "email": "Presley.Mueller@myrl.com",
        "body": "doloribus at sed quis culpa deserunt consectetur qui praesentium\\naccusamus"
        }
        """
        let jsonData = Parser.JSONData(from: jsonString)!
        let sut = try! JSONDecoder().decode(Comment.self, from: jsonData)
        
        XCTAssertEqual(sut.postId, 2)
        XCTAssertEqual(sut.id, 6)
        XCTAssertEqual(sut.name, "et fugit eligendi deleniti quidem qui sint nihil autem")
        XCTAssertEqual(sut.email, "Presley.Mueller@myrl.com")
        XCTAssertEqual(sut.body, "doloribus at sed quis culpa deserunt consectetur qui praesentium\naccusamus")
    }
}
