//
//  PostDetailsViewModelTests.swift
//  unit-tests
//
//  Created by Nestor Garcia on 18/06/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import XCTest
@testable import tuit

class PostDetailsViewModelTests: XCTestCase {

    var vm: PostDetailsViewModel!
    var typicodeServiceMock: TypicodeServiceMock!
    let post = PostMock.sample1
    
    override func setUp() {
        super.setUp()
        typicodeServiceMock = TypicodeServiceMock()
    }
    
    func testIntialState_Normal() {
        vm = PostDetailsViewModel(post: post, typicodeService: typicodeServiceMock)
        XCTAssertEqual(vm.screenTitle, NSLocalizedString("post-details-navigation-bar-title"))
        XCTAssertEqual(vm.alertErrorTitle, NSLocalizedString("alert-error-title"))
        XCTAssertEqual(vm.loadingMessage, NSLocalizedString("post-details-loading"))
        XCTAssertEqual(vm.moreLikeThisTitle, NSLocalizedString("post-details-more-like-this-button-title"))
        XCTAssertEqual(vm.postTitle, post.title)
        XCTAssertEqual(vm.postSubtitle, post.body)
    }
    
    func testFetchComments_Success() {
        let comments = [CommentMock.sample1, CommentMock.sample2, CommentMock.sample3]
        typicodeServiceMock.nextFetchCommentsResult = .success(comments)
        
        vm = PostDetailsViewModel(post: post, typicodeService: typicodeServiceMock)
        
        XCTAssertNil(vm.errorMessage)
        XCTAssertEqual(vm.cellViewModels?.count, 3)
        XCTAssertEqual(vm.cellViewModels?.compactMap { $0.name }, comments.map { $0.name })
        XCTAssertEqual(vm.cellViewModels?.compactMap { $0.body }, comments.map { $0.body })
    }
    
    func testFetchCommments_Failure() {
        typicodeServiceMock.nextFetchCommentsResult = .failure(.generic(message: "An Error"))
        
        vm = PostDetailsViewModel(post: post, typicodeService: typicodeServiceMock)
        
        XCTAssertEqual(vm.errorMessage, TypicodeError.generic(message: "An Error").description)
        XCTAssertNil(vm.cellViewModels)
    }
}
