//
//  TypicodeRouterTests.swift
//  unit-tests
//
//  Created by Nestor Garcia on 17/06/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import XCTest
@testable import tuit

final class TypicodeRouterTests: XCTestCase {
    
    func testPost() {
        let sut = TypicodeRouter.posts()
        
        XCTAssertNotNil(sut)
        XCTAssertNotNil(sut?.url)
        XCTAssertEqual(sut?.httpMethod, "GET")
        XCTAssertEqual(sut!.url!.absoluteString, "https://jsonplaceholder.typicode.com/posts")
    }
    
    func testComments_PostId_10() {
        let sut = TypicodeRouter.comments(for: 10)
        
        XCTAssertNotNil(sut)
        XCTAssertNotNil(sut?.url)
        XCTAssertEqual(sut?.httpMethod, "GET")
        XCTAssertEqual(sut!.url!.absoluteString, "https://jsonplaceholder.typicode.com/posts/10/comments")
    }
    
    func testComments_PostId_1234() {
        let sut = TypicodeRouter.comments(for: 1234)
        
        XCTAssertNotNil(sut)
        XCTAssertNotNil(sut?.url)
        XCTAssertEqual(sut?.httpMethod, "GET")
        XCTAssertEqual(sut!.url!.absoluteString, "https://jsonplaceholder.typicode.com/posts/1234/comments")
    }
}
