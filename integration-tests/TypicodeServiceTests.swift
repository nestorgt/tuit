//
//  TypicodeServiceTests.swift
//  integration-tests
//
//  Created by Nestor Garcia on 17/06/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import XCTest
@testable import tuit

final class TypicodeServiceTests: XCTestCase {

    var typicodeService: TypicodeServiceProtocol!
    
    override func setUp() {
        super.setUp()
        typicodeService = TypicodeService(apiService: APIService())
    }
    
    // MARK: - Tests

    func testFetchPosts() {
        var result: Result<[Post], TypicodeError>!
        let expectation = XCTestExpectation(description: "Performs a request")
        
        typicodeService.fetchPosts(completion: { r in
            result = r
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 2)

        XCTAssertTrue(result.isSuccess)
        XCTAssertNotNil(result.value)
        XCTAssertEqual(result.value?.count, 100)
    }
    
    func testFetchComments_PostId_1() {
        var result: Result<[Comment], TypicodeError>!
        let expectation = XCTestExpectation(description: "Performs a request")
        
        typicodeService.fetchComments(for: 1) { r in
            result = r
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)

        XCTAssertTrue(result.isSuccess)
        XCTAssertNotNil(result.value)
        XCTAssertEqual(result.value?.count, 5)
    }
    
    func testFetchComments_PostId_2() {
        var result: Result<[Comment], TypicodeError>!
        let expectation = XCTestExpectation(description: "Performs a request")
        
        typicodeService.fetchComments(for: 2) { r in
            result = r
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)

        XCTAssertTrue(result.isSuccess)
        XCTAssertNotNil(result.value)
        XCTAssertEqual(result.value?.count, 5)
    }
}
