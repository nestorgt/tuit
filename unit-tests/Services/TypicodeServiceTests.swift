//
//  TypicodeServiceTests.swift
//  unit-tests
//
//  Created by Nestor Garcia on 17/06/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import XCTest
@testable import tuit

final class TypicodeServiceTests: XCTestCase {

    var apiServiceMock: APIServiceMock!
    var sut: TypicodeServiceProtocol!
    
    var postsResult: Result<[Post], TypicodeError>!
    var commentsResult: Result<[Comment], TypicodeError>!
    
    override func setUp() {
        super.setUp()
        apiServiceMock = APIServiceMock()
        sut = TypicodeService(apiService: apiServiceMock)
    }
    
    // MARK: - Tests
    
    func testFetchPosts_Success() {
        let expectation = XCTestExpectation(description: "Performs a request")
        let data = PostMock.sampleDataResponse
        apiServiceMock.nextResult = .success(data)
        
        sut.fetchPosts { [weak self] r in
            self?.postsResult = r
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
        
        XCTAssertTrue(postsResult.isSuccess)
        let expectedResponse = try! JSONDecoder.tuit.decode([Post].self, from: data)
        XCTAssertEqual(postsResult.value, expectedResponse)
    }
    
    func testFetchPosts_Failure() {
        let expectation = XCTestExpectation(description: "Performs a request")
        apiServiceMock.nextResult = .failure(.notFound)
        
        sut.fetchPosts { [weak self] r in
            self?.postsResult = r
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
        
        XCTAssertTrue(postsResult.isFailure)
        XCTAssertEqual(postsResult.error as? TypicodeError, TypicodeError.api(.notFound))
    }
    
    func testFetchComments_Success() {
        let expectation = XCTestExpectation(description: "Performs a request")
        let data = CommentMock.sampleDataResponse
        apiServiceMock.nextResult = .success(data)
        
        sut.fetchComments(for: 10) { [weak self] r in
            self?.commentsResult = r
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
        
        XCTAssertTrue(commentsResult.isSuccess)
        let expectedResponse = try! JSONDecoder.tuit.decode([Comment].self, from: data)
        XCTAssertEqual(commentsResult.value, expectedResponse)
    }
    
    func testFetchComments_Failure() {
        let expectation = XCTestExpectation(description: "Performs a request")
        apiServiceMock.nextResult = .failure(.badRequest)
        
        sut.fetchComments(for: 10) { [weak self] r in
            self?.commentsResult = r
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
        
        XCTAssertTrue(commentsResult.isFailure)
        XCTAssertEqual(commentsResult.error as? TypicodeError, TypicodeError.api(.badRequest))
    }
}
